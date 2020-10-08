" -----------------------------------------------------------------------------------------
" File Marks
" -----------------------------------------------------------------------------------------
" Automatically bookmark last files accessed by directory
augroup globalfilemarks
  autocmd!
  autocmd InsertEnter *.{js,jsx,coffee} normal! mJ
  autocmd InsertEnter *.{ts,tsx} normal! mT
  autocmd InsertEnter *.{py} normal! mP
  autocmd InsertEnter *.{go} normal! mG
  " autocmd BufWinLeave */dev/* normal! mQ
  autocmd InsertEnter */dev/* normal! mI
  autocmd TextChanged */dev/* normal! mO
  autocmd TextChangedI */dev/* normal! mO
  autocmd TextChanged,InsertEnter,BufEnter *.vimrc normal! mV
augroup END
" }

