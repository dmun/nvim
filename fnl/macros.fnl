(fn str? [val]
  (if (= (type val) :string) true false))

(fn tbl? [val]
  (if (= (type val) :table) true false))

(fn str->tbl [str]
  (let [tbl {}]
    (for [i 1 (length str)]
      (table.insert tbl (string.sub str i i)))
    tbl))

(fn table.merge [tbl1 tbl2]
  (for [i 1 (length tbl2)]
    (table.insert tbl1 (. tbl2 i)))
  tbl1)

(fn parse-operation [scope opt ?operator]
  (let [scope (case scope
                :g :g
                :l :opt_local
                _ :opt)]
    (string.format "vim.%s.%s:%s" scope opt ?operator)))

(fn vim-set [scope opt ?val ?operator]
  (assert-compile (sym? opt) "expected symbol" opt)
  (let [(opt matches) (string.gsub (tostring opt) :^no "")]
    (case [matches opt ?val ?operator]
      [1 x _ _] `(tset (. vim ,scope) ,x false)
      [0 x y z] `(,(parse-operation scope x z) ,y)
      [0 x y _] `(tset (. vim ,scope) ,x ,y)
      [0 x _ _] `(tset (. vim ,scope) ,x true))))

(lambda se [opt ?val]
  (vim-set :o opt ?val))

(lambda se+ [opt ?val]
  (vim-set :o opt ?val :append))

(lambda se^ [opt ?val]
  (vim-set :o opt ?val :prepend))

(lambda se- [opt ?val]
  (vim-set :o opt ?val :remove))

(lambda setg [opt ?val]
  (vim-set :g opt ?val))

(lambda setl [opt ?val]
  (vim-set :bo opt ?val))

(fn parse-comma [input]
  (pick-values 1 (string.gsub input :<comma> ",")))

(fn parse-format [input val]
  `(string.format ,(string.gsub input "<%?>" "%%s") ,val))

(fn vim-map [modes lhs rhs ?opts]
  (let [modes (str->tbl modes)
        lhs (-> (tostring lhs)
                (parse-comma))
        opts (table.merge {:silent true} (or ?opts {}))]
    `(vim.keymap.set ,modes ,lhs ,rhs ,opts)))

(fn map [modes lhs rhs]
  (vim-map modes lhs rhs))

(fn xmap [modes lhs rhs]
  (vim-map modes lhs rhs {:expr true}))

(fn nmap [lhs rhs]
  (vim-map :n lhs rhs))

(fn imap [lhs rhs]
  (vim-map :i lhs rhs))

(fn vmap [lhs rhs]
  (vim-map :v lhs rhs))

(fn tmap [lhs rhs]
  (vim-map :t lhs rhs))

(fn nremap [lhs rhs]
  (vim-map :n lhs rhs {:remap true}))

(fn cmd [command ...]
  `(let [args# (table.concat (icollect [_# v# (ipairs [,...])]
                               (.. " " v#)))]
     (.. :<CMD> ,command (or args# "") :<CR>)))

(lambda hl [group opts]
  ; (assert-compile (sym? group) "expected symbol" group)
  (let [group (tostring group)]
    (if (table? opts)
        (let [opts (icollect [k v (pairs opts)]
                     (string.format "%s=%s"
                                    (case k
                                      :fg :guifg
                                      :bg :guibg
                                      _ k) v))]
          `(vim.cmd.highlight ,group ,(.. (unpack opts))))
        (let [opts (tostring opts)]
          `(vim.cmd (.. "highlight! link " ,group " " ,opts))))))

(fn sign [sign opts]
  (assert-compile (sym? sign) "expected symbol" sign)
  `(vim.fn.sign_define ,(tostring sign) ,opts))

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
 : se+
 : se-
 : setg
 : setl
 : map
 : xmap
 : nmap
 : imap
 : vmap
 : tmap
 : nremap
 : cmd
 : hl
 : au
 : aug
 : sign
 : setup
 : plug}

