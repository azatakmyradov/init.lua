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

        vim.schedule(function ()
            local workspace = vim.fn.getcwd()
            -- check if .prettierrc exists
            if vim.fn.filereadable(workspace .. "/.prettierrc") == 1 then
                vim.cmd(":Prettier")
            end
        end)
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'fugitive',
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}

        -- Fugitive
        vim.keymap.set("n", "<leader>p", '<cmd>Git push<CR>', opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", "<cmd>Git pull --rebase<CR>", opts)

        -- commit
        vim.keymap.set("n", "<leader>tt", ":Git push -u origin ", opts);
    end,
})
