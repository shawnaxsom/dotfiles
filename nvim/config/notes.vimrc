nnoremap gsa :topleft split ~/Dropbox/notes/<CR>
nnoremap gsc :topleft split ~/Dropbox/cheatsheets/<CR>
nnoremap gsd :topleft split ~/Dropbox/notes/data.scratch.md<CR>
nnoremap gsh :topleft split ~/Dropbox/notes/habits.scratch.md<CR>
nnoremap gsl :topleft split ~/Dropbox/notes/links.scratch.md<CR>
nnoremap gsm :topleft split ~/Dropbox/notes/meetings.scratch.md<CR>
nnoremap gsp :topleft split ~/Dropbox/notes/personal.scratch.md<CR>
nnoremap gsr :topleft split ~/Dropbox/notes/queries.rest<CR>
nnoremap gss :topleft split ~/Dropbox/notes/scratch.scratch.md<CR>
nnoremap gst :topleft 8split ~/Dropbox/notes/task.scratch.md<CR>
nnoremap gsv :topleft split ~/Dropbox/notes/vim.scratch.md<CR>
nnoremap gsw :topleft split ~/Dropbox/notes/work.scratch.md<CR>

augroup markdown
  autocmd!
  autocmd BufLeave   *.md silent w
  autocmd BufEnter   *.md map <buffer> <leader>t :Toch<CR>
  " autocmd BufEnter   *.md setlocal winfixheight winfixwidth
augroup END
