-- Language support: TypeScript, JavaScript, Python
return {
  -- Filetype associations for JSX/TSX
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        g = {
          -- Ensure JSX files use proper syntax highlighting
          jsx_ext_required = 0, -- Allow JSX syntax in .js files
        },
      },
      autocmds = {
        jsx_filetype_fix = {
          {
            event = { "BufNewFile", "BufRead" },
            pattern = "*.jsx",
            desc = "Set JSX filetype to use javascript parser",
            callback = function()
              vim.bo.filetype = "javascriptreact"
            end,
          },
          {
            event = { "BufNewFile", "BufRead" }, 
            pattern = "*.tsx",
            desc = "Set TSX filetype to use typescript parser",
            callback = function()
              vim.bo.filetype = "typescriptreact"
            end,
          },
        },
      },
    },
  },

  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add languages to the ensure_installed list
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
          "typescript",
          "javascript",
          "tsx",
          -- Note: JSX syntax is handled by javascript and tsx parsers
          -- "jsx" parser is deprecated/not available in recent treesitter
          "python",
          "json",
          "html",
          "css",
          "scss",
          "markdown",
          "yaml",
          "toml",
          "bash",
          "lua",
          "vim",
          "vimdoc",
          -- Additional parsers for better embedded language support
          "jsdoc",
          "regex",
          "comment",
          -- SQL support for template literals
          "sql",
        })
      end

      -- Basic treesitter configuration
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true

      return opts
    end,
    config = function(_, opts)
      },

  -- Mason configuration for LSP servers
    end,
  },

  -- Mason configuration for LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "tsserver",        -- TypeScript/JavaScript
        "eslint",          -- ESLint for JS/TS
        "pyright",         -- Python
        "ruff_lsp",        -- Python linting/formatting
        "html",            -- HTML
        "cssls",           -- CSS
        "jsonls",          -- JSON
        -- SQL support
        "sqlls",           -- SQL Language Server
      })
    end,
  },

  -- Mason tool installer for formatters and linters
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",          -- Python debugger
        "js",              -- JavaScript debugger
      })
    end,
  },

  -- LSP configuration
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        -- TypeScript/JavaScript LSP
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
          },
          -- Enable HTML/CSS completion in JS/TS strings
          init_options = {
            plugins = {
              {
                name = "@volar/typescript-plugin",
                location = "",
                languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
              },
            },
          },
        },

        -- Python LSP (Pyright)
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
              },
            },
          },
        },

        -- Ruff LSP for Python linting/formatting
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },

        -- ESLint for JS/TS linting
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },

        -- HTML LSP
        html = {
          filetypes = { "html", "templ" },
        },

        -- JSON LSP
        jsonls = {
          settings = {
            json = {
              schemas = {
                {
                  fileMatch = { "package.json" },
                  url = "https://json.schemastore.org/package.json",
                },
                {
                  fileMatch = { "tsconfig*.json" },
                  url = "https://json.schemastore.org/tsconfig.json",
                },
              },
            },
          },
        },

        -- SQL LSP
        sqlls = {
          settings = {
            sqlLanguageServer = {
              connections = {},
              lintOptions = {
                rules = {},
              },
            },
          },
        },
      },
    },
  },

  -- Additional TypeScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = "all",
          tsserver_path = nil,
          tsserver_plugins = {},
          tsserver_max_memory = "auto",
          complete_function_calls = false,
          include_completions_with_insert_text = true,
        },
      })
    end,
  },
}