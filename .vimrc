set nocompatible " 去除VI一致性,必须
call plug#begin('~/.vim/plugged')
" 插件列表
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine', { 'on':  'IndentLinesToggle'}
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/LanguageServer-php-neovim', {
            \'do': 'composer install && composer run-script parse-stubs'
            \}
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh && pip3 install neovim --upgrade && pip3 install python-language-server --upgrade && rustup component add rls-preview rust-analysis rust-src --toolchain nightly && cargo install racer',
            \ }
Plug 'terryma/vim-multiple-cursors'
Plug 'luochen1990/rainbow'
Plug 'skywind3000/asyncrun.vim', { 'on': ['Asyncrun', 'F5Run'] }
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'laomafeima/f5', { 'on': 'F5Run' }
call plug#end()

syntax on " 开启语法高亮
filetype on " 自动检测文件类型
filetype plugin indent on " 插件文件类型和缩进
set mouse= " 禁止鼠标
colorscheme default " 使用默认配色
set t_Co=256 " 开启256色
set fileencodings=utf-8,gbk,cp936,ucs-bom,utf8 " 文件编码
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
autocmd FileType qf setlocal nonumber colorcolumn=0 " 设置QuickFix 里面不显示80列线和行号
autocmd BufReadPost * call setpos(".", getpos("'\"")) " 下次打开时将光标移动到上次位置
set statusline=%<%n\ %f\ %m%r%h%w%{(&fenc!=''?&fenc:&enc).':'.&ff}\ %LL\ %Y%=%{GetMyStatusLine()}\ %l,%v\ %p%%\ " 设置状态栏显示项目
hi VertSplit  cterm=NONE term=NONE gui=NONE " 设置分屏线样式
" 修改 Markdown 文件中 单个 '_' 高亮的问题
autocmd FileType MARKDOWN syn clear markdownError
autocmd FileType MARKDOWN syn match markdownErrorNotDisplay "\w\@<=_\w\@="
au BufRead,BufNewFile *.php set indentexpr= | set smartindent " 针对 PHP 禁用基于 PHP 语法的缩进

" 设置 Y 为复制到系统粘贴板
vnoremap Y "*y
nnoremap Y "*yy
nnoremap P "*p

noremap <silent> <C-P> <C-W>p; " 两个窗口之间来回跳转

if has('gui_running')
    set guioptions-=T " 隐藏菜单栏
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=e " 使用命令行下标签页样式
    set lines=30 columns=110 " 设置启动时窗口大小
endif


" 进入插入模式时改变状态栏颜色
autocmd InsertEnter * hi StatusLine guibg=red guifg=black gui=none ctermbg=red ctermfg=black cterm=none
autocmd InsertLeave * hi StatusLine guibg=green guifg=black gui=none ctermbg=green ctermfg=black cterm=none
hi StatusLine guibg=green guifg=black gui=none ctermbg=green ctermfg=black cterm=none " 默认状态栏颜色

" 设置菜单颜色
hi CursorLine ctermbg=darkgray cterm=none " 高亮当前行
autocmd BufWinEnter,WinEnter,BufEnter *  setlocal cursorline " 自动启动高亮当前行
autocmd BufWinLeave,WinLeave,BufLeave *  setlocal nocursorline " 自动取消高亮当前行
hi ColorColumn ctermbg=darkgray guibg=darkgray " 设置80 列 线的颜色
hi Pmenu guibg=darkslategray ctermbg=lightgray " 下拉菜单的颜色
hi PmenuSel ctermfg=white ctermbg=darkgray guibg=Grey cterm=bold

" 自定义标签栏显示样式
function! GetShortName(name)
    let words = split(a:name, "/")
    if len(words) <= 4
        return a:name
    endif
    let filename = remove(words, -1)
    let last_path = remove(words, -1)
    let s_words = map(words, {key, val -> strpart(val, 0, 2)})
    call add(s_words, last_path)
    call add(s_words, filename)
    return join(s_words, "/")
endfunction
" 标签控制
function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    if a:n == tabpagenr() " 当前 tab 显示完整路径
        let result = a:n . ":" . (bufname(buflist[winnr - 1]) == "" ? "[No Name]" : bufname(buflist[winnr - 1]))
    else
        let result = a:n . ":" . (bufname(buflist[winnr - 1]) == "" ? "[No Name]" : GetShortName(bufname(buflist[winnr - 1])))
    endif
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
hi TabLineFill ctermfg=black ctermbg=black
hi TabLine ctermfg=gray ctermbg=black cterm=none
hi TabLineSel ctermfg=darkgreen ctermbg=black

"  标签页快捷键设置
noremap <silent><C-T> :tabnew<cr>
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

