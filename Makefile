LN_COMMAND=ln -s -f
CURL_COMMAND=curl -L

# ZSH VARS
ZSH_FOLDER=$(PWD)/zsh
ZSHRC_FILE=.zshrc
ZSHRC_LOCAL_FILE=.zshrc.local

ANTIGET_REPOSITORY=git.io/antigen
ANTIGEN_FILE=antigen.zsh


# TMUX VARS
TMUX_FOLDER=$(PWD)/tmux
TMUXCONF_FILE=.tmux.conf
TMUXCONF_LOCAL_FILE=.tmux.conf.local


all: exec

exec:
	@echo "[Configuring Zsh]"
	@echo "Downloading antigen files."
	@$(CURL_COMMAND) $(ANTIGET_REPOSITORY) > $(ZSH_FOLDER)/$(ANTIGEN_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ANTIGEN_FILE) ~/.$(ANTIGEN_FILE)
	@echo "Creating symbolic link for zsh files."
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_FILE) ~/$(ZSHRC_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_LOCAL_FILE) ~/$(ZSHRC_LOCAL_FILE)
	@echo "[Configuring Tmux]"
	@echo "Creating symbolic link for tmux files."
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_FILE) ~/$(TMUXCONF_FILE)
	@$(LN_COMMAND) $(TMUX_FOLDER)/$(TMUXCONF_LOCAL_FILE) ~/$(TMUXCONF_LOCAL_FILE)

.PHONY: all exec