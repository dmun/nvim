require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup {
            autostart = server_name ~= "ltex",
            settings = {
                ltex = {
                    language = "nl",
                    filetype = { "norg" },
                    additionalRules = {
                        enablePickyRules = true,
                    },
                }
            },
        }
    end,
})
