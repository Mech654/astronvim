-- Fix deprecated vim.lsp.buf_get_clients() in project.nvim and suppress warnings
return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        fix_deprecation_warnings = {
          {
            event = "VimEnter",
            desc = "Fix deprecated LSP functions and suppress warnings",
            callback = function()
              -- Fix project.nvim's deprecated vim.lsp.buf_get_clients() usage
              if vim.lsp.buf_get_clients then
                -- Monkey patch the deprecated function to use the modern equivalent
                vim.lsp.buf_get_clients = function(bufnr)
                  return vim.lsp.get_clients({ bufnr = bufnr or 0 })
                end
              end
              
              -- Store the original notify function for filtering
              local original_notify = vim.notify
              
              -- Override vim.notify to filter out remaining deprecation warnings
              vim.notify = function(msg, level, opts)
                if type(msg) == "string" then
                  -- Suppress any remaining buf_get_clients warnings
                  if msg:match("buf_get_clients.*deprecated") or 
                     msg:match("vim%.lsp%.buf_get_clients") then
                    return -- Suppress this specific warning
                  end
                end
                
                -- For all other messages, use the original notify
                return original_notify(msg, level, opts)
              end
              
              -- Set a flag to indicate we've applied the fixes
              vim.g.deprecation_fixes_applied = true
            end,
          },
        },
      },
    },
  },
}