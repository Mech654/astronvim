require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^5",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  { import = "community" },
  { import = "plugins" },

  -- ↓ Add this here
  {
    "navarasu/onedark.nvim",
    config = function()
    require("onedark").setup { style = "dark" }
    require("onedark").load()
    end,
  },
}, {
  install = { colorscheme = { "onedark", "astrotheme", "habamax" } }, -- put onedark first
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})
