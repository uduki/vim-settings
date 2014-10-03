"----------------------------------------"
"           NeoBundle 前半処理           "
"----------------------------------------"

set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
" NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
" NeoBundle 'L9'
" NeoBundle 'FuzzyFinder'
" NeoBundle 'rails.vim'
" Non github repos
" NeoBundle 'git://git.wincent.com/command-t.git'
" Non git repos
" NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
" NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-ref'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc.git'
NeoBundle 'uduki/commentout.vim'
NeoBundle 'uduki/vim-snippets'

" for markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" for theme
NeoBundle 'altercation/vim-colors-solarized'


"----------------------------------------"
"                基本設定                "
"----------------------------------------"

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

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

" 256色モード
"colorscheme desert
"set t_Co=256

""" solarized
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_contrast="high"
colorscheme solarized


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
set listchars=tab:>\ ,extends:@,trail:_
set completeopt=menu,preview,menuone,longest
"set nowrap
set wrap
set nocp

filetype plugin on


"#----------------------------------------#
"#           操作性向上用設定             #
"#----------------------------------------#
"入力モードを抜けずに保存を行う。
inoremap <C-d><C-w> <Esc>:w<LF>a

"入力モードを抜けずに系設定。
"C-hjklでカーソル移動
inoremap <C-h> <LEFT>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>
"行頭・行末
inoremap <C-a> <HOME>
inoremap <C-e> <END>

"バッファ切り替え
nnoremap <UP> :bp<LF>
nnoremap <DOWN> :bn<LF>

"タブ切り替え
nnoremap <RIGHT> gt
nnoremap <LEFT> gT

"ウィンドウサイズ変更
nnoremap <C-h> 1<C-w><
nnoremap <C-l> 1<C-w>>
nnoremap <C-j> 1<C-w>-
nnoremap <C-k> 1<C-w>+

"常に見た目の行数でカーソル移動
nnoremap j gj
nnoremap k gk

"visualモードで選択してからのインデント調整で調整後に選択範囲を解除しない
vnoremap > >gv
vnoremap < <gv

"ヤンクでクリップボードにコピー
set clipboard+=unnamedplus,unnamed

"ビープ音がうるさいので消音
set visualbell t_vb=
nnoremap <C-t><C-v><C-b> :set visualbell t_vb=<LF>

"#----------------------------------------#
"#   ノーマルモードで日本語入力OFF設定    #
"#----------------------------------------#
let g:input_toggle = 1
function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction

function! Fcitx2ja()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
        let l:a = system("fcitx-remote -o")
        let g:input_toggle = 0
    endif
endfunction

set ttimeoutlen=150
autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2ja()


"#----------------------------------------#
"#            誤操作防止用設定            #
"#----------------------------------------#
"誤って入力テキストを無効にしてしまうのを防止する。
imap <C-u> <Esc>


"#----------------------------------------#
"#      ファイルを綺麗に保つ為の設定      #
"#----------------------------------------#
"保存時に行末の空白文字を自動削除する(Markdownは除く)
let g:remove_trailing_white_space = 1

function! RemoveTrailingWhiteSpace()
    if g:remove_trailing_white_space == 1 && &filetype != 'mkd' && &filetype != 'markdown'
        :%s/\s\+$//e
    endif
endfunction

autocmd BufWritePre * call RemoveTrailingWhiteSpace()


"#----------------------------------------#
"#           neocomplcache設定            #
"#----------------------------------------#
"起動時に有効
let g:neocomplcache_enable_at_startup = 1

"補完の為のキーワードパターンを設定
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'


"#----------------------------------------#
"#             neosnippet設定             #
"#----------------------------------------#
imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_expand_or_jump)
xmap <C-i> <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


"#----------------------------------------#
"#              Unite用設定               #
"#----------------------------------------#
"各変数設定
let g:unite_update_time = 100
"let g:unite_enable_split_vertically = 1
let g:unite_enable_start_insert = 1

"大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

"エクスプローラ表示
nmap +UP :Unite -buffer-name=project -input=!.git\ !.hg\ !cabal-dev\ !.cabal-sandbox\ !dist\  file_rec/async<LF>

"バッファ表示
nmap +UB :Unite -buffer-name=buffer-list buffer<LF>

"grep結果表示
nmap +UG :Unite -buffer-name=grep-list grep<LF>
nmap +URG :UniteResume grep-list<LF>

"unite grepにthe silver searcherを使う
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

"#----------------------------------------#
"#             Haskell用設定              #
"#----------------------------------------#

let g:necoghc_enable_detailed_browse = 1

"保存時に自動でチェック
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

nmap +HC :GhcModCheck<LF>
nmap +HL :GhcModLint<LF>
nmap +HE :GhcModExpand<LF>
nmap +HT :GhcModType<LF>
nmap +HR :GhcModTypeClear<LF>

"Unite-haddockをbrowse_remoteをデフォにして起動
nmap +HHR :Unite -default-action=browse_remote haddock<LF>
nmap +HHL :Unite haddock<LF>

"----------------------------------------"
"             Markdown用設定             "
"----------------------------------------"

autocmd BufRead,BufNewFile *.mkd set filetype=markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

nnoremap <silent> +MDP :PrevimOpen<LF>

let g:vim_markdown_folding_disabled = 1


"----------------------------------------"
"           NeoBundle 後半処理           "
"----------------------------------------"

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif
