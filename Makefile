install: install_zsh install_vim install_tmux

PWD=$(shell pwd)

install_zsh:
	rm -f $(HOME)/.zshenv;
	ln -s $(PWD)/zsh/zshenv $(HOME)/.zshenv
	rm -f $(HOME)/.zshrc;
	ln -s $(PWD)/zsh/zshrc $(HOME)/.zshrc
	mkdir -p $(HOME)/.zsh/cache
	test -f $(HOME)/.zsh/zshenv-local || cp $(PWD)/zsh/zshenv-local.sample $(HOME)/.zsh/zshenv-local
	test -f $(HOME)/.zsh/zshrc-local || cp $(PWD)/zsh/zshrc-local.sample $(HOME)/.zsh/zshrc-local
	git submodule update --init
	rm -rf $(HOME)/.zsh/addons;
	ln -s $(PWD)/zsh/addons $(HOME)/.zsh
	touch $(HOME)/.zsh/cache/z

install_vim:
	git submodule update --init
	rm -f $(HOME)/.vimrc;
	ln -s $(PWD)/vim/vimrc $(HOME)/.vimrc
	mkdir -p $(HOME)/.vim;
	rm -rf $(HOME)/.vim/vundle;
	ln -s $(PWD)/vim/vundle $(HOME)/.vim/vundle
	rm -rf $(HOME)/.vim/templates;
	ln -s $(PWD)/vim/tiny-templates $(HOME)/.vim/templates
	rm -rf $(HOME)/.vim/snippets;
	ln -s $(PWD)/vim/snippets $(HOME)/.vim/snippets
	test -f $(HOME)/.vim/vimrc-local || cp $(PWD)/vim/vimrc-local.sample $(HOME)/.vim/vimrc-local
	vim -c :BundleInstall -c :quitall
	test -d $(HOME)/.vim/bundle && cd $(HOME)/.vim/bundle/jedi-vim; git submodule update --init

install_tmux:
	rm -f $(HOME)/.tmux.conf;
	ln -s $(PWD)/tmux/tmux.conf $(HOME)/.tmux.conf
	mkdir -p $(HOME)/.tmux
	test -f $(HOME)/.tmux/local.conf || cp $(PWD)/tmux/local.conf.sample $(HOME)/.tmux/local.conf

install_screen:
	rm -f $(HOME)/.screenrc;
	ln -s $(PWD)/screen/screenrc $(HOME)/.screenrc

install_newsbeuter:
	mkdir -p $(HOME)/.newsbeuter;
	rm -f $(HOME)/.newsbeuter/config;
	ln -s $(PWD)/newsbeuter/config $(HOME)/.newsbeuter/config
	test -f $(HOME)/.newsbeuter/config-local || cp $(PWD)/newsbeuter/config-local.sample $(HOME)/.newsbeuter/config-local

.PHONY: install
.PHONY: install_zsh
.PHONY: install_vim
.PHONY: install_tmux install_screen
.PHONY: install_newsbeuter