" 关闭方向键, 强迫自己用 hjkl
map <Left> :echoe "Use 'h'"<CR>
map <Right> :echoe "Use 'l'"<CR>
map <Up> :echoe "Use 'j'"<CR>
map <Down> :echoe "Use 'k'"<CR>

set incsearch " 搜索结果实时显示
" 禁用高亮
autocmd CursorHold * :set nohlsearch
autocmd InsertEnter * :set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap :/ :set hlsearch<cr>:/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>
noremap # #:set hlsearch<cr>

" NerdTree 配置
function! g:MyNERDTreeToggle()
    if exists(":NERDTreeMirrorToggle") 
        execute ":NERDTreeMirrorToggle"
    else
        execute ":NERDTreeToggle"
    endif
endfunction

command! -nargs=0 MyNERDTreeToggle call g:MyNERDTreeToggle()
nmap <silent> <F2> :MyNERDTreeToggle<CR>; " F2 开启和关闭 NERDTree
let NERDTreeShowBookmarks=1 " 默认显示书签
let NERDTreeWinSize=24 " 设置目录窗口宽度
let g:nerdtree_tabs_focus_on_files=1 " 设置 打开文件后文件窗口获得焦点
let g:nerdtree_tabs_smart_startup_focus=2 " 启动时焦点自动调整
let NERDTreeMinimalUI=1 " 不显示帮助信息
let g:NERDTreeMapJumpNextSibling = '' " 禁止 ctrl j 快捷键
let g:NERDTreeMapJumpPrevSibling = '' " 禁止 ctrl k 快捷键
let NERDTreeIgnore = ['.pyc$', '.pyo$', '.class$', '^__pycache__$'] " 隐藏部分后缀文件

" Denite 配置
noremap <silent> <C-B> :Denite file_rec<cr>; " 浏览当前路径下文件
noremap <silent> <C-F> :Denite grep<cr>; " 搜索当前路径下所有文件
call denite#custom#map(
      \ 'insert', '<C-T>', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map(
      \ 'insert', '<C-x>', '<denite:do_action:split>', 'noremap')
call denite#custom#map(
      \ 'insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map(
      \ 'normal', 't', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map(
      \ 'normal', 'x', '<denite:do_action:split>', 'noremap')
call denite#custom#map(
      \ 'normal', 'v', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map(
      \ 'insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map(
      \ 'insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/', '*.swp',
      \   'venv/', 'images/', '*.log.*', '*.min.*', 'img/', 'fonts/'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" 添加注释的时候增加一个空格
let g:NERDSpaceDelims = 1

" easymotion 配置 
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_jp = 1
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <leader><leader>. <Plug>(easymotion-repeat)

" indentLine
let g:indentLine_enabled = 0
let g:indentLine_char = '|'
nmap <silent> <F3> :IndentLinesToggle<cr>" F3 开启关闭对齐线

" F5 
nnoremap <silent> <F5> :F5Run<CR>; " F5 运行
autocmd FileType qf nmap <silent> <C-C> :F5Stop<CR>; " QuickFix 框 Ctrl C 停止异步运行，非运行时会关闭 QuickFix

" vim-multiple-cursors 配置
function! g:Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
endfunction
function! g:Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
endfunction
set selection=inclusive

" 彩虹括号
let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'purple'], 'ctermfgs': ['red', 'darkyellow', 'yellow', 'green', 'cyan', 'blue', 'darkmagenta'],}

" ALE 配置
let g:ale_statusline_format = ['✘%d', '!%d', '✔']
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'
highlight SignColumn ctermbg=none
highlight link ALEErrorSign Constant
highlight link ALEWarningSign LineNr

" echodoc 配置
set noshowmode
let g:echodoc_enable_at_startup = 1

" LSP 配置
let g:deoplete#enable_at_startup = 0 " 关闭自动开启
let g:LanguageClient_diagnosticsList = "Location" "数据存储在 location list
autocmd InsertEnter * call deoplete#enable() " 启动后开启自动补全，加快启动速度
set completeopt-=preview " 自动补全的时候不显示预览窗口
" 支持 tab 选择
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
		endfunction"}}}
set hidden

let g:LanguageClient_serverCommands = {
            \'python': ['pyls'],
            \'php': ['php', '~/.vim/plugged/LanguageServer-php-neovim/vendor/bin/php-language-server.php'],
            \'rust': ['rustup', 'run', 'nightly', 'rls'],
            \}
" 在使用 LSP 的时候禁用 ALE
for LSPTypeItem in keys(g:LanguageClient_serverCommands)
    execute "autocmd FileType ".LSPTypeItem." :ALEDisableBuffer"
endfor

let g:LanguageClient_autoStart = 1

