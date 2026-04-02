return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = { "bashls", "lua_ls", "cssls", "pylsp" },
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            
            -- Configure LSP servers using the new API
            local servers = {
                bashls = { capabilities = capabilities },
                cssls = { capabilities = capabilities },
                lua_ls = { capabilities = capabilities },
                pylsp = { capabilities = capabilities },
            }

            for server, config in pairs(servers) do
                vim.lsp.config[server] = config
                vim.lsp.enable(server)
            end

            -- Keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definitions" })
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
        end,
    },
}
