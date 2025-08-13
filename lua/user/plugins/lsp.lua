return {
    {
        "neovim/nvim-lspconfig",
        priority = 1000, -- High priority to ensure this loads early
        config = function()
            -- Clear any existing omnisharp config first
            local lspconfig = require("lspconfig")
            if lspconfig.omnisharp then
                lspconfig.omnisharp.setup({})
            end
            
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/OmniSharp"

            -- Debug: Check what cmd we're actually setting
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

            -- Notify so we know this file is running
            vim.notify("Configuring OmniSharp LSP at: " .. mason_bin)
            vim.notify("CMD: " .. vim.inspect(cmd_table))

            -- Force override any existing setup
            lspconfig.omnisharp.setup({
                cmd = cmd_table,
                root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
                on_init = function(client, _)
                    vim.notify("OmniSharp initialized with cmd: " .. vim.inspect(client.config.cmd))
                end,
            })
        end,
    },
}
