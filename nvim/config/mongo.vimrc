" https://stackoverflow.com/questions/4837673/how-to-execute-mongo-commands-through-shell-scripts
"mongo "mongodb://ambyint:crosswalksputterruff@amby-qa-10.ambyint.0711.mongodbdns.com:27000,amby-qa-11.ambyint.0711.mongodbdns.com:27000,amby-qa-14.ambyint.0711.mongodbdns.com:27000/wellexpert2?replicaSet=amby-qa" --eval 'db.getCollection(\'wellEvents\').find({
"  "type": {
"    "$in": [
"      "driveData",
"    ]
"  }
"})'

function! ExecuteMongoQuery ()
  let save_pos = getpos(".")

  call search('^$', 'bW')
  let start_line = line(".")
  call search('^$', '')
  let end_line = line(".")
  let query_lines = getline(start_line, end_line)
  let query = string(join(query_lines, ""))
  " let query = substitute(query, "'", '"', "g")

  let connection = getline(1)
  let command = "mongo '" . connection . "' --quiet --eval " . query
  let results = system(command)

  " execute "Dispatch " . command
  " echom "vsp term://" . command
  " execute "vsp term://" . command . "<CR>"
  " split testing
  " call termopen(command)
  " startinsert

  split testing
  call append(1, results)


  " echom command
  " Start command

  call setpos('.', save_pos)
endfunction

augroup mongo
  autocmd!
  autocmd BufEnter   *.mongo nnoremap <buffer> <enter> :call ExecuteMongoQuery()<CR>
augroup END
