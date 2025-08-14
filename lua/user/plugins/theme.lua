return {
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- High priority to load early
        config = function()
            require("onedark").setup({ 
                style = "darker" -- try 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
            })
            require("onedark").load()
            -- Ensure it's set as the colorscheme
            vim.cmd.colorscheme("onedark")
        end,
    },
}
