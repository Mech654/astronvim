-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- Pets plugin for virtual pets
  {
    "giusgad/pets.nvim",
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
    end,
  },

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
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
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

  -- Beacon - flash cursor on jumps
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

  -- Specs - cursor position indicator
  {
    "edluffy/specs.nvim",
    event = "VeryLazy",
    config = function()
      require("specs").setup({
        show_jumps = true,
        min_jump = 30,
        popup = {
          delay_ms = 0,
          inc_ms = 10,
          blend = 10,
          width = 10,
          winhl = "PMenu",
          fader = require("specs").pulse_fader,
          resizer = require("specs").shrink_resizer
        },
        ignore_filetypes = { "neo-tree", "TelescopePrompt", "alpha", "dashboard", "fzf", "lazy", "packer" },
        ignore_buftypes = { "nofile" },
      })
    end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- Custom OmniSharp LSP Configuration
  {
    "neovim/nvim-lspconfig",
    priority = 1000,
    config = function()
      local lspconfig = require("lspconfig")
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/OmniSharp"

      local cmd_table = { 
        mason_bin,
        "--languageserver",
        "--hostPID", 
        tostring(vim.fn.getpid()),
        "DotNet:enablePackageRestore=false",
        "--encoding", 
        "utf-8",
        "Sdk:IncludePrereleases=true",
        "FormattingOptions:EnableEditorConfigSupport=true"
      }

      lspconfig.omnisharp.setup({
        cmd = cmd_table,
        root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
      })
    end,
  },

  -- Trouble plugin for diagnostics panel
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>x",
        function()
          -- Create a simple menu for Trouble options
          local options = {
            { key = "x", desc = "Toggle Diagnostics", cmd = "Trouble diagnostics toggle" },
            { key = "X", desc = "Buffer Diagnostics", cmd = "Trouble diagnostics toggle filter.buf=0" },
            { key = "s", desc = "Symbols", cmd = "Trouble symbols toggle focus=false" },
            { key = "l", desc = "LSP References", cmd = "Trouble lsp toggle focus=false win.position=right" },
            { key = "L", desc = "Location List", cmd = "Trouble loclist toggle" },
            { key = "q", desc = "Quickfix List", cmd = "Trouble qflist toggle" },
          }
          
          -- Display menu
          vim.ui.select(options, {
            prompt = "Trouble Options:",
            format_item = function(item)
              return item.key .. ": " .. item.desc
            end,
          }, function(choice)
            if choice then
              vim.cmd(choice.cmd)
            end
          end)
        end,
        desc = "Trouble Menu",
      },
      -- Quick access to most common one
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle Diagnostics",
      },
    },
  },

  -- Project management plugin
  {
    "ahmedkhalf/project.nvim",
    opts = {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "*.sln", "*.csproj" },
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },

  -- Dashboard with project option
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        opt = {
          cmdheight = 0,
        },
      },
    },
  },

  -- Override AstroNvim dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "ahmedkhalf/project.nvim" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        "    ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
        "    ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
        "    ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
        "    ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
        "    ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
        "    ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", function() 
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks and snacks.picker then
            snacks.picker.files()
          end
        end),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "  Projects", function()
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks and snacks.picker and snacks.picker.projects then
            snacks.picker.projects()
          else
            vim.notify("Projects picker not available", vim.log.levels.WARN)
          end
        end),
        dashboard.button("r", "  Recent Files", function()
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks and snacks.picker then
            snacks.picker.recent()
          end
        end),
        dashboard.button("t", "  Find Text", function()
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks and snacks.picker then
            snacks.picker.grep()
          end
        end),
        dashboard.button("c", "  Config", ":edit ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Set footer
      dashboard.section.footer.val = { "Happy coding!" }

      alpha.setup(dashboard.opts)
    end,
  },
}
