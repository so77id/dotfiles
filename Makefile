LN_COMMAND=ln -s -f
CURL_COMMAND=curl -L

DOTFILES_FOLDER=$(PWD)

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


all: exec

exec:
	@echo "[Configuring Zsh]"
	@echo "Downloading antigen files."
	@$(CURL_COMMAND) $(ANTIGET_REPOSITORY) > $(ZSH_FOLDER)/$(ANTIGEN_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ANTIGEN_FILE) ~/.$(ANTIGEN_FILE)
	@echo "Creating symbolic link for zsh files."
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_FILE) ~/$(ZSHRC_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_LOCAL_FILE) ~/$(ZSHRC_LOCAL_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(P10K_FILE) ~/$(P10K_FILE)
	@echo "[Configuring Tmux]"
	@echo "Creating symbolic link for tmux files."
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_FILE) ~/$(TMUXCONF_FILE)
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_LOCAL_FILE) ~/$(TMUXCONF_LOCAL_FILE)
	@echo "[Configuring Git]"
	@echo "Creating symbolic link for git files."
	@$(LN_COMMAND) $(GIT_FOLDER)/$(GITCONFIG_FILE) ~/$(GITCONFIG_FILE)
	@$(LN_COMMAND) $(GIT_FOLDER)/$(GITIGNORE_FILE) ~/.$(GITIGNORE_FILE)

.PHONY: all exec
