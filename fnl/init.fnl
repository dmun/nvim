(require :globals)

(now (fn []
       (require :options)
       (require :keymaps)
       (require :plugins.ui)))

(later (fn []
         (require :autocommands)
         (require :plugins.motion)
         (require :plugins.treesitter)
         (require :plugins.mini)
         (require :plugins.files)
         (require :plugins.blink)
         (require :plugins.misc)
         (require :plugins.repl)
         (require :plugins.lsp)
         (require :plugins.llm)
         (require :plugins.editor)
         (require :plugins.tex)
         (require :plugins.sql)))
