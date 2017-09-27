" -----------------------------------------------------------------------------------------
" File Marks
" -----------------------------------------------------------------------------------------
" Automatically bookmark last files accessed by directory
augroup globalfilemarks
  autocmd!
  autocmd BufEnter *.{js,jsx,coffee} normal! mJ
  autocmd BufWinLeave */src/* normal! mQ
  autocmd InsertEnter */src/* normal! mI
  autocmd TextChanged */src/* normal! mO
  autocmd TextChangedI */src/* normal! mO
augroup END
" }

