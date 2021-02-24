"コピペしてきた
set nowritebackup
set nobackup
set noswapfile
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set encoding=utf-8

"検索
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

set noerrorbells
set showmatch matchtime=1
set laststatus=2
set showcmd
set list
set listchars=tab:^\ ,trail:~
set history=10000
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set showmatch
set smartindent
set nofoldenable

set title
set number
set virtualedit=onemore

set clipboard=unnamed,autoselect
set nrformats=
set whichwrap=b,s,h,l,<,>,[,],~
set mouse=a

" オレオレ設定
set cursorline
set foldmethod=indent
filetype indent on

"keymap
imap jj <Esc>
imap <c-j> <Down>
imap <c-h> <left>
imap <c-k> <up>
imap <c-l> <right>

nmap <Esc><Esc> :nohlsearch<CR><ESC>
nmap j gj
nmap k gk
nmap ; :
nmap <Enter> zA
nmap <Space>ls :NERDTreeToggle<CR>

" 補完
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
" 候補選択中の挿入を防止
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" HTML/XML閉じタグ自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

"引数なしでvimを開いたらNERDTreeを起動、
"引数ありならNERDTreeは起動せず、引数で渡されたファイルを開く。
autocmd vimenter * if !argc() | NERDTree | endif

"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

syntax on
set t_Co=256
colorscheme desert