let g:LanguageClient_diagnosticsDisplay = {
            \1: { "name": "Error","texthl": "ALEError", "signText": g:ale_sign_error, "signTexthl": "ALEErrorSign",},
            \2: { "name": "Warning","texthl": "ALEWarning", "signText": g:ale_sign_warning, "signTexthl": "ALEWarningSign",},
            \3: {"name": "Information","texthl": "ALEInfo","signText": g:ale_sign_warning,"signTexthl": "ALEInfoSign",},
            \4: {"name": "Hint","texthl": "ALEInfo","signText": g:ale_sign_warning,"signTexthl": "ALEInfoSign",},
            \}

let g:LanguageClientLintResult = {} " 每个文件的检查结果
function! LanguageClientLintStatusLine() abort
    let l:curBufNr = bufnr("%")
    call LanguageClientLintStatusLineUpdateLintResult(l:curBufNr)
    return LanguageClientLintStatusLineStr(l:curBufNr)
endfunction

function! LanguageClientLintStatusLineUpdateLintResult(curBufNr) abort
    let l:msg = getloclist(".")
    let l:lintResult = {}
    for l:item in l:msg
        let l:bufnr = get(l:item, "bufnr")
        let l:type = get(l:item, "type")
        if l:bufnr < 1 || (l:type != "E" && l:type != "W")
            continue
        endif
        if has_key(l:lintResult, l:bufnr) == 0
            let l:lintResult[l:bufnr] = {"E":0, "W":0}
        endif
        let l:lintResult[l:bufnr][l:type]+=1
    endfor
    for l:bufnrKey in keys(l:lintResult)
        let g:LanguageClientLintResult[l:bufnrKey] = l:lintResult[l:bufnrKey]
    endfor
    if has_key(l:lintResult, a:curBufNr) == 0 && has_key(g:LanguageClientLintResult, a:curBufNr)
        unlet g:LanguageClientLintResult[a:curBufNr]
    endif
endfunction

function! LanguageClientLintStatusLineStr(curBufNr) abort
    if has_key(g:LanguageClientLintResult, a:curBufNr) == 0 || (g:LanguageClientLintResult[a:curBufNr]["E"] == 0 && g:LanguageClientLintResult[a:curBufNr]["W"] == 0)
        return g:ale_statusline_format[2]
    else
        return MakeStatusLineStr(g:LanguageClientLintResult[a:curBufNr]["E"], g:LanguageClientLintResult[a:curBufNr]["W"])
    endif
endfunction

function! MakeStatusLineStr(errno, warno) abort
    if a:errno == 0 && a:warno == 0
        return g:ale_statusline_format[2]
    else
        let l:str = ""
        if a:errno > 0
            let l:str .= printf(g:ale_statusline_format[0], a:errno)
        endif
        if a:warno > 0
            let l:str .= printf(g:ale_statusline_format[1], a:warno)
        endif
        return l:str
    endif
endfunction


function! ALELinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return MakeStatusLineStr(all_errors, all_non_errors)
endfunction

" 兼容 ALE 和 LSP
function! GetMyStatusLine() abort
    " 状态栏显示语法信息，同时支持 LSP 和 ALE
    if index(keys(g:LanguageClient_serverCommands), &filetype) > -1
        return LanguageClientLintStatusLine()
    else
        return ALELinterStatus()
endfunction

function! MyErrorNext() abort
    if index(keys(g:LanguageClient_serverCommands), &filetype) > -1
        try
            execute "lne"
        catch /No more items/
            execute "lr"
        endtry
    else
        execute "normal \<Plug>(ale_next_wrap)"
    endif
endfunction
function! MyErrorPrev() abort
    if index(keys(g:LanguageClient_serverCommands), &filetype) > -1
        try
            execute "lp"
        catch /No more items/
            execute "lla"
        endtry
    else
        execute "normal \<Plug>(ale_previous_wrap)"
    endif
endfunction

function! TextDocumentHoverToggle() abort
    try
        execute "wincmd P"
        execute "pclose"
    catch /There is no preview window/
        call LanguageClient_textDocument_hover()
    endtry
endfunction

nnoremap <silent> <Leader>H :call TextDocumentHoverToggle()<CR>
nnoremap <silent> <C-]> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F4> :call LanguageClient_textDocument_rename()<CR>
" 查看当前方法属性的所有引用
nnoremap <silent> <F6> :call LanguageClient_textDocument_references() <bar> :lli<cr>
nnoremap <silent> <Leader>ep :call MyErrorPrev()<cr>; " 跳转到上一个错误/引用
nnoremap <silent> <Leader>en :call MyErrorNext()<cr>; " 跳转到下一个错误/引用
