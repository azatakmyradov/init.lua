local colorschemes = {
    rose_pine = {
        path = "rose-pine/neovim",
        name = "rose-pine",
    },
    rose_pine_moon = {
        path = "rose-pine/neovim",
        name = "rose-pine-moon",
    },
    catppuccin = {
        path = "catppuccin/nvim",
        name = "catppuccin-frappe",
    },
    tokyonight = {
        path = "folke/tokyonight.nvim",
        name = "tokyonight-night",
    },
}

local colorscheme = colorschemes.tokyonight

return {
    {
        colorscheme.path,
        priority = 1000,
        opts = {
            disable_italics = true,
            dark = true,
            telescope = {
                enabled = true,
            }
        },
        config = function()
            vim.cmd.colorscheme(colorscheme.name)

            vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#282828' });
            vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#282828' });

            vim.api.nvim_set_hl(0, 'indentblanklinechar', { fg = '#282828' })
        end,
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = colorscheme.name,
                component_separators = '|',
                section_separators = '',
            },
        },
    },
}
