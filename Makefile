# ============================================================
# Dotfiles installer — macOS (Apple Silicon) / Linux
# ============================================================

UNAME_S := $(shell uname -s)

# Comandos base
LN_COMMAND     = ln -s -f
CURL_COMMAND   = curl -fsSL
DOTFILES_FOLDER = $(PWD)

# Carpetas del repo
ZSH_FOLDER  = $(DOTFILES_FOLDER)/zsh
TMUX_FOLDER = $(DOTFILES_FOLDER)/tmux
GIT_FOLDER  = $(DOTFILES_FOLDER)/git
BREW_FOLDER = $(DOTFILES_FOLDER)/brew

# Archivos zsh
ZSHRC_FILE       = .zshrc
ZSHRC_LOCAL_FILE = .zshrc.local
P10K_FILE        = .p10k.zsh

# Archivos tmux
TMUXCONF_FILE       = .tmux.conf
TMUXCONF_LOCAL_FILE = .tmux.conf.local

# Archivos git
GITCONFIG_FILE = .gitconfig
GITIGNORE_FILE = gitignore

# Brew listas
BREW_NON_CASK_FILE = non_cask.txt
BREW_CASK_FILE     = cask.txt
MAS_FILE           = from_app_store.txt

# Oh My Zsh + plugins (paths)
OMZ_DIR         = $(HOME)/.oh-my-zsh
OMZ_CUSTOM      = $(OMZ_DIR)/custom
P10K_DIR        = $(OMZ_CUSTOM)/themes/powerlevel10k
AUTOSUGGEST_DIR = $(OMZ_CUSTOM)/plugins/zsh-autosuggestions
FAST_HL_DIR     = $(OMZ_CUSTOM)/plugins/fast-syntax-highlighting

# Detectar OS y elegir target principal
ifeq ($(UNAME_S),Darwin)
RUN_FUNCTION = mac_install
endif
ifeq ($(UNAME_S),Linux)
RUN_FUNCTION = linux_install
endif

.PHONY: all install symlinks brew_install brew_packages omz plugins mac_install linux_install dotfiles_link

all: install

install: $(RUN_FUNCTION)

# ------------------------------------------------------------
# Bootstrap macOS completo
# ------------------------------------------------------------
mac_install: brew_install brew_packages omz plugins symlinks
	@echo ""
	@echo "[OK] Instalación completa. Abre una nueva terminal o corre: source ~/.zshrc"

# ------------------------------------------------------------
# Linux (esqueleto)
# ------------------------------------------------------------
linux_install: omz plugins symlinks
	@echo "[OK] Instalación Linux completa (sin brew)."

# ------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------
brew_install:
	@echo "[Homebrew] Verificando instalación..."
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "  Instalando Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	else \
		echo "  Homebrew ya está instalado."; \
	fi

brew_packages:
	@echo "[Homebrew] Instalando formulae..."
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	brew install $$(cat $(BREW_FOLDER)/$(BREW_NON_CASK_FILE))
	@echo "[Homebrew] Instalando casks..."
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	brew install --cask $$(cat $(BREW_FOLDER)/$(BREW_CASK_FILE))
	@echo "[Homebrew] Apps del Mac App Store..."
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	if [ -s $(BREW_FOLDER)/$(MAS_FILE) ]; then \
		mas install $$(cat $(BREW_FOLDER)/$(MAS_FILE)) || true; \
	fi
	@echo "[fzf] Instalando key bindings..."
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	yes | $$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc >/dev/null

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------
omz:
	@echo "[Oh My Zsh] Verificando instalación..."
	@if [ ! -d "$(OMZ_DIR)" ]; then \
		echo "  Instalando Oh My Zsh..."; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc; \
	else \
		echo "  Oh My Zsh ya está instalado."; \
	fi

# ------------------------------------------------------------
# Plugins zsh + tema p10k
# ------------------------------------------------------------
plugins:
	@echo "[Plugins zsh] Instalando..."
	@if [ ! -d "$(P10K_DIR)" ]; then \
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$(P10K_DIR)"; \
	else \
		echo "  powerlevel10k ya está instalado."; \
	fi
	@if [ ! -d "$(AUTOSUGGEST_DIR)" ]; then \
		git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$(AUTOSUGGEST_DIR)"; \
	else \
		echo "  zsh-autosuggestions ya está instalado."; \
	fi
	@if [ ! -d "$(FAST_HL_DIR)" ]; then \
		git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting "$(FAST_HL_DIR)"; \
	else \
		echo "  fast-syntax-highlighting ya está instalado."; \
	fi

# ------------------------------------------------------------
# Symlinks de archivos de configuración
# ------------------------------------------------------------
dotfiles_link:
	@if [ ! -e "$(HOME)/.dotfiles" ]; then \
		echo "[Symlink] ~/.dotfiles -> $(DOTFILES_FOLDER)"; \
		ln -s "$(DOTFILES_FOLDER)" "$(HOME)/.dotfiles"; \
	fi

symlinks: dotfiles_link
	@echo "[Symlinks] zsh"
	$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_FILE)       $(HOME)/$(ZSHRC_FILE)
	$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_LOCAL_FILE) $(HOME)/$(ZSHRC_LOCAL_FILE)
	$(LN_COMMAND) $(ZSH_FOLDER)/$(P10K_FILE)        $(HOME)/$(P10K_FILE)
	@echo "[Symlinks] tmux"
	$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_FILE)       $(HOME)/$(TMUXCONF_FILE)
	$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_LOCAL_FILE) $(HOME)/$(TMUXCONF_LOCAL_FILE)
	@echo "[Symlinks] git"
	$(LN_COMMAND) $(GIT_FOLDER)/$(GITCONFIG_FILE) $(HOME)/$(GITCONFIG_FILE)
	$(LN_COMMAND) $(GIT_FOLDER)/$(GITIGNORE_FILE) $(HOME)/.$(GITIGNORE_FILE)
