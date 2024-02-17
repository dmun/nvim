(fn str? [val]
  (if (= (type val) :string) true false))

(lambda vim-set [scope opt ?val]
  (assert-compile (sym? opt) "expected symbol" opt)
  (let [(opt num) (string.gsub (tostring opt) :^no "")]
    (let [val (if (= num 1) false
                  (= ?val nil) true
                  ?val)]
      `(tset (. vim ,scope) ,opt ,val))))

(lambda se [opt ?val]
  (vim-set :o opt ?val))

(lambda setg [opt ?val]
  (vim-set :g opt ?val))

(lambda setl [opt ?val]
  (vim-set :bo opt ?val))

(fn parse-comma [input]
  (pick-values 1 (string.gsub input :<comma> ",")))

(fn parse-format [input val]
  `(string.format ,(string.gsub input "<%?>" "%%s") ,val))

(fn vim-keymap-set [mode lhs rhs ?key]
  (let [lhs (-> (tostring lhs)
                (parse-comma)
                (parse-format ?key))
        rhs (parse-format rhs ?key)]
    `(vim.keymap.set ,mode ,lhs ,rhs {:silent true})))

(fn nmap [lhs rhs ?key]
  (vim-keymap-set :n lhs rhs ?key))

(fn imap [lhs rhs]
  (vim-keymap-set :i lhs rhs))

(fn vmap [lhs rhs]
  (vim-keymap-set :v lhs rhs))

(fn remap [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true :remap true}))

(fn cmd [command ...]
  `(let [args# (table.concat (icollect [_# v# (ipairs [,...])]
                               (.. " " v#)))]
     (.. :<CMD> ,command (or args# "") :<CR>)))

(lambda hl [group opts]
  (assert-compile (sym? group) "expected symbol" group)
  (let [group (tostring group)
        opts (icollect [k v (pairs opts)]
               (string.format "%s=%s" k v))]
    `(vim.cmd.highlight ,group ,(.. (unpack opts)))))

(fn setup [package opts]
  `(let [module# (require ,package)]
     (module#.setup ,opts)))

(fn plug [uri ?opts]
  `(let [spec# (or ,?opts {})]
     (tset spec# 1 ,uri)
     (table.insert _G.packages spec#)))

(fn au [group opts]
  `(vim.api.nvim_create_autocmd ,group ,opts))

(fn aug [group opts]
  `(vim.api.nvim_create_augroup ,group ,opts))

{: str?
 : se
 : setg
 : nmap
 : imap
 : vmap
 : remap
 : cmd
 : hl
 : au
 : aug
 : setup
 : plug}

