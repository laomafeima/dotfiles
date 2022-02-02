require('lualine').setup{
    options = { 
        theme = 'onedark',
        icons_enabled = false,
        section_separators = '',
        component_separators = '',
    },
    extensions = {
        'quickfix',
        'nvim-tree'
    }
}
