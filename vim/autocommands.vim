augroup ExtraFiletypes
  autocmd!
  autocmd BufRead,BufEnter *.swiftinterface setfiletype swift
  autocmd BufRead,BufEnter .swift-format setfiletype json
  autocmd BufRead,BufEnter *.dagitty setfiletype luau
  autocmd BufRead,BufEnter *.metal setfiletype metal
  autocmd BufRead,BufEnter config setfiletype conf
  autocmd BufRead,BufEnter hyprland.conf setfiletype hyprlang
augroup END

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

augroup CleanUI
  autocmd!
  autocmd BufEnter,WinEnter * if index(['copilot-chat', 'copilot-diff', 'copilot-overlay', 'oil'], &filetype) >= 0 |
    \ setlocal norelativenumber nonumber signcolumn=no |
  \ endif
augroup END

augroup Terminal
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
  "autocmd TermOpen * startinsert
  "autocmd BufEnter,WinEnter * if &buftype == 'terminal' |
  "  \ startinsert |
augroup END

autocmd BufWinEnter * set statusline=\ %t\ %m%{&modified?'':'\ \ \ '}\ %p%%\ (%l,\ %c)%=%{get(b:,'gitsigns_status','')}\ \ %{empty(get(b:,'gitsigns_head',''))?'':'Git\ '}%{get(b:,'gitsigns_head','')}

 "augroup CmdHeightAdjust
 "  autocmd!
 "  autocmd CmdlineEnter * set cmdheight=1
 "  autocmd CmdlineLeave * set cmdheight=0
 "augroup END

 "autocmd InsertEnter * if &number | set norelativenumber | endif
 "autocmd InsertLeave * if &number | set relativenumber | endif
