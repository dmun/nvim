(require :globals)
(import-macros {: now : later} :macros)

(add :Olical/conjure)
(map :me vim.cmd.ConjureEval)
(map :- vim.cmd.Oil)

(now :options
     :keymaps
     :plugins.ui)

(later :autocommands
       :plugins.motion
       :plugins.treesitter
       :plugins.mini
       :plugins.files
       :plugins.blink
       :plugins.lsp
       :plugins.llm
       :plugins.editor
       :plugins.sql)

