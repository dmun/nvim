local lsp = vim.lsp

add("folke/lazydev.nvim")
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { "init.lua", ".luarc.json" },
  settings = {
    Lua = {
      definition = {
        showWord = false,
      },
      runtime = {
        version = "LuaJIT",
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
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

lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "svelte", "postcss" },
  root_markers = { "package.json" },
})
lsp.enable("tailwindcss")

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

nmap("grr", lsp.buf.references)
nmap("gD",  lsp.buf.declaration)
nmap("gd",  lsp.buf.definition)
