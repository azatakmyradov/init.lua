local augroup = vim.api.nvim_create_augroup
local AkmyradovGroup = augroup('Akmyradov', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- flash when yanked
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function ()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end
})

-- remove trailing space
autocmd({"BufWritePre"}, {
    group = AkmyradovGroup,
    pattern = "*",
    callback = function ()
        local position = vim.api.nvim_win_get_cursor(0)
        vim.cmd(":%s/\\s\\+$//e")
        vim.api.nvim_win_set_cursor(0, position)
    end,
})

-- LuaSnip Snippet History Fix (Seems to work really well, I think.)
local luasnip_fix_augroup = vim.api.nvim_create_augroup("MyLuaSnipHistory", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = '*',
    callback = function()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
            require('luasnip').unlink_current()
        end
    end,
    group = luasnip_fix_augroup
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'blade',
    callback = function()
        vim.schedule(function ()
            vim.cmd(":set syntax=html")
        end)
    end,
})

