" indentation styles
function IndentDefault()
  set tabstop=2
  set shiftwidth=2
  set smarttab
  set expandtab
endfunction

function IndentWide()
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
endfunction

function IndentLinux()
  set noexpandtab
  set tabstop=8
  set shiftwidth=8
  set softtabstop=8
endfunction

" Highlight trailing whitespaces
function ToggleTrailing()
  if !exists('b:toggle_trailing')
    let b:toggle_trailing = 1
  endif
  if b:toggle_trailing == 1
    highlight TrailingWhitespace ctermbg=red guibg=red
    match TrailingWhitespace /\s\+$/
    let b:toggle_trailing = 0
  else
    match none
    let b:toggle_trailing = 1
  endif
endfunction

function! StripTrailingWhitespaces()
  " Save the current cursor position
  let l:save = winsaveview()

  " Remove trailing whitespaces
  %s/\s\+$//e

  " Restore the cursor position
  call winrestview(l:save)

  " Optional: remove highlighting after the search
  nohlsearch
endfunction
