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
        
        -- Buffer navigation with Alt + numbers
        ["<M-1>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[1] then vim.api.nvim_set_current_buf(buffers[1]) end
          end, 
          desc = "Go to buffer 1" 
        },
        ["<M-2>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[2] then vim.api.nvim_set_current_buf(buffers[2]) end
          end, 
          desc = "Go to buffer 2" 
        },
        ["<M-3>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[3] then vim.api.nvim_set_current_buf(buffers[3]) end
          end, 
          desc = "Go to buffer 3" 
        },
        ["<M-4>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[4] then vim.api.nvim_set_current_buf(buffers[4]) end
          end, 
          desc = "Go to buffer 4" 
        },
        ["<M-5>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[5] then vim.api.nvim_set_current_buf(buffers[5]) end
          end, 
          desc = "Go to buffer 5" 
        },
        ["<M-6>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[6] then vim.api.nvim_set_current_buf(buffers[6]) end
          end, 
          desc = "Go to buffer 6" 
        },
        ["<M-7>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[7] then vim.api.nvim_set_current_buf(buffers[7]) end
          end, 
          desc = "Go to buffer 7" 
        },
        ["<M-8>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[8] then vim.api.nvim_set_current_buf(buffers[8]) end
          end, 
          desc = "Go to buffer 8" 
        },
        ["<M-9>"] = { 
          function()
            local buffers = vim.tbl_filter(function(buf)
              return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
            end, vim.api.nvim_list_bufs())
            if buffers[9] then vim.api.nvim_set_current_buf(buffers[9]) end
          end, 
          desc = "Go to buffer 9" 
        },
        
        -- Project navigation - leader + p
        ["<leader>p"] = { 
          function()
            local ok, snacks = pcall(require, "snacks")
            if ok and snacks and snacks.picker and snacks.picker.projects then
              snacks.picker.projects()
            else
              -- Fallback to find files in current directory
              vim.notify("Projects picker not available", vim.log.levels.WARN)
            end
          end,
          desc = "Find projects" 
        },
        
        -- Window management
        ["<leader>c"] = { "<C-w>c", desc = "Close current window" },
        ["<leader>o"] = { "<C-w>o", desc = "Close all other windows" },
        
        -- Buffer navigation helpers
        ["<M-0>"] = { 
          function()
            local ok, snacks = pcall(require, "snacks")
            if ok and snacks and snacks.picker and snacks.picker.buffers then
              snacks.picker.buffers()
            else
              -- Fallback to builtin buffer list
              vim.cmd("buffers")
            end
          end, 
          desc = "List all buffers" 
        },
        
        -- File picker
        ["<M-f>"] = { 
          function()
            local ok, snacks = pcall(require, "snacks")
            if ok and snacks and snacks.picker and snacks.picker.files then
              snacks.picker.files()
            else
              -- Fallback to find files
              vim.cmd("find .")
            end
          end, 
          desc = "Find files" 
        },
        
        -- Previous/Next buffer navigation  
        ["<M-,>"] = { ":bprevious<CR>", desc = "Previous buffer" },
        ["<M-.>"] = { ":bnext<CR>", desc = "Next buffer" },
        ["<M-x>"] = { ":bdelete<CR>", desc = "Close current buffer" },
        
        -- Save and quit commands
        ["<C-s>"] = { ":w<CR>", desc = "Save current buffer" },
        ["<C-S-s>"] = { ":wa<CR>", desc = "Save all buffers" },
        ["<C-q>"] = { ":wq<CR>", desc = "Save current buffer and close window" },
        ["<C-S-q>"] = { ":wqa<CR>", desc = "Save all buffers and quit all" },
        
        -- Pet commands (fun!)
        ["<leader>pn"] = { 
          function()
            local pets = {"dog", "cat", "slime", "clippy", "cockatiel", "crab", "mod", "rocky", "rubber duck", "snake", "zappy"}
            local styles = {
              dog = {"brown", "black", "gray", "beige"},
              cat = {"brown", "black", "gray"},
              slime = {"green", "pink", "orange", "blue"},
              clippy = {"black", "brown", "green", "yellow"},
              cockatiel = {"gray"},
              crab = {"red"},
              mod = {"purple"},
              rocky = {"gray"},
              ["rubber duck"] = {"yellow"},
              snake = {"green"},
              zappy = {"yellow"}
            }
            
            -- Pick random pet and style
            local pet = pets[math.random(#pets)]
            local pet_styles = styles[pet]
            local style = pet_styles[math.random(#pet_styles)]
            
            -- Generate unique name with timestamp
            local name = pet .. "_" .. os.time()
            
            vim.cmd("PetsNewCustom " .. pet .. " " .. style .. " " .. name)
          end, 
          desc = "Spawn a random pet" 
        },
        ["<leader>pk"] = { ":PetsKillAll<CR>", desc = "Kill all pets" },
        ["<leader>pl"] = { ":PetsList<CR>", desc = "List all pets" },
        
        -- UI Enhancement commands
        ["<leader>tw"] = { "<cmd>Twilight<cr>", desc = "Toggle Twilight focus mode" },
        ["<leader>nd"] = { function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss notifications" },
        ["<leader>nh"] = { 
          function()
            local ok, telescope = pcall(require, "telescope")
            if ok then
              vim.cmd("Telescope notify")
            else
              vim.notify("Telescope not available", vim.log.levels.WARN)
            end
          end, 
          desc = "Show notification history" 
        },
        
        -- Window splits and navigation
        ["<M-h>"] = { "<C-w>h", desc = "Move to left window" },
        ["<M-j>"] = { "<C-w>j", desc = "Move to window below" },
        ["<M-k>"] = { "<C-w>k", desc = "Move to window above" },
        ["<M-l>"] = { "<C-w>l", desc = "Move to right window" },
        
        -- Window splits
        ["<M-s>"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
        ["<M-v>"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
        
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
