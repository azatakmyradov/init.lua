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
        name = "catppuccin",
    },
    tokyonight = {
        path = "folke/tokyonight.nvim",
        name = "tokyonight-night",
    },
    github_dark = {
        path = "projekt0n/github-nvim-theme",
        name = "github_dark",
    },
    github_light = {
        path = "projekt0n/github-nvim-theme",
        name = "github_light",
    },
    gruvbox = {
        path = "sainnhe/gruvbox-material",
        name = "gruvbox-material",
    }
}

local colorscheme = colorschemes.gruvbox

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

            vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#1E1E2E' });
            vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#1E1E2E' });

            vim.api.nvim_set_hl(0, 'indentblanklinechar', { fg = '#282828' })
        end,
    },
}
