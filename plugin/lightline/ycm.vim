augroup lightline#ycm
  autocmd!
  autocmd CursorMoved * call lightline#ycm#update()
  autocmd CursorHold * call lightline#ycm#update()
augroup END
