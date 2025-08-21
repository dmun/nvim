(require :globals)
(import-macros {: now : later} :macros)

(now :options
     :keymaps
     :plugins.ui
     :plugins.beepboop)

(later :autocommands
       :plugins.motion
       :plugins.treesitter
       :plugins.mini
       :plugins.files
       :plugins.blink
       :plugins.misc
       :plugins.repl
       :plugins.lsp
       :plugins.llm
       :plugins.editor
       :plugins.tex
       :plugins.sql)

