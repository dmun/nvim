(lambda set! [opt value]
  (vim.cmd (string.format "set %s=%s" opt value)))

(lambda nil? [value]
  (= value nil))

(lambda string? [value]
  (= (type value) :string))

(lambda table? [value]
  (= (type value) :table))

(lambda nmap [lhs rhs ?silent]
  (vim.keymap.set :n lhs rhs {:silent (or ?silent false)}))

(lambda package-add [uri ?opts]
  (assert (string? uri) "invalid uri type")
  (if ?opts
      (do
        (assert (table? ?opts) "invalid ?opts type")))
  (let [spec (or ?opts {})]
    (tset spec 1 uri)
    (table.insert _G.packages spec)))

(nmap :<leader>as ":ASToggle<CR>")

(package-add :luukvbaal/statuscol.nvim
             {:enabled false
              :config (fn []
                        (let [statuscol (require :statuscol)]
                          (statuscol.setup)))})

(package-add :Olical/conjure)
(package-add :xiyaowong/virtcolumn.nvim
             {:enabled false
              :config (fn []
                        (set! :cc 80))})

(package-add :okuuva/auto-save.nvim {:opts {}})
(package-add :kylechui/nvim-surround {:version "*" :event :VeryLazy :opts {}})
(package-add :ggandor/flit.nvim {:opts {}})
(package-add :gpanders/nvim-parinfer)
(package-add :jghauser/mkdir.nvim)
(package-add :stevearc/oil.nvim
             {:opts {} :dependencies [:nvim-tree/nvim-web-devicons]})

(package-add :ThePrimeagen/harpoon {:lazy true})
