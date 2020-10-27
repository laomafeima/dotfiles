set nocompatible " 去除VI一致性,必须
" Automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
" 插件列表
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'Yggdroot/indentLine', { 'on':  'IndentLinesToggle' }
Plug 'mg979/vim-visual-multi'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'skywind3000/asyncrun.vim'
Plug 'laomafeima/run.vim'
Plug 'laomafeima/cfrl.vim', { 'on': ['CopyLines', 'CopySelected'] }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on " 开启语法高亮
filetype on " 自动检测文件类型
filetype plugin indent on " 插件文件类型和缩进
set mouse= " 禁止鼠标
colorscheme default " 使用默认配色
set t_Co=256 " 开启256色
set fileencodings=utf-8,gbk,cp936,ucs-bom,utf8 " 文件编码
set fileformat=unix " 设置文件的兼容格式为unix，避免换行符问题
set hidden " 设置隐藏
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
set statusline=%<%n\ %{RemoveCurPath(expand('%'))}\ %m%r%h%w%{(&fenc!=''?&fenc:&enc).':'.&ff}\ %LL%{CharCount()}\ %Y%=%{StatusDiagnostic()}\ %l,%v\ %p%%\ " 设置状态栏显示项目
set fillchars+=vert:│ " 设置分屏为直线
hi VertSplit  cterm=NONE term=NONE gui=NONE " 设置分屏线样式
" 修改 Markdown 文件中 单个 '_' 高亮的问题
autocmd FileType markdown syn clear markdownError
autocmd FileType markdown syn match markdownErrorNotDisplay "\w\@<=_\w\@="
au BufRead,BufNewFile *.php set indentexpr= | set smartindent " 针对 PHP 禁用基于 PHP 语法的缩进
autocmd FileType go set formatoptions+=r " 针对 Golang 的注释优化
highlight SignColumn ctermbg=none " 移除侧边栏背景色

noremap <silent> <C-P> <C-W>p; " 两个窗口之间来回跳转

" 进入插入模式时改变状态栏颜色
autocmd InsertEnter * hi StatusLine guibg=red guifg=black gui=none ctermbg=red ctermfg=black cterm=none
autocmd InsertLeave * hi StatusLine guibg=green guifg=black gui=none ctermbg=green ctermfg=black cterm=none
hi StatusLine guibg=green guifg=black gui=none ctermbg=green ctermfg=black cterm=none " 默认状态栏颜色

" Visual 模式下的颜色
hi Visual term=reverse ctermbg=DarkGrey guibg=LightGrey

" 设置菜单颜色
hi CursorLine ctermbg=darkgray cterm=none term=none " 高亮当前行
hi CursorLineNr term=bold cterm=bold gui=bold " 高亮当前行
autocmd BufWinEnter,WinEnter,BufEnter *  setlocal cursorline " 自动启动高亮当前行
autocmd BufWinLeave,WinLeave,BufLeave *  setlocal nocursorline " 自动取消高亮当前行
hi ColorColumn ctermbg=darkgray guibg=darkgray " 设置80 列 线的颜色
hi Pmenu guibg=darkslategray ctermbg=lightgray " 下拉菜单的颜色
hi PmenuSel ctermfg=white ctermbg=darkgray guibg=Grey cterm=bold

" markdown 文档显示字数
function! CharCount()
    if tolower(&filetype) == "markdown"
        let wordcount = wordcount()
        return " " . wordcount["chars"] . "C"
    else
        return ""
    endif
endfunction

" 移除当前目录路径
function! RemoveCurPath(name)
    if stridx(a:name, getcwd()) == 0
        let name = substitute(a:name, getcwd() . "/", "", "")
    else
        let name = a:name
    endif
    return name
endfunction


" 自定义标签栏显示样式
function! GetShortName(name)
    let name = RemoveCurPath(a:name)
    let words = split(name, "/")
    if len(words) <= 4
        return name
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
        let result = a:n . ":" . (bufname(buflist[winnr - 1]) == "" ? "[No Name]" : RemoveCurPath(bufname(buflist[winnr - 1])))
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
        " 选中标签中间高亮
        if i == 0 && tabpagenr() == 2
            let s .= '%{MyTabLabel(' . (i + 1) . ')} | '
        elseif i == 0
            let s .= '%{MyTabLabel(' . (i + 1) . ')}'
        elseif i + 2 == tabpagenr()
            let s .= ' | %{MyTabLabel(' . (i + 1) . ')} | '
        elseif i + 1 == tabpagenr()
            let s .= '%{MyTabLabel(' . (i + 1) . ')}'
        else
            let s .= ' | %{MyTabLabel(' . (i + 1) . ')}'
        endif
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
hi TabLineSel ctermfg=green ctermbg=black cterm=bold

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
nmap <silent> <C-E> :MyNERDTreeToggle<CR>; " Ctrl+E 开启和关闭 NERDTree
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
" nmap <silent> <C-I> :IndentLinesToggle<cr>" Ctrl I开启关闭对齐线

" Run.vim
autocmd FileType qf nmap <silent> <C-C> :RS<CR>; " QuickFix 框 Ctrl C 停止异步运行，非运行时会关闭 QuickFix

" cfrl.vim
autocmd VimEnter * call SetCopyMap()
function! SetCopyMap()
    if getregtype("*") == ""
        vnoremap Y :CopySelected<cr>
        nnoremap Y :CopyLines<cr>
    else
        vnoremap Y "*y
        nnoremap Y "*yy
    endif
    nnoremap P "*p
endfunction

" 彩虹括号
let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'purple'], 'ctermfgs': ['red', 'darkyellow', 'yellow', 'green', 'cyan', 'blue', 'darkmagenta'],}

" COC.NVIM 配置
" 状态栏设置
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) || (get(info, 'error', 0) + get(info, 'warning', 0)) < 1
        return '✔'
    endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, '✘' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, '!' . info['warning'])
    endif
    return join(msgs, ' ')
endfunction

" set updatetime=300 " 更新时间
" 默认 coc 插件

set shortmess+=c " Don't pass messages to |ins-completion-menu|.
let g:coc_global_extensions = ["coc-lists", "coc-python", "coc-go"]

" Using CocList
noremap <silent> <C-B> :CocList files<cr>; " 浏览当前路径下文件
" 全局搜索
noremap <silent> <C-F> :exe 'CocList grep '.input('Find: ')<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <leader>u and <leader>d for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <leader>u coc#float#has_scroll() ? coc#float#scroll(1) : "\<leader>u"
nnoremap <nowait><expr> <leader>d coc#float#has_scroll() ? coc#float#scroll(0) : "\<leader>d"
inoremap <nowait><expr> <leader>u coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <leader>d coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
