# Vim Plugins & Requirements

NOTE: **Everything requires Pathogen vim plugin.**

Don't forget to run:
* `git submodule init`
* `git submodule update --recursive`

---

1. YouCompleteMe

   A. Vim 7.3.584+
   
      1. http://sudoers-d.com/blog/2013/01/18/installing-vim-on-centos-6-dot-3/

      2. http://www.tylercipriani.com/2013/02/24/install-vim-from-source.html

   B. Run Install
   
      1. `cd ~/.vim/bundle/YouCompleteMe` 
      
      2. Might need to run `git submodule update --init --recursive`
      
      3. `./install.sh --clang-completer`
 
   C. More info at: http://valloric.github.io/YouCompleteMe/

2. Numbers.vim

   A. Vim 7.3+
 
3. Tagbar

   A. Vim 7.0+
 
   B. Exuberant ctags 5.5
      
      1. http://ctags.sourceforge.net/
 
