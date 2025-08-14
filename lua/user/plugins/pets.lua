return {
  "giusgad/pets.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("pets").setup({
      row = 5, -- the row (height) to display the pet at (must be 1< row < editor height)
      col = 0, -- the column to display the pet at (must be 0< col < editor width)
      speed_multiplier = 1, -- you can make your pet faster/slower. If slower the animation will have lower fps.
      default_pet = "dog", -- the pet to use for the PetNew command
      default_style = "brown", -- style of the pet (see below for options)
      random = false, -- whether to use a random pet for the PetNew command, overrides default_pet
      death_animation = true, -- animate the pet's death, set to false to feel less guilt -- :-(
      popup = { -- popup options, try changing these if you see a rectangle around the pet
        width = "30%",
        winblend = 100,
        hl = { Normal = "Normal" },
        avoid_statusline = false,
      }
    })
  end,
}
