# Installation

Installing dotfiles.

1. `cd ~`

2. `git clone https://github.com/beauhoyt/dotfiles`

3. `mv -vf dotfiles/.* dotfiles/* ./`

4. `rmdir dotfiles`

5. Edit `.gitconfig` file and change `name` and `email` to your own.

4. `git submodule update --init --recursive`

# Setting Up Vim


*NOTE:* **Everything requires Pathogen vim plugin.**

1. YouCompleteMe

   A. Vim 7.3.584+

      1. Install for centos: http://sudoers-d.com/blog/2013/01/18/installing-vim-on-centos-6-dot-3/

      2. Compile from source: http://www.tylercipriani.com/2013/02/24/install-vim-from-source.html

      3. RPMS: http://download.opensuse.org/repositories/home:/cathay4t:/misc-rhel6/CentOS_CentOS-6/x86_64/

         a. `vim-common-7.4.417-3.2.x86_64.rpm`

         b. `vim-enhanced-7.4.417-3.2.x86_64.rpm`

      4. Debian (Ubuntu):

         a. Check version in aptitude: `apt-cache showpkg vim | grep -A1 Versions`

         b. If version is greater than 7.3.584: `apt-get install vim*`

   B. Run Install

      1. `cd ~/.vim/bundle/YouCompleteMe`

      2. Might need to run `git submodule update --init --recursive`

      3. `python install.py --clang-completer`

         a. Requires: cmake 2.8.x+

         b. Check version: `cmake --version`

         c. CentOS yum repo doesn't have latest version so you have to get it from their website here: http://www.cmake.org/cmake/resources/software.html

         d. `tar -xzvf cmake-2.8.x.x.tar.gz`

         e. `cd cmake-2.8.x.x`

         f. `./configure`

         g. `gmake`

         h. `sudo gmake install`

      4. Requires `python-devel` or `python-dev` package to run `./install`

      5. Requires `sudo yum groupinstall 'Development Tools'` or `sudo apt-get
         install build-essential`

   C. More info at: http://valloric.github.io/YouCompleteMe/

2. Numbers.vim

   A. Vim 7.3+

   B. https://github.com/myusuf3/numbers.vim

3. Tagbar

   A. Vim 7.0+

   B. http://majutsushi.github.io/tagbar/

   C. Exuberant ctags 5.5+

      1. http://ctags.sourceforge.net/

         a. Check version: `cmake --version`

         b. Check version in yum repo: `yum info ctags`

         c. Install: `sudo yum install -y ctags`

# Updating Vim/Git Submoudles

0. `cd ~`

1. `git submodule foreach git pull`

   A. If submodules are detached

      1. `git submodule foreach git checkout master`

