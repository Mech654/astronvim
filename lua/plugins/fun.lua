-- Fun plugins for entertainment
return {
  -- Pets plugin for virtual pets
  {
    "giusgad/pets.nvim",
    event = "VeryLazy", -- Load automatically
    dependencies = { 
      "MunifTanjim/nui.nvim", 
      "giusgad/hologram.nvim"  -- Author's fork with fixes
    },
    config = function()
      require("pets").setup({
        row = 5, -- Row 5 from top
        col = 0, -- Start from left side (column 0)
        speed_multiplier = 1,
        default_pet = "dog",
        default_style = "brown",
        random = false,
        death_animation = true,
        popup = {
          width = "100%", -- Use full screen width for movement
          winblend = 100,
          hl = { Normal = "Normal" },
          avoid_statusline = false,
        }
      })
      
      -- Spawn a random pet automatically after a delay
      vim.defer_fn(function()
        local pets_list = {"dog", "cat", "slime", "clippy", "cockatiel", "crab", "mod", "rocky", "snake", "zappy"}
        local styles = {
          dog = {"brown", "black", "gray", "beige"},
          cat = {"brown", "black", "gray"},
          slime = {"green", "pink", "orange", "blue"},
          clippy = {"black", "brown", "green", "yellow"},
          cockatiel = {"gray"},
          crab = {"red"},
          mod = {"purple"},
          rocky = {"gray"},
          snake = {"green"},
          zappy = {"yellow"}
        }
        
        -- Pick random pet and style
        local pet = pets_list[math.random(#pets_list)]
        local pet_styles = styles[pet]
        local style = pet_styles[math.random(#pet_styles)]
        
        -- Generate unique name
        local name = pet .. "_buddy"
        
        -- Create the pet
        require("pets").create_pet(name, pet, style)
      end, 500) -- 500ms delay to ensure everything is loaded
    end,
  },
}
