" If user didn't provide symbols for lightline#ycm fallback to symbols defined
" for lightline#ale, if there aren't any, fallback to default.
function! s:get(key, default)
  return get(g:, 'lightline#ycm#' . a:key, get(g:, 'lightline#ale#' . a:key, a:default))
endfunction

let s:indicator_warnings = s:get('indicator_warnings', 'W: ')
let s:indicator_errors = s:get('indicator_errors', 'E: ')
let s:indicator_ok = s:get('indicator_ok', 'OK')
let s:indicator_checking = s:get('indicator_checking', 'Linting...')

let s:error_count = 0
let s:warning_count = 0

""""""""""""""""""""""
" Lightline components

function! lightline#ycm#warnings() abort
  return s:warning_count == 0 ? '' : printf(s:indicator_warnings . ' %d', s:warning_count)
endfunction

function! lightline#ycm#errors() abort
  return s:error_count == 0 ? '' : printf(s:indicator_errors . ' %d', s:error_count)
endfunction

function! lightline#ycm#ok() abort
  return s:error_count + s:warning_count == 0 ? s:indicator_ok : ''
endfunction

" Currently not supported by YCM, provided for keeping compatibility with
" lightline-ale API.
function! lightline#ycm#checking() abort
  return ''
endfunction

" Calls update if number of errors warnings are changed.
function! lightline#ycm#update() abort
  let l:error_count = youcompleteme#GetErrorCount()
  let l:warning_count = youcompleteme#GetWarningCount()
  if l:error_count != s:error_count || l:warning_count != s:warning_count
    let s:error_count = l:error_count
    let s:warning_count = l:warning_count
    call lightline#update()
  endif
endfunction
