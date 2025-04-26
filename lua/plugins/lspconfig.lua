local augroup = require("util.augroup")
local map = vim.keymap.set

local function get_ls_config(config)
  return {
    filetypes = config and config.filetypes or nil,
    autostart = config and (config.autostart ~= false),
    on_init = config and config.on_init or nil,
    capabilities = vim.tbl_deep_extend(
      "force",
      require("blink.cmp").get_lsp_capabilities() or {},
      config and config.capabilities or {}
    ),
  }
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/lazydev.nvim",
  },
  config = function()
    local lsp = require("lspconfig")
    local mason_lsp = require("mason-lspconfig")

    require("mason").setup()
    mason_lsp.setup()
    mason_lsp.setup_handlers({
      function(ls) lsp[ls].setup(get_ls_config()) end,
    })

    augroup("UserLspConfig"):au({
      event = "LspAttach",
      callback = function(ev)
        local opts = { buffer = ev.buf }
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<C-w><C-d>", vim.diagnostic.open_float, opts)
        map("i", "<C-s>", vim.lsp.buf.signature_help, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<C-c>", vim.lsp.buf.code_action, opts)
      end,
    })
  end,
}
