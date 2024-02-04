(fn set- [opt value]
  (tset `vim.o opt value))

(fn setg- [opt value]
  (tset `vim.go opt value))

(fn map [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true}))

(fn remap [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true :remap true}))

(fn cmd [command ...]
  `(let [args# (table.concat (icollect [_# v# (ipairs [,...])]
                               (.. " " v#)))]
     (.. :<CMD> ,command (or args# "") :<CR>)))

(fn hl [group opts]
  `(let [opts# (icollect [k# v# (pairs ,opts)]
                 (string.format "%s=%s" k# v#))]
     (vim.cmd.highlight ,group (.. (unpack opts#)))))

(fn setup [package opts]
  `(let [module# (require ,package)]
     (module#.setup ,opts)))

(fn package! [uri ?opts]
  `(let [spec# (or ,?opts {})]
     (tset spec# 1 ,uri)
     (table.insert _G.packages spec#)))

{: set-
 : setg-
 : map
 : remap
 : cmd
 : hl
 : setup
 : package!}
