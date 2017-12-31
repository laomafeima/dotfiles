set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须
" 设置包括vundle和初始化相关的 runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 让 vundle 管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
" 你的所有插件需要在下面这行之前
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'tpope/vim-fireplace'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'Shougo/neocomplete.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'luochen1990/rainbow'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'w0rp/ale'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'rking/ag.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'laomafeima/f5'

call vundle#end()            " 必须
filetype plugin indent on    " 必须

syntax on " 开启语法高亮
filetype on " 自动检测文件类型
filetype plugin on " 插件支持文件类型
set t_Co=256 " 开启256色
set fileencodings=utf-8,gbk,cp936,ucs-bom,utf8"文件编码
set fileformat=unix " 设置文件的兼容格式为unix，避免换行符问题
set tabstop=4 " tab 的宽度
set expandtab " 用空格代替 tab
set shiftwidth=4 "自动缩进的时候 tab 的宽度
set softtabstop=4 "退格键的时候 tab 宽度
set number " 显示行号
set autoindent " 设置自动缩进。
set backspace=indent,eol,start " 兼容 vi 模式下无法删除的问题
set cursorline " 突出显示当前行
set hlsearch " 高亮显示搜索结果
" set ignorecase " 设置默认进行大小写不敏感查找
set scrolloff=2 " 光标到最后两行后自动滚动
set laststatus=2 " 默认显示状态栏
set ruler " 在编辑过程中，在右下角显示光标位置的状态行
set cc=80  " 设置 80 列显示线 
au FileType qf setlocal nonumber colorcolumn=0 " 设置QuickFix 里面不显示80列线和行号
set statusline=%<%n\ %f\ %m%r%h%w%{(&fenc!=''?&fenc:&enc).':'.&ff}\ %LL\ %Y%=%{ALEGetStatusLine()}\ %l,%v\ %p%%\ " 设置状态栏显示项目
hi VertSplit  cterm=NONE term=NONE gui=NONE " 设置分屏线样式
" 修改 Markdown 文件中 单个 '_' 高亮的问题
au FileType MARKDOWN syn clear markdownError
au FileType MARKDOWN syn match markdownErrorNotDisplay "\w\@<=_\w\@="

if has('gui_running')
    set guioptions-=T " 隐藏菜单栏
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    " 使用命令行下标签页样式
    set guioptions-=e
    "set guifont=Consolas,Menlo " 设置字体
    " hi CursorLine cterm=NONE ctermbg=DarkGray ctermfg=NONE guibg=NONE guifg=NONE " 设置高亮显示的颜色
    set lines=30 columns=110 " 设置启动时窗口大小
endif

" 设置 Y 为复制到系统粘贴板
vnoremap Y "*y
nnoremap Y "*yy
nnoremap P "*p

" incsearch 配置
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" 进入插入模式时改变状态栏颜色（仅限于Vim 7）
au InsertEnter * hi StatusLine guibg=red guifg=black gui=none ctermbg=red ctermfg=black cterm=none
au InsertLeave * hi StatusLine guibg=green guifg=black gui=none ctermbg=green ctermfg=black cterm=none
hi StatusLine guibg=green guifg=black gui=none ctermbg=green ctermfg=black cterm=none " 默认状态栏颜色

" 设置菜单颜色
hi ColorColumn ctermbg=lightgray guibg=darkgray " 设置80 列 线的颜色
hi Pmenu guibg=darkslategray ctermbg=lightgray " 下拉菜单的颜色
hi PmenuSel ctermfg=white ctermbg=darkgray guibg=Grey


" 自定义标签栏显示样式
" 标签控制
function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let result = a:n . ":" . (bufname(buflist[winnr - 1]) == "" ? "[No Name]" : bufname(buflist[winnr - 1]))
    for bufnr in buflist
        if getbufvar(bufnr, "&modified")
            let result .= (bufnr == buflist[winnr - 1] ? "+" : "~")
        endif
    endfor
    return result
endfunction

" 标签栏控制
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= '%' . (i + 1) . 'T'
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor
    let s .= '%#TabLineFill#%T'
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#'
    endif
    return s
endfunction
set tabline=%!MyTabLine()

" 设置 tab bar 颜色
:hi TabLineFill ctermfg=black ctermbg=black
:hi TabLine ctermfg=gray ctermbg=black cterm=none
:hi TabLineSel ctermfg=darkgreen ctermbg=black

"  标签页快捷键设置
noremap <silent><tab>t :tabnew<cr>
noremap <silent><tab>w :tabclose<cr>
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
noremap <silent><s-tab> :tabnext<CR>
inoremap <silent><s-tab> <ESC>:tabnext<CR>

" 分屏窗口移动
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" 关闭方向键, 强迫自己用 hjkl
map <Left> :echoe "Use 'h'"<CR>
map <Right> :echoe "Use 'l'"<CR>
map <Up> :echoe "Use 'j'"<CR>
map <Down> :echoe "Use 'k'"<CR>


" NerdTree 配置
nmap <silent> <F2> :NERDTreeToggle<CR>; " F2 开启和关闭 NERDTree
let NERDTreeShowBookmarks=1 " 默认显示书签
let NERDTreeWinSize=24 " 设置目录窗口宽度
let g:nerdtree_tabs_focus_on_files=1 " 设置 打开文件后文件窗口获得焦点
let g:nerdtree_tabs_smart_startup_focus=2 " 启动时焦点自动调整
let NERDTreeMinimalUI=1 " 不显示帮助信息
let g:NERDTreeMapJumpNextSibling = '' " 禁止 ctrl j 快捷键
let g:NERDTreeMapJumpPrevSibling = '' " 禁止 ctrl k 快捷键
let NERDTreeIgnore = ['.pyc$', '.pyo$', '.class$', '^__pycache__$'] " 隐藏部分后缀文件


" 添加注释的时候增加一个空格
let g:NERDSpaceDelims = 1

" 快速跳转配置
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_jp = 1

" easymotion 配置 
map <Leader>f <Plug>(easymotion-f)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
nmap s <Plug>(easymotion-s2)
" hjkl
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
" repeat motions
map <leader><leader>. <Plug>(easymotion-repeat)

" vim-indent-guides 配置
nmap <silent> <F3> <Leader>ig; " F3 开启关闭对齐线
"let g:indent_guides_enable_on_vim_startup = 1 " 默认是否显示对齐线
let g:indent_guides_guide_size=1 " 设置对期限宽度

" vim-multiple-cursors 配置
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
endfunction
set selection=inclusive

" 彩虹括号
let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'purple'], 'ctermfgs': ['red', 'darkyellow', 'yellow', 'green', 'cyan', 'blue', 'darkmagenta'],}

" 代码检查
if has("mac")
    let g:ale_statusline_format = ['✘%d', '!%d', '✔']
else
    let g:ale_statusline_format = ['E:%d', 'W:%d', 'OK']
endif
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'
highlight SignColumn ctermbg=none
highlight link ALEErrorSign Constant
highlight link ALEWarningSign LineNr
nmap <silent> <Leader>ep <Plug>(ale_previous_wrap) " 跳转到上一个错误
nmap <silent> <Leader>en <Plug>(ale_next_wrap) " 跳转到下一个错误

" 自动补全配置
set completeopt-=preview " 自动补全的时候不显示预览窗口
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
