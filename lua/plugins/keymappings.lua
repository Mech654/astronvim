-- Custom Keymappings Configuration
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        -- Tab navigation
        ["<C-1>"] = { "1gt", desc = "Go to tab 1" },
        ["<C-2>"] = { "2gt", desc = "Go to tab 2" },
        ["<C-3>"] = { "3gt", desc = "Go to tab 3" },
        ["<C-4>"] = { "4gt", desc = "Go to tab 4" },
        
        -- Project navigation
        ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Find projects" },
        
        -- Window management
        ["<leader>c"] = { "<C-w>c", desc = "Close current window" },
        ["<leader>o"] = { "<C-w>o", desc = "Close all other windows" },
        
        -- Splits with AltGr (Meta)
        ["<M-h>"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
        ["<M-j>"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
        
        -- Splits but open Snacks picker
        ["<M-k>"] = {
          function()
            vim.cmd.split()
            local ok, snacks = pcall(require, "snacks")
            if not ok or not snacks or not snacks.picker or not snacks.picker.files then
              vim.notify("Snacks picker not available", vim.log.levels.WARN)
              return
            end
            snacks.picker.files({ layout = { preset = "default" } })
          end,
          desc = "Horizontal Split + Snacks Picker"
        },
        
        ["<M-l>"] = {
          function()
            vim.cmd.vsplit()
            local ok, snacks = pcall(require, "snacks")
            if not ok or not snacks or not snacks.picker or not snacks.picker.files then
              vim.notify("Snacks picker not available", vim.log.levels.WARN)
              return
            end
            snacks.picker.files({ layout = { preset = "vertical" } })
          end,
          desc = "Vertical Split + Snacks Picker"
        },
        
        -- Copy whole buffer to clipboard
        ["<CR><CR>"] = { "ggVG\"+y", desc = "Copy whole buffer" },
        
        -- Clear buffer and paste clipboard content
        ["<CR><BS>"] = {
          function()
            vim.api.nvim_command('%delete _')
            vim.api.nvim_command('normal! gg')
            local clip = vim.fn.getreg('+')
            
            -- Split lines helper function
            local function split_lines(str)
              local t = {}
              if str == nil or str == "" then return t end
              for line in str:gmatch("([^\r\n]*)[\r\n]?") do
                table.insert(t, line)
              end
              if t[#t] == "" then table.remove(t) end
              return t
            end
            
            local lines = split_lines(clip)
            if #lines == 0 then
              vim.api.nvim_command('normal! 0')
              return
            end
            vim.api.nvim_put(lines, 'b', false, true)
            vim.api.nvim_command('normal! 0')
          end,
          desc = "Clear buffer and paste clipboard"
        },
        
        -- Delete whole buffer content without yanking
        ["<BS><BS>"] = {
          function()
            vim.api.nvim_command('%delete _')
          end,
          desc = "Delete whole buffer content without yanking"
        },
      },
      i = {
        -- Exit insert mode with 'q'
        ["q"] = { "<Esc>", desc = "Exit insert mode with q" },
      },
    },
  },
}
