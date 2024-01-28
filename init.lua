local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
if not vim.loop.fs_stat(hotpotpath) then
    vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        -- You may with to pin a known version tag with `--branch=vX.Y.Z`
        "--branch=v0.9.6",
        "https://github.com/rktjmp/hotpot.nvim.git",
        hotpotpath,
    })
end

vim.opt.rtp:prepend({ hotpotpath, lazypath })

require("defaults")

require("hotpot")

local plugins = {
    {
        "rktjmp/hotpot.nvim",
    },
}

local plugins_path = vim.fn.stdpath("config") .. "/fnl/plugins"
if vim.loop.fs_stat(plugins_path) then
    for file in vim.fs.dir(plugins_path) do
        file = file:match("^(.*)%.fnl$")
        table.insert(plugins, require("plugins." .. file))
    end
end

plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"
if vim.loop.fs_stat(plugins_path) then
    for file in vim.fs.dir(plugins_path) do
        file = file:match("^(.*)%.lua$")
        table.insert(plugins, require("plugins." .. file))
    end
end

require("lazy").setup(plugins, {
    ui = {
        size = { width = 1, height = 1 },
    },
})
