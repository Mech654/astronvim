return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    { "<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss notifications" },
    { "<leader>nh", "<cmd>Telescope notify<cr>", desc = "Show notification history" },
  },
  config = function()
    local notify = require("notify")
    
    notify.setup({
      stages = "fade_in_slide_out", -- Animation style: fade, slide, fade_in_slide_out, static
      timeout = 3000, -- Default timeout for notifications
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
      render = "default", -- Render style: default, minimal, simple
      background_colour = "#000000", -- For stages that change opacity
      fps = 30, -- Frames per second for animations
      level = 2, -- Minimum log level to display (TRACE=0, DEBUG=1, INFO=2, WARN=3, ERROR=4, OFF=5)
      minimum_width = 50,
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })
    
    -- Set nvim-notify as the default notification handler
    vim.notify = notify
    
    -- Integration with Telescope for notification history
    require("telescope").load_extension("notify")
  end,
}
