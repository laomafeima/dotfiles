local opts = {noremap = true, silent = true }
vim.api.nvim_set_keymap('', '<C-E>', ':NvimTreeToggle<CR>', opts)  -- Ctrl+E 开启和关闭 NvimTree
vim.api.nvim_set_keymap('', '<C-P>', '<C-W>p', opts)  -- 最近的两个窗口之间来回跳转

-- 标签页快捷键设置
vim.api.nvim_set_keymap('', '<C-T>', ':tabnew<cr>', opts)
vim.api.nvim_set_keymap('', '<tab>n', ':tabnext<cr>', opts)
vim.api.nvim_set_keymap('', '<tab>w', ':tabclose<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>1', ':b 1<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>2', ':b 2<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>3', ':b 3<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>4', ':b 4<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>5', ':b 5<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>6', ':b 6<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>7', ':b 7<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>8', ':b 8<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>9', ':b 9<cr>', opts)
vim.api.nvim_set_keymap('', '<leader>0', ':b 10<cr>', opts)
vim.api.nvim_set_keymap('', '<s-tab>', ':bn <CR>', opts)
vim.api.nvim_set_keymap('i', '<s-tab>', '<ESC>:bn <CR>', opts)

-- 关闭方向键, 强迫自己用 hjkl
vim.api.nvim_set_keymap('n', '<Left>', ':echoe "Use \'h\'."<CR>', opts)
vim.api.nvim_set_keymap('n', '<Right>', ':echoe "Use \'l\'."<CR>', opts)
vim.api.nvim_set_keymap('n', '<Up>', ':echoe "Use \'j\'."<CR>', opts)
vim.api.nvim_set_keymap('n', '<Down>', ':echoe "Use \'k\'."<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-C>', ':echoe "What are you doing? This is Vim."<CR>', opts)


--  telescope 快捷键
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)


-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("\\<CR>")', {silent = true, script = true, expr = true})

-- CFRL 使用键盘快捷键
if vim.fn.getregtype("*") == "" then
    vim.api.nvim_set_keymap('v', 'Y', ':CopySelected<cr>', opts);
    vim.api.nvim_set_keymap('n', 'Y', ':CopyLines<cr>', opts);
else
    vim.api.nvim_set_keymap('v', 'Y', '"*y', opts);
    vim.api.nvim_set_keymap('n', 'Y', '"*yy', opts);
end
vim.api.nvim_set_keymap('n', 'P', '"*p', opts);
