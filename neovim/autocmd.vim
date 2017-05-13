
" make linters on file read / write
autocmd! BufWritePost,BufReadPost * Neomake

" text highlights
augroup my_neomake_highlights
    au!
    autocmd ColorScheme *
      \ hi link NeomakeError ErrorMsg |
      \ hi link NeomakeWarning WarningMsg
augroup END
