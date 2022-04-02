require('lualine').setup{
    options = { 
        theme = 'onedark',
    },
    extensions = {
        'quickfix',
        'nvim-tree',
        'quickfix',
    },
    sections = {
        lualine_x = {'filetype', 'encoding'},
        lualine_y = {'%L', 'progress'},
    },
    tabline = {
        lualine_a = {{ 
            'buffers',
            mode = 2,
        }},
        -- lualine_b = {'branch'},
        -- lualine_c = {'filename'},
        -- lualine_x = {},
        -- lualine_y = {},
        lualine_z = {'tabs'}
    }
}
