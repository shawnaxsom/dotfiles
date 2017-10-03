map gsh :topleft split ~/Dropbox/notes/habits.scratch.md<CR>
map gsl :topleft split ~/Dropbox/notes/links.scratch.md<CR>
map gsm :topleft split ~/Dropbox/notes/meetings.scratch.md<CR>
map gsp :topleft split ~/Dropbox/notes/personal.scratch.md<CR>
map gsr :topleft split ~/Dropbox/notes/queries.rest<CR>
map gss :topleft split ~/Dropbox/notes/<CR>
map gst :topleft 8split ~/Dropbox/notes/task.scratch.md<CR>
map gsv :topleft split ~/Dropbox/notes/vim.scratch.md<CR>
map gsw :topleft split ~/Dropbox/notes/work.scratch.md<CR>

augroup markdown
  autocmd!
  autocmd BufLeave   *.md silent w
  autocmd BufEnter   *.md map <buffer> <leader>t :Toch<CR>
  " autocmd BufEnter   *.md setlocal winfixheight winfixwidth
augroup END
