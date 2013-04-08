install: install_zsh install_vim install_tmux

install_zsh:
	rm -f $(HOME)/.zshenv;
	ln -s `pwd`/zsh/zshenv $(HOME)/.zshenv
	rm -f $(HOME)/.zshrc;
	ln -s `pwd`/zsh/zshrc $(HOME)/.zshrc
	mkdir -p $(HOME)/.zsh;
	test -f $(HOME)/.zsh/zshenv-local || cp `pwd`/zsh/zshenv-local.sample $(HOME)/.zsh/zshenv-local
	test -f $(HOME)/.zsh/zshrc-local || cp `pwd`/zsh/zshrc-local.sample $(HOME)/.zsh/zshrc-local
	git submodule update --init
	rm -rf $(HOME)/.zsh/addons
	ln -s `pwd`/zsh/addons $(HOME)/.zsh

install_vim:
	git submodule update --init
	rm -f $(HOME)/.vimrc;
	ln -s `pwd`/vim/vimrc $(HOME)/.vimrc
	mkdir -p $(HOME)/.vim;
	rm -rf $(HOME)/.vim/vundle;
	ln -s `pwd`/vim/vundle $(HOME)/.vim/vundle
	rm -rf $(HOME)/.vim/templates;
	ln -s `pwd`/vim/tiny-templates $(HOME)/.vim/templates
	rm -rf $(HOME)/.vim/snippets;
	ln -s `pwd`/vim/snippets $(HOME)/.vim/snippets
	test -f $(HOME)/.vim/vimrc-local || cp `pwd`/vim/vimrc-local.sample $(HOME)/.vim/vimrc-local
	vim -c :BundleInstall -c :quitall
	test -d $(HOME)/.vim/bundle && cd $(HOME)/.vim/bundle/jedi-vim; git submodule update --init

install_tmux:
	rm -f $(HOME)/.tmux.conf;
	ln -s `pwd`/tmux/tmux.conf $(HOME)/.tmux.conf
	mkdir -p $(HOME)/.tmux
	test -f $(HOME)/.tmux/local.conf || cp `pwd`/tmux/local.conf.sample $(HOME)/.tmux/local.conf

install_screen:
	rm -f $(HOME)/.screenrc;
	ln -s `pwd`/screen/screenrc $(HOME)/.screenrc

install_newsbeuter:
	mkdir -p $(HOME)/.newsbeuter;
	rm -f $(HOME)/.newsbeuter/config;
	ln -s `pwd`/newsbeuter/config $(HOME)/.newsbeuter/config
	test -f $(HOME)/.newsbeuter/config-local || cp `pwd`/newsbeuter/config-local.sample $(HOME)/.newsbeuter/config-local

.PHONY: install
.PHONY: install_zsh
.PHONY: install_vim
.PHONY: install_tmux install_screen
.PHONY: install_newsbeuter
