(fn now [...]
  (let [modules [...]]
    `(MiniDeps.now (fn [...]
                     (each [_# module# (ipairs ,modules)]
                       (require module#))))))

(fn later [...]
  (let [modules [...]]
    `(MiniDeps.later (fn [...]
                       (each [_# module# (ipairs ,modules)]
                         (require module#))))))

(fn au [event pattern callback]
  `(vim.api.nvim_create_autocmd ,event
                                {:pattern ,pattern
                                 :callback #(= (,callback) true)}))

(fn log [x] (vim.notify (vim.inspect x)))

(fn string? [x] (= (type x) :string))

(fn add [args]
  (if (table? args)
      (let [args (?. args :hooks :post_checkout)]
        (when (and args `(string? ,args))
          (let [shell `(or vim.env.SHELL vim.o.sh)
                command [shell :-c args]]
            (set args.hooks.post_checkout
                 (fn [data]
                   (: `(vim.system ,command {:cwd ,data.path}) :wait)))))))
  `(MiniDeps.add ,args))

{: add : au : later : log : now : string?}
