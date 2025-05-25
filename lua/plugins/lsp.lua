local map, lsp = vim.keymap.set, vim.lsp
local add = MiniDeps.add

add("folke/lazydev.nvim")
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { "init.lua", ".luarc.json" },
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
    },
  },
}
lsp.enable("lua_ls")

lsp.config("*", {
  root_markers = { ".git" },
})

lsp.config("ty", {
  cmd = { "uv", "run", "ty", "server" },
  filetypes = { "python" },
  root_markers = { "venv", ".venv", "pyproject.toml" },
  settings = {
    ty = {
      experimental = {
        completions = {
          enable = true,
        },
      },
    },
  },
})

lsp.config("pyrefly", {
  cmd = { "pyrefly", "lsp" },
  -- cmd = { vim.fn.expand("~/dev/pyrefly/target/debug/pyrefly"), "lsp" },
  filetypes = { "python" },
  root_markers = { "venv", ".venv", "pyproject.toml" },
})
lsp.enable("pyrefly")

lsp.config("rust-analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
})
lsp.enable("rust-analyzer")

lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "package.json" },
})
lsp.enable("ts_ls")

lsp.config("svelte_ls", {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = { "package.json" },
})
lsp.enable("svelte_ls")

map("n", "grr", lsp.buf.references)
map("n", "gD", lsp.buf.declaration)
map("n", "gd", lsp.buf.definition)
