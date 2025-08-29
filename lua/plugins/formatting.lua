-- Formatting and linting configuration
return {
  -- Mason tool installer for formatters and linters
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- JavaScript/TypeScript
        "prettier",        -- Formatter for JS/TS/JSON/HTML/CSS
        "eslint_d",        -- Fast ESLint daemon
        
        -- Python
        "black",           -- Python formatter
        "isort",           -- Python import sorter
        "flake8",          -- Python linter
        "mypy",            -- Python type checker
        
        -- General
        "stylua",          -- Lua formatter
      })
    end,
  },

  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        
        -- Web technologies
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        
        -- Python
        python = { "black", "isort" },
        
        -- Lua
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Nvim-lint for additional linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "flake8", "mypy" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      -- Auto-lint on file events
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}