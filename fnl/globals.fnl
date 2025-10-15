(global setup (fn [name opts]
                (let [plugin (require name)]
                  (plugin.setup opts))))

(global now MiniDeps.now)
(global later MiniDeps.later)

(global add (fn [opts]
              (when (= (type opts) :table)
                (let [args (vim.tbl_get opts :hooks :post_checkout)]
                  (when (= (type args) :string)
                    (let [shell (or vim.env.SHELL vim.o.sh)
                          command [shell :-c args]]
                      (set opts.hooks.post_checkout
                           (fn [data]
                             (: (vim.system command {:cwd data.path}) :wait)))))))
              (MiniDeps.add opts)))

(global db (fn [...]
             (vim.notify (vim.inspect ...))))

(global au (fn [event pattern callback group buffer]
             (vim.api.nvim_create_autocmd event
                                          {: pattern
                                           : callback
                                           : buffer
                                           : group})))

(global cmd vim.cmd)

(global map (fn [mode lhs rhs ?opts]
              (case [mode lhs rhs ?opts]
                [m x y ?z] (vim.keymap.set m x y ?z)
                [x y ?z _] (vim.keymap.set [:n :x :o] x y ?z))))

(global nmap (partial map :n))
(global vmap (partial map :v))
(global xmap (partial map :x))
(global imap (partial map :i))
(global tmap (partial map :t))
(global omap (fn [lhs rhs]
               (map :o lhs rhs {:expr true})))
