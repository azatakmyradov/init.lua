return {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
    },

    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                    hidden = true,
                    previewer = false,
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        -- Enable telescope fzf native, if installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'live_grep_args')
        pcall(require('telescope').load_extension, 'git_worktree')
        pcall(require('telescope').load_extension, 'ui-select')

        vim.keymap.set('n', '<leader>z', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })

        vim.keymap.set('n', '<leader>f', function()
            builtin.find_files({
                file_ignore_patterns = { "node_modules", "vendor", ".git", "storage/clockwork" },
                prompt_title = '[F]ind [F]iles'
            })
        end)

        vim.keymap.set('n', '<leader>F',
            function()
                builtin.find_files({ no_ignore = true, prompt_title = '[F]ind [A]ll Files'
                })
            end)

        vim.keymap.set('n', '<leader>b', function()
            builtin.buffers({
                prompt_title = '[B]uffers'
            })
        end)

        vim.keymap.set('n', '<leader>g', function()
            require('telescope').extensions.live_grep_args.live_grep_args({
                file_ignore_patterns = { "node_modules", "vendor", ".git" },
                prompt_title = '[G]rep characters...'
            })
        end)

        vim.keymap.set('n', '<leader>G', function()
            require('telescope').extensions.live_grep_args.live_grep_args({
                prompt_title = '[G]rep [A]ll'
            })
        end)

        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set("n", "<leader>T", ":TodoTelescope<CR>")
    end
}
