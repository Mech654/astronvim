return {
    {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").setup({ 
                style = "darker" -- try 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
            })
            require("onedark").load()
        end,
    },
}
