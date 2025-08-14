return {
  "DanilaMihailov/beacon.nvim",
  event = "VeryLazy",
  config = function()
    vim.g.beacon_size = 40        -- Size of the beacon
    vim.g.beacon_fade = 1         -- Fade the beacon
    vim.g.beacon_minimal_jump = 10 -- Only show beacon for jumps of 10+ lines
    vim.g.beacon_show_jumps = 1   -- Show beacon when jumping with j/k
    vim.g.beacon_shrink = 1       -- Shrink beacon size over time
    vim.g.beacon_timeout = 500    -- How long beacon stays visible (ms)
    
    -- Disable beacon in certain filetypes
    vim.g.beacon_ignore_filetypes = {
      'fzf',
      'neo-tree',
      'TelescopePrompt',
      'alpha',
      'dashboard',
      'packer',
      'lazy',
    }
  end,
}
