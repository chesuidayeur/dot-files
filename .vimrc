" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
"NeoBundle 'rails.vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'kevinw/pyflakes-vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'chrisbra/csv.vim'
" Non github repos
"NeoBundle 'git://git.wincent.com/command-t.git'
" gist repos
"NeoBundle 'gist:Shougo/656148', {
"      \ 'name': 'everything.vim',
"      \ 'script_type': 'plugin'}
" Non git repos
"NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

"NeoBundle 'https://github.com/Lokaltog/powerline.git'
NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

call neobundle#end()

" Installation check.
NeoBundleCheck

" Mapping pour command-t
noremap <leader>t <Esc>:CommandT<CR>

" Conf pour tagbar
"let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" Conf pour nerdTree
map <leader>t :NERDTreeToggle<CR>

" Coloration syntaxique, indispensable pour ne pas se perdre dans les longs fichiers
syntax on

" Le complément du précédent, devine tout seul la couleur du fond (clair sur foncé ou le contraire)
set background&

" Récupération de la position du curseur entre 2 ouvertures de fichiers
" Parfois ce n'est pas ce qu'on veut ...
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" SI c'est pas déjà fait, affiche la position du curseur
set ruler

" Recherche en minuscule -> indépendante de la casse, une majuscule -> stricte
set smartcase

" Ne jamais respecter la casse (attention totalement indépendant du précédent mais de priorité plus faible)
set ignorecase

" Affiche le nombre de lignes sélectionnées en mode visuel ou la touche/commande qu'on vient de taper en mode commande
set showcmd

" A utiliser en live, paste désactive l'indentation automatique (entre autre) et nopaste le contraire
set nopaste

" Indiquer le nombre de modification lorsqu'il y en a plus de 0 suite à une commande
set report=0

" Spécial développeurs
"
" Indispensable pour ne pas tout casser avec ce qui va suivre
set preserveindent
" indentation automatique
"set autoindent
" Largeur de l'autoindentation
set shiftwidth=2
" Arrondit la valeur de l'indentation
set shiftround
" Largeur du caractère tab
set tabstop=2
" Largeur de l'indentation de la touche tab
set softtabstop=2
" Remplace les tab par des expaces
set expandtab

" Pour activer les numéros de lignes dans la marge :
set number

" by eric
" -----------
" Utilise shiftwidth à la place de tabstop en début de ligne (et backspace supprime d'un coup si ce sont des espaces)
set smarttab

" sauvegarder les fichier ~ dans ~/.vim/backup avec crréation du répertoire si celui-ci n'existe pas
if filewritable(expand("~/.vim/backup")) == 2
  set backupdir=$HOME/.vim/backup
else
  if has("unix") || has("win32unix")
    call system("mkdir $HOME/.vim/backup -p")
    set backupdir=$HOME/.vim/backup
  endif
endif

" donner des droits d'exécution si le fichier commence par #! et contient /bin/ dans son chemin
function ModeChange()
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod a+x <afile>
    endif
  endif
endfunction

au BufWritePost * call ModeChange()

" by anonyme
" -----------
" autoindent n'est spécifique à aucun langage et fonctionne en général moins bien
set noautoindent
filetype plugin indent on
filetype indent on

" Toujours laisser des lignes visibles (içi 3) au dessus/en dessous du curseur quand on
" atteint le début ou la fin de l'écran :
set scrolloff=3

" Afficher en permanence la barre d'état (en plus de la barre de commande) :
set laststatus=2

" Format de la barre d'état (tronquée au début, fichier, flags,  :
" Remplacer par powerline
"set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%

" Permettre l'utilisation de la touche backspace dans tous les cas :
set backspace=2

" Envoyer le curseur sur la ligne suivante/précédente après usage des flèches droite/gauche en bout de ligne :
set whichwrap=<,>,[,]

" Tenter de rester toujours sur la même colonne lors de changements de lignes :
set nostartofline

" Nombre de commandes maximale dans l'historique :
set history=50

" Afficher une liste lors de complétion de commandes/fichiers :
"set wildmode=list:full

" Utilise la souris pour les terminaux qui le peuvent (tous ?)
" pratique si on est habitué à coller sous la souris et pas sous le curseur, attention fonctionnement inhabituel
"set mouse=a

" shebang automatique lors de l'ouverture nouveau
" d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
:autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
:autocmd BufNewFile *.py 0put=\"#!/usr/bin/env python\"|1put=\"# -*- coding: UTF8 -*-\<nl>\<nl>\"|$

" Perso
set ai

set encoding=utf-8
set t_Co=256
let g:Powerline_symbols = 'fancy'

let g:session_autosave = 'no'

set background=dark
colorscheme solarized
