execute pathogen#infect()

" use matchit to match xml tags with %
" included in standard vim distribution
runtime macros/matchit.vim

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 0

set cursorline
set nowrap
set ignorecase
set smartcase

" allow us to switch buffers with unsaved changes
set hidden
set confirm

" global search, like with superstar
nnoremap gr :grep -ri <cword> *<CR>
nnoremap Gr :grep <cword> %:p:h/*<CR>
nnoremap gR :grep '\b<cword>\b' *<CR>
nnoremap GR :grep '\b<cword>\b' %:p:h/*<CR>

" automatically open the quickfix menu after make, grep, lvimgrep, etc.
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" avantas
autocmd BufRead,BufNewFile *.inc set filetype=xml
autocmd BufRead,BufNewFile *.item set filetype=xml
autocmd BufRead,BufNewFile *.dbml set filetype=xml
autocmd BufRead,BufNewFile *.nest set filetype=xml
autocmd BufRead,BufNewFile *.form set filetype=xml



" show the filename and truncated commit history for every dbml file in the
" given directory (somedir)
function! ShowHist(somedir)
"	execute "read !" . "find " . a:somedir . " -name '*dbml' -exec git log -1 --pretty='format:\\%<(-100) \{\} \\%<(-20) \\%ad \\%ae \\%B' \{\} \\;"
	"let doit = "read !" . "find " . a:somedir . " -name '*dbml' -exec echo \{\} \\;"
	let doit = "read !" . "find " . a:somedir . " -name '*dbml'"
	\ ." -exec bash -c 'grep -q DBIFADMINIP $0 \&\& printf DBIFADMINIP || printf \"\\%11s\" \" \" ' \{\} \\;"
	\ ." -exec bash -c 'grep -q DBNOTCAPPAGETOSS $0 \&\& printf DBNOTCAPPAGETOSS || printf \"\\%16s\" \" \" ' \{\} \\;"
	\ ." -exec bash -c 'grep -q _ADMIN_REQUIRED $0 \&\& printf XXXX_ADMIN_REQUIRED || printf \"\\%19s\" \" \" ' \{\} \\;"
	\ ." -exec bash -c 'grep -q \"DB\\(NOT\\)\\?CAP \" $0 \&\& printf \"DBNOT?CAP\" || printf \"\\%09s\" \" \" ' \{\} \\;"
	\ ." -exec bash -c 'git diff-index --quiet HEAD $0 \&\& printf \" \" || printf \"*\" ' \{\} \\;"
	\ ." -exec git --no-pager log -1 --pretty='format:\\%<(-100) \{\} \\%<(-20) \\%ai \\%ae \\%s \\%n' \{\} \\;"
	execute doit
endfunction

set statusline=%{expand('%:~:.')}         " Relative path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

set laststatus=2	" always show status line
