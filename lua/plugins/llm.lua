require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = { accept = "<S-Tab>" },
  },
  filetypes = {
    ["*"] = false,
    javascript = true,
    typescript = true,
    typescriptreact = true,
    python = true,
    json = true,
  },
})
