-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

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
