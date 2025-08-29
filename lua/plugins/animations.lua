-- Animation and visual effect plugins
return {
  -- Smooth animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        cursor = { enable = true, timing = function(_, n) return 150 / n end },
        scroll = { enable = true, timing = function(_, n) return 150 / n end },
        resize = { enable = true, timing = function(_, n) return 150 / n end },
        open = { enable = true, timing = function(_, n) return 150 / n end },
        close = { enable = true, timing = function(_, n) return 150 / n end },
      })
    end,
  },

  -- Beacon - flash cursor on jumps (more stable than specs)
  {
    "DanilaMihailov/beacon.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.beacon_size = 40
      vim.g.beacon_fade = 1
      vim.g.beacon_minimal_jump = 10
      vim.g.beacon_show_jumps = 1
      vim.g.beacon_shrink = 1
      vim.g.beacon_timeout = 500
      vim.g.beacon_ignore_filetypes = { 'fzf', 'neo-tree', 'TelescopePrompt', 'alpha', 'dashboard', 'packer', 'lazy' }
    end,
  },

  -- Specs - DISABLED due to crashes
  -- {
  --   "edluffy/specs.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("specs").setup({
  --       show_jumps = true,
  --       min_jump = 30,
  --       popup = {
  --         delay_ms = 0,
  --         inc_ms = 10,
  --         blend = 10,
  --         width = 10,
  --         winhl = "PMenu",
  --         fader = require("specs").pulse_fader,
  --         resizer = require("specs").shrink_resizer
  --       },
  --       ignore_filetypes = { "neo-tree", "TelescopePrompt", "alpha", "dashboard", "fzf", "lazy", "packer" },
  --       ignore_buftypes = { "nofile" },
  --     })
  --   end,
  -- },
}
