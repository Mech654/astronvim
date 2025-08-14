return {
  "edluffy/specs.nvim",
  event = "VeryLazy",
  config = function()
    require("specs").setup({
      show_jumps = true,
      min_jump = 30,
      popup = {
        delay_ms = 0, -- delay before popup shows
        inc_ms = 10, -- time increments used for fade/resize effects 
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 10,
        winhl = "PMenu",
        fader = require("specs").pulse_fader,
        resizer = require("specs").shrink_resizer
      },
      ignore_filetypes = {
        "neo-tree",
        "TelescopePrompt", 
        "alpha",
        "dashboard",
        "fzf",
        "lazy",
        "packer",
      },
      ignore_buftypes = {
        "nofile",
      },
    })
  end,
}
