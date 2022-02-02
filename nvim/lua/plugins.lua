local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require('packer').use

require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager

    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    use {
        'laomafeima/cfrl.vim',
        cmd = { 'CopyLines', 'CopySelected' },
    }

    use {
        'github/copilot.vim',
        opt = true,
        event = 'InsertEnter',
    }
    use {
        'mfussenegger/nvim-dap',
        opt = true,
        event = {'VimEnter'},
    }


    use {
        'leoluz/nvim-dap-go',
        requires = { 'mfussenegger/nvim-dap' },
        config = function() require'dap-go'.setup {} end,
        opt = true,
        event = {'VimEnter'},
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            { 'p00f/nvim-ts-rainbow' }
        },
        run = ':TSUpdate'
    }

    use { 
        'kyazdani42/nvim-tree.lua',
        config = function() require'nvim-tree'.setup {
            auto_close          = true,
            open_on_tab         = true,
        } end,
        opt = true,
        cmd = {'NvimTreeToggle'},
    }

    use 'nvim-lualine/lualine.nvim'
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require'tabline'.setup {
                -- Defaults configuration options
                enable = true,
                options = {
                    -- If lualine is installed tabline will use separators configured in lualine by default.
                    -- These options can be used to override those settings.
                    modified_icon = "+ ", -- change the default modified icon
                }
            }
            vim.cmd[[
            set guioptions-=e " Use showtabline in gui vim
            set sessionoptions+=tabpages,globals " store tabpages and globals in session
            ]]
        end,
        opt = true,
        event = { 'TabNew' },
        requires = { { 'nvim-lualine/lualine.nvim' } }
    }


    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup{}
        end,
        opt = true,
        event = {'InsertEnter'}
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        opt = true,
        event = {'VimEnter'},
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
        opt = true,
        event = {'VimEnter'},
    }

    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                -- overwrite default configuration
                -- here, e.g. to enable default bindings
                copy_sync = {
                    -- enables copy sync and overwrites all register actions to
                    -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
                    enable = true,
                },
                navigation = {
                    -- enables default keybindings (C-hjkl) for normal mode
                    enable_default_keybindings = true,
                },
                resize = {
                    -- enables default keybindings (A-hjkl) for normal mode
                    enable_default_keybindings = true,
                }
            })
        end,
        opt = true,
        event = {'VimEnter'},
    })

    if packer_bootstrap then
        require('packer').sync()
    end

end)
