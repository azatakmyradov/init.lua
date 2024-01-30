return {
    -- GitHub Copilot
    'github/copilot.vim',
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<C-;>", 'copilot#Previous()', { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<C-'>", 'copilot#Next()', { silent = true, expr = true })
    end
}
