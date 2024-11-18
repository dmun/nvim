; extends
(module
 (comment) @cell.start
 (#lua-match? @cell.start "^# %%%%")
 .
 (_)+ @cell.content
 (#not-any-lua-match? @cell.content "^# %%%%")
 .
 (comment)? @cell.end
 (#lua-match? @cell.end "^# %%%%")
 (#make-range! "cell.outer" @cell.start @cell.content)
)
