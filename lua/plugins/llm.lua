require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = { accept = "<Tab>" },
  },
  filetypes = {
    ["*"] = false,
    javascript = true,
    typescript = true,
    python = true,
  },
})
