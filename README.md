# Vim Plugins & Requirements

NOTE: **Everything requires Pathogen vim plugin.**

Don't forget to run:
* `git submodule update --init --recursive`

---

1. YouCompleteMe

   A. Vim 7.3.584+
   
      1. http://sudoers-d.com/blog/2013/01/18/installing-vim-on-centos-6-dot-3/

      2. http://www.tylercipriani.com/2013/02/24/install-vim-from-source.html

   B. Run Install
   
      1. `cd ~/.vim/bundle/YouCompleteMe` 
      
      2. Might need to run `git submodule update --init --recursive`
      
      3. `./install.sh --clang-completer`
      
         a. Requires: cmake 2.8.x+
         
         b. Check version: `cmake --version`
         
         c. http://www.cmake.org/cmake/resources/software.html
         
         d. `tar -xzvf cmake-2.8.x.x.tar.gz`
         
         e. `cd cmake-2.8.x.x`
         
         f. `./configure`
         
         g. `gmake`
         
         h. `sudo gmake install`
 
   C. More info at: http://valloric.github.io/YouCompleteMe/

2. Numbers.vim

   A. Vim 7.3+
 
3. Tagbar

   A. Vim 7.0+
 
   B. Exuberant ctags 5.5
      
      1. http://ctags.sourceforge.net/
 
