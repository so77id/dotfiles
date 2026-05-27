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

.PHONY: all install symlinks brew_install brew_packages omz plugins iterm2 mac_install linux_install dotfiles_link

all: install

install: $(RUN_FUNCTION)

# ------------------------------------------------------------
# Bootstrap macOS completo
# ------------------------------------------------------------
mac_install: brew_install brew_packages omz plugins symlinks iterm2
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
# Detectar prefix según arquitectura (M1+ vs Intel)
BREW_PREFIX := $(shell [ -x /opt/homebrew/bin/brew ] && echo /opt/homebrew || ([ -x /usr/local/bin/brew ] && echo /usr/local))

brew_install:
	@echo "[Homebrew] Verificando instalación..."
	@if [ -n "$(BREW_PREFIX)" ]; then \
		echo "  ✓ Homebrew ya está instalado en $(BREW_PREFIX). Saltando."; \
	else \
		echo "  Instalando Homebrew..."; \
		NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi

brew_packages:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	if ! command -v gum >/dev/null 2>&1; then \
		echo "[Setup] Instalando gum (necesario para UI con spinners)..."; \
		brew install gum; \
	fi
	@echo ""
	@echo "═══ [Homebrew] Formulae ═══"
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	PKGS=$$(cat $(BREW_FOLDER)/$(BREW_NON_CASK_FILE)); \
	TOTAL=$$(echo "$$PKGS" | wc -l | tr -d ' '); \
	I=0; \
	for pkg in $$PKGS; do \
		I=$$((I + 1)); \
		if brew list --formula "$$pkg" >/dev/null 2>&1; then \
			printf "  [%2d/%d] \033[90m✓ %s (ya instalado)\033[0m\n" $$I $$TOTAL "$$pkg"; \
		else \
			LOG=/tmp/brew-$$pkg.log; \
			if gum spin --spinner dot --title "[$$I/$$TOTAL] $$pkg..." -- bash -c "brew install '$$pkg' > '$$LOG' 2>&1"; then \
				printf "  [%2d/%d] \033[32m✓ %s\033[0m\n" $$I $$TOTAL "$$pkg"; \
			else \
				printf "  [%2d/%d] \033[31m✗ %s\033[0m — últimas líneas de %s:\n" $$I $$TOTAL "$$pkg" "$$LOG"; \
				tail -8 "$$LOG" | sed 's/^/        /'; \
			fi; \
		fi; \
	done
	@echo ""
	@echo "═══ [Homebrew] Casks (apps GUI) ═══"
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	CASKS=$$(cat $(BREW_FOLDER)/$(BREW_CASK_FILE)); \
	TOTAL=$$(echo "$$CASKS" | wc -l | tr -d ' '); \
	I=0; \
	for cask in $$CASKS; do \
		I=$$((I + 1)); \
		if brew list --cask "$$cask" >/dev/null 2>&1; then \
			printf "  [%2d/%d] \033[90m✓ %s (ya instalado)\033[0m\n" $$I $$TOTAL "$$cask"; \
		else \
			LOG=/tmp/brew-cask-$$cask.log; \
			if gum spin --spinner dot --title "[$$I/$$TOTAL] $$cask..." -- bash -c "brew install --cask --adopt '$$cask' > '$$LOG' 2>&1"; then \
				printf "  [%2d/%d] \033[32m✓ %s\033[0m\n" $$I $$TOTAL "$$cask"; \
			else \
				printf "  [%2d/%d] \033[31m✗ %s\033[0m — últimas líneas de %s:\n" $$I $$TOTAL "$$cask" "$$LOG"; \
				tail -8 "$$LOG" | sed 's/^/        /'; \
			fi; \
		fi; \
	done
	@echo ""
	@echo "═══ [Mac App Store] ═══"
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	if [ -s $(BREW_FOLDER)/$(MAS_FILE) ]; then \
		IDS=$$(cat $(BREW_FOLDER)/$(MAS_FILE)); \
		TOTAL=$$(echo "$$IDS" | wc -l | tr -d ' '); \
		I=0; \
		for id in $$IDS; do \
			I=$$((I + 1)); \
			if mas list 2>/dev/null | awk '{print $$1}' | grep -qx "$$id"; then \
				printf "  [%2d/%d] \033[90m✓ id:%s (ya instalado)\033[0m\n" $$I $$TOTAL "$$id"; \
			else \
				LOG=/tmp/mas-$$id.log; \
				if gum spin --spinner dot --title "[$$I/$$TOTAL] App Store id:$$id..." -- bash -c "mas get '$$id' > '$$LOG' 2>&1"; then \
					printf "  [%2d/%d] \033[32m✓ id:%s\033[0m\n" $$I $$TOTAL "$$id"; \
				else \
					printf "  [%2d/%d] \033[31m✗ id:%s\033[0m — \033[33mhazlo manual:\033[0m\n" $$I $$TOTAL "$$id"; \
					printf "        1. Abre App Store, busca la app por id (mas open %s)\n" "$$id"; \
					printf "        2. Click en 'Get/Obtener' (solo necesario la primera vez)\n"; \
					printf "        3. Vuelve a correr 'make install'\n"; \
					printf "        Log: %s\n" "$$LOG"; \
				fi; \
			fi; \
		done; \
	fi
	@echo ""
	@echo "═══ [fzf] Key bindings ═══"
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	if [ -x "$$(brew --prefix)/opt/fzf/install" ]; then \
		gum spin --spinner dot --title "Configurando fzf..." -- bash -c "yes | \"$$(brew --prefix)/opt/fzf/install\" --key-bindings --completion --no-update-rc >/dev/null"; \
		printf "  \033[32m✓ fzf configurado\033[0m\n"; \
	else \
		printf "  \033[33m⚠ fzf no encontrado, saltando\033[0m\n"; \
	fi

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------
omz:
	@echo ""
	@echo "═══ [Oh My Zsh] ═══"
	@if [ -d "$(OMZ_DIR)" ]; then \
		printf "  \033[90m✓ Oh My Zsh (ya instalado)\033[0m\n"; \
	else \
		LOG=/tmp/omz-install.log; \
		if gum spin --spinner dot --title "Instalando Oh My Zsh..." -- bash -c "sh -c \"\$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" '' --unattended --keep-zshrc > '$$LOG' 2>&1"; then \
			printf "  \033[32m✓ Oh My Zsh instalado\033[0m\n"; \
		else \
			printf "  \033[31m✗ Falló Oh My Zsh\033[0m — log: %s\n" "$$LOG"; \
			tail -8 "$$LOG" | sed 's/^/        /'; \
		fi; \
	fi

# ------------------------------------------------------------
# Plugins zsh + tema p10k
# ------------------------------------------------------------
plugins:
	@echo ""
	@echo "═══ [Plugins zsh] ═══"
	@TOTAL=3; I=0; \
	for entry in "powerlevel10k|$(P10K_DIR)|https://github.com/romkatv/powerlevel10k.git" \
	             "zsh-autosuggestions|$(AUTOSUGGEST_DIR)|https://github.com/zsh-users/zsh-autosuggestions" \
	             "fast-syntax-highlighting|$(FAST_HL_DIR)|https://github.com/zdharma-continuum/fast-syntax-highlighting"; do \
		I=$$((I + 1)); \
		NAME=$$(echo "$$entry" | cut -d'|' -f1); \
		DIR=$$(echo "$$entry" | cut -d'|' -f2); \
		URL=$$(echo "$$entry" | cut -d'|' -f3); \
		if [ -d "$$DIR" ]; then \
			printf "  [%d/%d] \033[90m✓ %s (ya instalado)\033[0m\n" $$I $$TOTAL "$$NAME"; \
		else \
			LOG=/tmp/plugin-$$NAME.log; \
			if gum spin --spinner dot --title "[$$I/$$TOTAL] $$NAME..." -- bash -c "git clone --depth=1 '$$URL' '$$DIR' > '$$LOG' 2>&1"; then \
				printf "  [%d/%d] \033[32m✓ %s\033[0m\n" $$I $$TOTAL "$$NAME"; \
			else \
				printf "  [%d/%d] \033[31m✗ %s\033[0m — log: %s\n" $$I $$TOTAL "$$NAME" "$$LOG"; \
				tail -5 "$$LOG" | sed 's/^/        /'; \
			fi; \
		fi; \
	done

# ------------------------------------------------------------
# iTerm2 color preset (Dynamic Profile)
# ------------------------------------------------------------
ITERM2_DYN_DIR    = $(HOME)/Library/Application Support/iTerm2/DynamicProfiles
ITERM2_PRESET     = $(DOTFILES_FOLDER)/iterm2/AtelierSulphurpool.itermcolors
ITERM2_DYN_FILE   = $(ITERM2_DYN_DIR)/AtelierSulphurpool.json
ITERM2_GUID       = AtelierSulphurpool-dotfiles

iterm2:
	@echo ""
	@echo "═══ [iTerm2] Color preset + font ═══"
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	if ! command -v jq >/dev/null 2>&1; then \
		printf "  \033[33m⚠ jq no encontrado, saltando\033[0m\n"; \
	else \
		mkdir -p "$(ITERM2_DYN_DIR)"; \
		LOG=/tmp/iterm2-preset.log; \
		if gum spin --spinner dot --title "Generando perfil dinámico (colores + fuente)..." -- bash -c "plutil -convert json -o - '$(ITERM2_PRESET)' | jq '{Profiles: [. + {Name: \"AtelierSulphurpool\", Guid: \"$(ITERM2_GUID)\", \"Normal Font\": \"MesloLGSNF-Regular 14\", \"Non Ascii Font\": \"MesloLGSNF-Regular 14\", \"Use Non-ASCII Font\": true, \"ASCII Anti Aliased\": true, \"Non-ASCII Anti Aliased\": true}]}' > '$(ITERM2_DYN_FILE)' 2> '$$LOG'"; then \
			printf "  \033[32m✓ Perfil 'AtelierSulphurpool' generado (con MesloLGS NF)\033[0m\n"; \
		else \
			printf "  \033[31m✗ Falló generación\033[0m — log: %s\n" "$$LOG"; \
			tail -5 "$$LOG" 2>/dev/null | sed 's/^/        /'; \
		fi; \
		defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$(ITERM2_GUID)" 2>/dev/null && \
			printf "  \033[32m✓ Perfil marcado como Default\033[0m\n" || \
			printf "  \033[33m⚠ No pude setear default (hazlo manual)\033[0m\n"; \
	fi
	@printf "  \033[33m→ Reinicia iTerm2 (Cmd+Q y vuelve a abrir) para que cargue el perfil y la fuente\033[0m\n"

# ------------------------------------------------------------
# Symlinks de archivos de configuración
# ------------------------------------------------------------
dotfiles_link:
	@if [ ! -e "$(HOME)/.dotfiles" ]; then \
		ln -s "$(DOTFILES_FOLDER)" "$(HOME)/.dotfiles"; \
		printf "  \033[32m✓ symlink ~/.dotfiles\033[0m\n"; \
	fi

symlinks: dotfiles_link
	@echo ""
	@echo "═══ [Symlinks] ═══"
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_FILE)          $(HOME)/$(ZSHRC_FILE)       && printf "  \033[32m✓\033[0m ~/.zshrc\n"
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_LOCAL_FILE)    $(HOME)/$(ZSHRC_LOCAL_FILE) && printf "  \033[32m✓\033[0m ~/.zshrc.local\n"
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(P10K_FILE)           $(HOME)/$(P10K_FILE)        && printf "  \033[32m✓\033[0m ~/.p10k.zsh\n"
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_FILE)      $(HOME)/$(TMUXCONF_FILE)       && printf "  \033[32m✓\033[0m ~/.tmux.conf\n"
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_LOCAL_FILE) $(HOME)/$(TMUXCONF_LOCAL_FILE) && printf "  \033[32m✓\033[0m ~/.tmux.conf.local\n"
	@$(LN_COMMAND) $(GIT_FOLDER)/$(GITCONFIG_FILE)      $(HOME)/$(GITCONFIG_FILE)   && printf "  \033[32m✓\033[0m ~/.gitconfig\n"
	@$(LN_COMMAND) $(GIT_FOLDER)/$(GITIGNORE_FILE)      $(HOME)/.$(GITIGNORE_FILE)  && printf "  \033[32m✓\033[0m ~/.gitignore\n"
