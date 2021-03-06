install: install_zsh install_vim install_tmux

PWD=$(shell pwd)

GIT_AVAILABLE=$(shell test -x "$(shell which git)" && echo 1)
ifeq ($(GIT_AVAILABLE),1)
submodule:
	git submodule update --init
else
submodule:
	curl -Lo - https://github.com/gmarik/vundle/archive/master.tar.gz | \
		tar xf - -C vim/ -s '|^\(.*\)-master/|\1/|'
	curl -Lo - https://github.com/uchida/tiny-templates/archive/master.tar.gz | \
		tar xf - -C vim/ -s '|^\(.*\)-master/|\1/|'
	curl -Lo - https://github.com/rupa/z/archive/master.tar.gz | \
		tar xf - -C shell/ -s '|^\(.*\)-master/|\1/|'
	curl -Lo - https://github.com/zsh-users/zsh-completions/archive/master.tar.gz | \
		tar xf - -C zsh/ -s '|^\(.*\)-master/|\1/|'
endif

install_shcommon: submodule
	mkdir -p $(HOME)/.shell
	rm -f $(HOME)/.shell/profile
	ln -s $(PWD)/shell/profile $(HOME)/.shell/
	mkdir -p $(HOME)/.shell
	rm -f $(HOME)/.shell/rc
	ln -s $(PWD)/shell/rc $(HOME)/.shell/
	test -f $(HOME)/.shell/profile-local || cp $(PWD)/shell/profile-local.sample $(HOME)/.shell/profile-local
	test -f $(HOME)/.shell/rc-local || cp $(PWD)/shell/rc-local.sample $(HOME)/.shell/rc-local
	mkdir -p $(HOME)/.shell/scripts
	rm -rf $(HOME)/.shell/scripts/z
	ln -s $(PWD)/shell/z $(HOME)/.shell/scripts/
	mkdir -p $(HOME)/.shell/cache
	touch $(HOME)/.shell/cache/z

BASH_VERSION=$(shell bash --version | head -n 1 | sed -e 's/.*version \([.0-9]*\).*/\1/' | cut -d. -f 1,2)
ifeq ($(GIT_AVAILABLE),1)
install_bashcompletion:
	rm -f $(HOME)/.shell/completion;
	test $(shell echo "2.04 <= $(BASH_VERSION) && $(BASH_VERSION) < 3.2" | bc) -eq 1 && \
		(cd $(PWD)/bash/bash-completion && git checkout 1.1) || :
	test $(shell echo "3.2 <= $(BASH_VERSION) && $(BASH_VERSION) < 4.1" | bc) -eq 1 && \
		(cd $(PWD)/bash/bash-completion && git checkout 1.3) || :
	test $(shell echo "4.1 <= $(BASH_VERSION)" | bc) -eq 1 && \
		(cd $(PWD)/bash/bash-completion && git checkout 2.1) || :
	ln -s $(PWD)/bash/bash-completion $(HOME)/.shell/completion)
else
install_bashcompletion:
	test $(shell echo "2.04 <= $(BASH_VERSION) && $(BASH_VERSION) < 3.2" | bc) -eq 1 && \
		curl -Lo - https://github.com/uchida/bash-completion/archive/1.1.tar.gz | \
		tar xf - -C $(PWD)/bash -s '|^[a-z\-]*-[.0-9]*/|bash-completion/|' || :
	test $(shell echo "3.2 <= $(BASH_VERSION) && $(BASH_VERSION) < 4.1" | bc) -eq 1 && \
		curl -Lo - https://github.com/uchida/bash-completion/archive/1.3.tar.gz | \
		tar xf - -C $(PWD)/bash -s '|^[a-z\-]*-[.0-9]*/|bash-completion/|' || :
	test $(shell echo "4.1 <= $(BASH_VERSION)" | bc) -eq 1 && \
		curl -Lo - https://github.com/uchida/bash-completion/archive/2.1.tar.gz | \
		tar xf - -C $(PWD)/bash -s '|^[a-z\-]*-[.0-9]*/|bash-completion/|' || :
	rm -f $(HOME)/.shell/completion;
	ln -s $(PWD)/bash/bash-completion $(HOME)/.shell/completion
endif

install_bash: install_shcommon install_bashcompletion
	rm -f $(HOME)/.bash_profile;
	ln -s $(PWD)/bash/bash_profile $(HOME)/.bash_profile
	rm -f $(HOME)/.bashrc;
	ln -s $(PWD)/bash/bashrc $(HOME)/.bashrc
	test -f $(HOME)/.shell/bashrc-local || cp $(PWD)/bash/bashrc-local.sample $(HOME)/.shell/bashrc-local
	rm -f $(HOME)/.shell/completion;
	ln -s $(PWD)/bash/bash-completion $(HOME)/.shell/completion

install_zsh: install_shcommon
	rm -f $(HOME)/.zshenv;
	ln -s $(PWD)/zsh/zshenv $(HOME)/.zshenv
	rm -f $(HOME)/.zshrc;
	ln -s $(PWD)/zsh/zshrc $(HOME)/.zshrc
	test -f $(HOME)/.shell/zshrc-local || cp $(PWD)/zsh/zshrc-local.sample $(HOME)/.shell/zshrc-local
	rm -rf $(HOME)/.shell/zsh-completions
	ln -s $(PWD)/zsh/zsh-completions $(HOME)/.shell/

install_vim: submodule
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
.PHONY: submodule
.PHONY: install_shcommon
.PHONY: install_bashcompletion
.PHONY: install_bash
.PHONY: install_zsh
.PHONY: install_vim
.PHONY: install_tmux install_screen
.PHONY: install_newsbeuter
