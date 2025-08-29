-- Simple SQL highlighting in JS/TS template strings
return {
  -- Basic SQL highlighting setup
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        sql_highlighting = {
          {
            event = { "FileType" },
            pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            desc = "Enable SQL highlighting in template literals",
            callback = function()
              -- Set up SQL highlighting in template literals
              vim.defer_fn(function()
                vim.cmd([[
                  " Match template literals with sql/query tags
                  syntax match sqlTag /\v(sql|query|SQL|QUERY)\s*`/me=e-1
                  syntax region sqlTemplate start=/\v(sql|query|SQL|QUERY)\s*`/ end=/`/ contains=sqlKeywords,sqlTag
                  
                  " SQL keywords
                  syntax keyword sqlKeywords SELECT FROM WHERE INSERT UPDATE DELETE CREATE ALTER DROP TABLE INDEX JOIN INNER LEFT RIGHT OUTER ON AS AND OR NOT NULL TRUE FALSE contained
                  
                  " Set colors
                  highlight sqlTemplate ctermfg=214 guifg=#FFB86C cterm=italic gui=italic
                  highlight sqlKeywords ctermfg=228 guifg=#F1FA8C cterm=bold gui=bold
                  highlight sqlTag ctermfg=214 guifg=#FFB86C
                ]])
              end, 100)
            end,
          },
        },
      },
    },
  },
}