# Detect operating system
UNAME_S := $(shell uname -s)

# LINUX_COMMANDS
LN_COMMAND=ln -s -f
CURL_COMMAND=curl -L
DOTFILES_FOLDER=$(PWD)
MAKE_COMMAND=make

# Zsh vars
ZSH_FOLDER=$(DOTFILES_FOLDER)/zsh
ZSHRC_FILE=.zshrc
ZSHRC_LOCAL_FILE=.zshrc.local
P10K_FILE=.p10k.zsh

ANTIGET_REPOSITORY=git.io/antigen
ANTIGEN_FILE=antigen.zsh

# Tmux vars
TMUX_FOLDER=$(DOTFILES_FOLDER)/tmux
TMUXCONF_FILE=.tmux.conf
TMUXCONF_LOCAL_FILE=.tmux.conf.local

# Git vars
GIT_FOLDER=$(DOTFILES_FOLDER)/git
GITCONFIG_FILE=.gitconfig
GITIGNORE_FILE=gitignore

#Brew vars
BREW_FOLDER=$(DOTFILES_FOLDER)/brew
BREW_NON_CASK_FILE=non_cask.txt
BREW_CASK_FILE=cask.txt
MAS_FILE=from_app_store.txt

BREW_INSTALL_COMMAND=/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
BREW_EXEC=eval "$(/opt/homebrew/bin/brew shellenv)"
BREW_COMMAND=brew install
BREW_CASK_COMMAND=brew install --cask
MAS_COMMAND=mas install

#Xcode vars
XCODE_INSTALL_COMMAND=xcode-select --install

# Detect operating system
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
RUN_FUNCTION=linux_instalation_function
endif

ifeq ($(UNAME_S),Darwin)
RUN_FUNCTION=mac_instalation_function
endif


all: exec

unix_instalation_function:
	@echo "[Configuring Zsh]"
	@echo "Downloading antigen files."
	@$(CURL_COMMAND) $(ANTIGET_REPOSITORY) > $(ZSH_FOLDER)/$(ANTIGEN_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ANTIGEN_FILE) ~/.$(ANTIGEN_FILE)
	@echo "Creating symbolic link for zsh files."
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_FILE) ~/$(ZSHRC_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_LOCAL_FILE) ~/$(ZSHRC_LOCAL_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(P10K_FILE) ~/$(P10K_FILE)
	@source ~/.zshrc
	@echo "[Configuring Tmux]"
	@echo "Creating symbolic link for tmux files."
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_FILE) ~/$(TMUXCONF_FILE)
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_LOCAL_FILE) ~/$(TMUXCONF_LOCAL_FILE)
	@echo "[Configuring Git]"
	@echo "Creating symbolic link for git files."
	@$(LN_COMMAND) $(GIT_FOLDER)/$(GITCONFIG_FILE) ~/$(GITCONFIG_FILE)
	@$(LN_COMMAND) $(GIT_FOLDER)/$(GITIGNORE_FILE) ~/.$(GITIGNORE_FILE)


linux_instalation_function:
	@echo "Running instalation for Linux"


mac_instalation_function:
	@echo "Running instalation for macOS"
	@echo "[Installing brew]"
	@$(BREW_INSTALL_COMMAND)
	@$(BREW_EXEC)
	@echo "[Installing apps by brew]"
	$(BREW_COMMAND) $(shell cat ${BREW_FOLDER}/${BREW_NON_CASK_FILE})
	$(BREW_CASK_COMMAND) $(shell cat ${BREW_FOLDER}/${BREW_CASK_FILE})
	$(MAS_COMMAND) $(shell cat ${BREW_FOLDER}/${MAS_FILE})

	@echo "[Installing Xcode]"
	@$(XCODE_INSTALL_COMMAND)
	@echo "[Configuration finished]"



exec:
	@$(MAKE_COMMAND) unix_instalation_function
	@$(MAKE_COMMAND) $(RUN_FUNCTION)


.PHONY: all exec
