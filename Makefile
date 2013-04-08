install: install_zsh install_vim install_tmux

install_zsh:
	rm -f ~/.zshenv;
	ln -s `pwd`/zsh/zshenv ~/.zshenv
	rm -f ~/.zshrc;
	ln -s `pwd`/zsh/zshrc ~/.zshrc
	mkdir -p ~/.zsh;
	test -f ~/.zsh/zshenv-local || cp `pwd`/zsh/zshenv-local.sample ~/.zsh/zshenv-local
	test -f ~/.zsh/zshrc-local || cp `pwd`/zsh/zshrc-local.sample ~/.zsh/zshrc-local
	git submodule update --init
	rm -rf ~/.zsh/addons
	ln -s `pwd`/zsh/addons ~/.zsh

install_vim:
	git submodule update --init
	rm -f ~/.vimrc;
	ln -s `pwd`/vim/vimrc ~/.vimrc
	mkdir -p ~/.vim;
	rm -rf ~/.vim/vundle;
	ln -s `pwd`/vim/vundle ~/.vim/vundle
	rm -rf ~/.vim/templates;
	ln -s `pwd`/vim/tiny-templates ~/.vim/templates
	rm -rf ~/.vim/snippets;
	ln -s `pwd`/vim/snippets ~/.vim/snippets
	test -f ~/.vim/vimrc-local || cp `pwd`/vim/vimrc-local.sample ~/.vim/vimrc-local
	vim -c :BundleInstall -c :quitall
	test -d ~/.vim/bundle && cd ~/.vim/bundle/jedi-vim; git submodule update --init

install_tmux:
	rm -f ~/.tmux.conf;
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf
	mkdir -p ~/.tmux
	test -f ~/.tmux/local.conf || cp `pwd`/tmux/local.conf.sample ~/.tmux/local.conf

install_screen:
	rm -f ~/.screenrc;
	ln -s `pwd`/screen/screenrc ~/.screenrc

install_newsbeuter:
	mkdir -p ~/.newsbeuter;
	rm -f ~/.newsbeuter/config;
	ln -s `pwd`/newsbeuter/config ~/.newsbeuter/config
	test -f ~/.newsbeuter/config-local || cp `pwd`/newsbeuter/config-local.sample ~/.newsbeuter/config-local

.PHONY: install
.PHONY: install_zsh
.PHONY: install_vim
.PHONY: install_tmux install_screen
.PHONY: install_newsbeuter
