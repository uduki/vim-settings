" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"autocmd FileType haskell compiler hlint

" 256色モード
"colorscheme desert
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_contrast="high"
colorscheme solarized
"set t_Co=256

"#----------------------------------------#
"#             文字コード設定             #
"#----------------------------------------#
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set ambiwidth=double
set nobackup
set autoindent
set smartindent
set number
set showmode
set title
set ruler
set tabstop=4
set expandtab
set shiftwidth=4
set showmatch
set list
set listchars=tab:>\ ,extends:@
set completeopt=menu,preview,menuone,longest
"set nowrap
set wrap
set nocp

filetype plugin on


"#----------------------------------------#
"#           操作性向上用設定             #
"#----------------------------------------#
"入力モードを抜けずに保存を行う。
imap <C-d><C-w> <Esc>:w<LF>a

"入力モードを抜けずに系設定。
"C-hjklでカーソル移動
imap <C-h> <LEFT>
imap <C-j> <DOWN>
imap <C-k> <UP>
imap <C-l> <RIGHT>
"行頭・行末
imap <C-a> <HOME>
imap <C-e> <END>

"バッファ切り替え
nmap <UP> :bp<LF>
nmap <DOWN> :bn<LF>

"タブ切り替え
nnoremap <RIGHT> gt
nnoremap <LEFT> gT

"ウィンドウサイズ変更
nmap <C-h> 1<C-w><
nmap <C-l> 1<C-w>>
nmap <C-j> 1<C-w>-
nmap <C-k> 1<C-w>+

"常に見た目の行数でカーソル移動
nnoremap j gj
nnoremap k gk

"#----------------------------------------#
"#            誤操作防止用設定            #
"#----------------------------------------#
"誤って入力テキストを無効にしてしまうのを防止する。
imap <C-u> <Esc>

"neocomplcache設定
let g:neocomplcache_enable_at_startup = 1

"#----------------------------------------#
"#              Unite用設定               #
"#----------------------------------------#
"各変数設定
let g:unite_update_time = 100
let g:unite_enable_split_vertically = 1
let g:unite_enable_start_insert = 1

"エクスプローラ表示
nmap +UP :Unite -buffer-name=project -input=!cabal-dev\ !dist\  file_rec<LF>

"バッファ表示
nmap +UB :Unite -buffer-name=buffer-list buffer<LF>

"#----------------------------------------#
"#             Haskell用設定              #
"#----------------------------------------#
autocmd FileType haskell compiler hlint

nmap +HC :compiler ghcmod_check<LF>:w<LF>
nmap +HL :compiler hlint<LF>:w<LF>
nmap +HT :GhcModType<LF>
nmap +HR :GhcModTypeClear<LF>

"Unite-haddockをbrowse_remoteをデフォにして起動
nmap +HH :Unite -default-action=browse_remote haddock<LF>


