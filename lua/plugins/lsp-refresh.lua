-- Aggressive LSP refresh and workspace management
return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        -- Aggressive LSP refresh group
        lsp_refresh = {
          {
            event = "BufWritePost",
            desc = "Force LSP refresh on file save",
            callback = function()
              -- Force LSP workspace refresh
              vim.defer_fn(function()
                -- Restart all LSP clients for current buffer
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                for _, client in ipairs(clients) do
                  if client.name ~= "copilot" then -- Don't restart Copilot
                    -- Force workspace refresh
                    if client.server_capabilities.workspace then
                      pcall(client.request, "workspace/didChangeWatchedFiles", {
                        changes = {
                          {
                            uri = vim.uri_from_bufnr(0),
                            type = 2 -- Changed
                          }
                        }
                      })
                    end
                    
                    -- Force file sync
                    pcall(client.request, "textDocument/didSave", {
                      textDocument = { uri = vim.uri_from_bufnr(0) }
                    })
                    
                    -- Clear and refresh diagnostics
                    vim.diagnostic.reset()
                    vim.defer_fn(function()
                      vim.diagnostic.show()
                    end, 100)
                  end
                end
                
                -- Force treesitter refresh
                pcall(vim.treesitter.stop, 0)
                vim.defer_fn(function()
                  pcall(vim.treesitter.start, 0)
                end, 50)
                
                -- Notify user
                vim.notify("LSP workspace refreshed", vim.log.levels.INFO, { timeout = 1000 })
              end, 100)
            end,
          },
          
          {
            event = { "BufEnter", "BufWinEnter" },
            desc = "Refresh LSP on buffer enter",
            callback = function()
              vim.defer_fn(function()
                -- Force diagnostic refresh
                vim.diagnostic.show()
                
                -- Trigger LSP document sync
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                for _, client in ipairs(clients) do
                  if client.name ~= "copilot" then
                    pcall(client.request, "textDocument/didOpen", {
                      textDocument = {
                        uri = vim.uri_from_bufnr(0),
                        languageId = vim.bo.filetype,
                        version = vim.api.nvim_buf_get_changedtick(0),
                        text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
                      }
                    })
                  end
                end
              end, 200)
            end,
          },
          
          {
            event = "LspAttach",
            desc = "Setup aggressive LSP refresh keybinds",
            callback = function(event)
              local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
              end
              
              -- Force LSP restart for current buffer
              map("<leader>lr", function()
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                for _, client in ipairs(clients) do
                  if client.name ~= "copilot" then
                    client.stop()
                    vim.defer_fn(function()
                      vim.cmd("LspStart " .. client.name)
                    end, 1000)
                  end
                end
                vim.notify("LSP restarted for current buffer", vim.log.levels.WARN)
              end, "Restart LSP")
              
              -- Nuclear option - restart all LSP
              map("<leader>lR", function()
                vim.cmd("LspStop")
                vim.defer_fn(function()
                  vim.cmd("LspStart")
                  vim.notify("All LSP servers restarted", vim.log.levels.WARN)
                end, 2000)
              end, "Restart ALL LSP servers")
              
              -- Force workspace reload
              map("<leader>lw", function()
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                for _, client in ipairs(clients) do
                  if client.name ~= "copilot" then
                    -- Force workspace folders refresh
                    if client.server_capabilities.workspace and client.server_capabilities.workspace.workspaceFolders then
                      local workspace_folders = client.workspace_folders or {}
                      for _, folder in ipairs(workspace_folders) do
                        pcall(client.request, "workspace/didChangeWatchedFiles", {
                          changes = {
                            {
                              uri = folder.uri,
                              type = 2 -- Changed
                            }
                          }
                        })
                      end
                    end
                  end
                end
                vim.notify("Workspace refreshed", vim.log.levels.INFO)
              end, "Refresh workspace")
            end,
          },
        },
        
        -- File system watcher
        file_watcher = {
          {
            event = "FocusGained",
            desc = "Refresh everything when window gains focus",
            callback = function()
              -- Check for external file changes
              vim.cmd("checktime")
              
              -- Force LSP refresh
              vim.defer_fn(function()
                local clients = vim.lsp.get_clients()
                for _, client in ipairs(clients) do
                  if client.name ~= "copilot" then
                    pcall(client.request, "workspace/didChangeConfiguration", {})
                  end
                end
              end, 100)
            end,
          },
        },
      },
    },
  },
}