LN_COMMAND=ln -s -f


ZSH_FOLDER=$(PWD)/zsh
ZSHRC_FILE=.zshrc
ZSHRC_LOCAL_FILE=.zshrc.local


all: exec

exec:
	@echo "Creating symbolic link for zsh files."
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_FILE) ~/$(ZSHRC_FILE)
	@$(LN_COMMAND) $(ZSH_FOLDER)/$(ZSHRC_LOCAL_FILE) ~/$(ZSHRC_LOCAL_FILE)

.PHONY: all exec