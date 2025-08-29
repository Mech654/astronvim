-- UI Enhancement plugins
return {
  -- Colorizer - show actual colors for hex codes
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
          tailwind = true,
          sass = { enable = true, parsers = { "css" } },
          virtualtext = "■",
        },
        buftypes = {},
      })
    end,
  },

  -- Twilight - dim inactive code
  {
    "folke/twilight.nvim",
    event = "VeryLazy", -- Load automatically instead of on command
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          term_bg = "#000000",
          inactive = false,
        },
        context = 10,
        treesitter = true,
        expand = { "function", "method", "table", "if_statement" },
        exclude = {},
      })
      
      -- Enable twilight by default after a short delay
      vim.defer_fn(function()
        require("twilight").enable()
      end, 100)
    end,
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        max_height = function() return math.floor(vim.o.lines * 0.75) end,
        max_width = function() return math.floor(vim.o.columns * 0.75) end,
        render = "default",
        background_colour = "#000000",
        fps = 30,
        level = 2,
        minimum_width = 50,
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      vim.notify = notify
    end,
  },
}
