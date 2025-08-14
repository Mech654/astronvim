local map = vim.keymap.set

-- Copy whole buffer to clipboard
map("n", "<CR><CR>", "ggVG\"+y", { desc = "Copy whole buffer", noremap = true, silent = true })

-- helper to split clipboard into exact lines (preserves spaces)
local function split_lines(str)
local t = {}
if str == nil or str == "" then
    return t
    end
    -- capture every line including empty ones (but we'll drop trailing final empty)
    for line in str:gmatch("([^\r\n]*)[\r\n]?") do
        table.insert(t, line)
        end
        if t[#t] == "" then
            table.remove(t)
            end
            return t
            end

            -- Clear buffer and paste clipboard content (Enter then Backspace)
            map("n", "<CR><BS>", function()
            vim.api.nvim_command('%delete _')
            vim.api.nvim_command('normal! gg')
            local clip = vim.fn.getreg('+')
            local lines = split_lines(clip)
            if #lines == 0 then
                -- nothing to paste, just leave empty buffer and go to start
                vim.api.nvim_command('normal! 0')
                return
                end
                vim.api.nvim_put(lines, 'b', false, true)
                vim.api.nvim_command('normal! 0')
                end, { desc = "Clear buffer and paste clipboard", noremap = true, silent = true })

            -- Delete whole buffer content without yanking (Backspace Backspace)
            map("n", "<BS><BS>", function()
            vim.api.nvim_command('%delete _')
            end, { desc = "Delete whole buffer content without yanking", noremap = true, silent = true })

            -- Exit insert mode with 'q' (quick and destructive — you can't type 'q' normally)
            map("i", "q", "<Esc>", { desc = "Exit insert mode with q", noremap = true, silent = true })
