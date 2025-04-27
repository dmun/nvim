return require "lazier" {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local before = dap.listeners.before
    local map = vim.keymap.set

    require("dapui").setup()
    require("dap-go").setup()

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.zig = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
        args = {},
      },
    }

    map("n", "<space>b", dap.toggle_breakpoint)
    map("n", "<space>gb", dap.run_to_cursor)

    map("n", "<space>?", function() require("dapui").eval(nil, { enter = true }) end)

    map("n", "<F1>", dap.continue)
    map("n", "<F2>", dap.step_into)
    map("n", "<F3>", dap.step_over)
    map("n", "<F4>", dap.step_out)
    map("n", "<F5>", dap.step_back)
    map("n", "<F13>", dap.restart)

    before.attach.dapui_config = function() ui.open() end
    before.launch.dapui_config = function() ui.open() end
    before.event_terminated.dapui_config = function() ui.close() end
    before.event_exited.dapui_config = function() ui.close() end
  end,
}
