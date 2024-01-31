(fn def- [opt value]
  `(vim.cmd (string.format "set %s=%s" ,opt ,value)))

(fn map [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs ,{:silent true}))

(fn remap [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs ,{:silent true :remap true}))

(fn cmd [command ...]
  (let [args (table.concat (icollect [_ v (ipairs [...])]
                               (.. " " v)))]
     (.. :<CMD> command args "" :<CR>)))

(lambda package! [uri ?opts]
  `(let [spec# (or ,?opts {})]
    (tset spec# 1 ,uri)
    (table.insert _G.packages spec#)))

{: def-
 : map
 : remap
 : cmd
 : package!}
