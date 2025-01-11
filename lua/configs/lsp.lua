vim.g.zig_fmt_autosave = 0

Conf.lsp = {
  ensure_installed = { "lua_ls" },
  ls_name = { lua_ls = "Lua" },
}

Conf.ls.pyright = {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      ignore = { "*" },
      typeCheckingMode = "off",
    },
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

-- Conf.ls.zls = {
--   on_init = function(client, _)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- }

Conf.ls["r_language_server"] = {
  settings = {
    lsp = {
      diagnostics = false,
    },
  },
}

Conf.ls.ltex = {
  filetypes = { "tex", "typst", "markdown" },
  autostart = false,
  diagnostics = { virtual_text = false },
  settings = {
    -- language = "nl",
    additionalRules = { enablePickyRules = true },
    checkFrequency = "save",
    completionEnabled = true,
    latex = { commands = { ["\\inline{}"] = "dummy" } },
  },
}

Conf.ls.lua_ls = {
  settings = {
    -- completion = { callSnippet = "Replace" },
    diagnostics = { globals = { "vim" } },
  },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      return
    end
    -- client.server_capabilities.semanticTokensProvider = nil

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/love2d/library",
          -- "~/.local/share/nvim/lazy/"
        },
      },
    })
  end,
}
