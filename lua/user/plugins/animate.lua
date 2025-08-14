return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  config = function()
    require("mini.animate").setup({
      cursor = {
        enable = true,
        timing = function(_, n) return 150 / n end, -- Animate cursor movement
      },
      scroll = {
        enable = true,
        timing = function(_, n) return 150 / n end, -- Animate scrolling
      },
      resize = {
        enable = true,
        timing = function(_, n) return 150 / n end, -- Animate window resize
      },
      open = {
        enable = true,
        timing = function(_, n) return 150 / n end, -- Animate window open
      },
      close = {
        enable = true,
        timing = function(_, n) return 150 / n end, -- Animate window close
      },
    })
  end,
}
