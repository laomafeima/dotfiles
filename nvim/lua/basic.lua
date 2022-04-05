vim.opt.mouse = "a"  -- 支持鼠标
vim.opt.number= true --显示行号
vim.opt.termguicolors = true -- 开启256色

vim.opt.tabstop=4  -- tab 的宽度
vim.opt.expandtab=true  -- 用空格代替 tab
vim.opt.shiftwidth=4  -- 自动缩进的时候 tab 的宽度
vim.opt.softtabstop=4  -- 退格键的时候 tab 宽度
vim.opt.autoindent = true -- 设置自动缩进

vim.opt.cursorline = true -- 突出显示当前行

vim.cmd("highlight SignColumn guibg=none guifg=black cterm=none") -- 隐藏侧边信号栏
vim.cmd("highlight Pmenu guibg=darkslategray ctermbg=lightgray")  -- 设置弹出菜单栏
vim.cmd("highlight PmenuSel ctermbg=darkgray guibg=Grey cterm=bold") -- 设置菜单栏选中
vim.cmd("highlight VertSplit  cterm=NONE term=NONE gui=NONE") -- 设置分屏线样式


vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
]])
vim.cmd([[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
