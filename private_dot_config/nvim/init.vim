"
"
" ______ _       _ _ _       _   _                 _             _____              __ _       
" | ___ (_)     | (_| )     | \ | |               (_)           /  __ \            / _(_)      
" | |_/ /_  __ _| |_|/ ___  |  \| | ___  _____   ___ _ __ ___   | /  \/ ___  _ __ | |_ _  __ _ 
" | ___ \ |/ _` | | | / __| | . ` |/ _ \/ _ \ \ / / | '_ ` _ \  | |    / _ \| '_ \|  _| |/ _` |
" | |_/ / | (_| | | | \__ \ | |\  |  __/ (_) \ V /| | | | | | | | \__/\ (_) | | | | | | | (_| |
" \____/|_|\__, |_|_| |___/ \_| \_/\___|\___/ \_/ |_|_| |_| |_|  \____/\___/|_| |_|_| |_|\__, |
"           __/ |                                                                         __/ |
"          |___/                                                                         |___/ 

" ------------------------------------------------------------------------------------------------
" KEY MAPS
" ------------------------------------------------------------------------------------------------

" For any plugins that use this, make their keymappings use comma
let mapleader = ","

" Useful macros
nmap \e :NERDTreeToggle<CR>
nmap \g :Gstatus<CR>
nmap \q :nohlsearch<CR>

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
" line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
" it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
" to mean the next line on the screen
nmap j gj
nmap k gk

" You don't know what you're missing if you don't use this.
nmap <C-e> :e#<CR>

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Super fast window movement shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"set pastetoggle=<f4>
nmap <F5> :set number! number?<CR>
nnoremap <F6> :GundoToggle<CR>

" indentation
nmap <F7> mzgg=G`z

" Sorting
vnoremap <Leader>s :sort<CR>

" ------------------------------------------------------------------------------------------------
" OPTIONS
" ------------------------------------------------------------------------------------------------

set autoindent                  " Carry over indenting from previous line
set autoread                    " Don't bother me hen a file changes
set autowrite                   " Write on :next/:prev/^Z
set backspace=indent,eol,start  " Allow backspace beyond insertion point
set cindent                     " Automatic program indenting
set cinkeys-=0#                 " Comments don't fiddle with indenting
set cino=                       " See :h cinoptions-values
set colorcolumn=+1              " Show vertical line one char after textwidth
set commentstring=\ \ #%s       " When folds are created, add them to this
set copyindent                  " Make autoindent use the same chars as prev line
set directory-=.                " Don't store temp files in cwd
set encoding=utf8               " UTF-8 by default
set expandtab                   " No tabs
set fileencoding=utf8           " UTF-8 by default
set fileformats=unix,dos,mac    " Prefer Unix
set fillchars=stl:\ ,stlnc:\ ,fold:-,diff:┄
" Unicode chars for diffs/folds, and rely on
" Colors for window borders
silent! set foldmethod=marker   " Use braces by default
set formatoptions=cqn1          " c - autowrap comments
" q - gq formats comments
" n - autowrap lists
" 1 - break _before_ single-letter words
" 2 - use indenting from 2nd line of param
set hidden                      " Don't prompt to save hidden windows until exit
set history=200                 " How many lines of history to sav
set hlsearch                    " Hilight searching
set ignorecase                  " Case insensitive
set incsearch                   " Search as you type
set infercase                   " Completion recognizes capitalization
set laststatus=2                " Always show the status bar
set linebreak                   " Break long lines by word, not char
set list                        " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
" Unicode characters for various things
set matchtime=2                 " Tenths of second to highlight matching paren
set modelines=5                 " How many lines of head & tail to look for ml's
"silent! set mouse=nvc           " Use the mouse, but not in insert mode
set nobackup                    " No backups left after done editing
set notitle                     " Don't set the title of the Vim window
set number                      " show absolute line number of the current line
set ruler                       " Show row/col and percentage
set scroll=4                    " Number of lines to scroll with ^U/^D
set scrolloff=10                " Keep cursor away from this many chars top/bot
set secure                      " disable unsafe commands in local .vimrc files
set sessionoptions-=options     " Don't save runtimepath in Vim session
" (see tpope/vim-pathogen docs)
set shiftround                  " Shift to certain columns, not just n spaces
set shiftwidth=2                " Number of spaces to shift for autoindent or >,<
set shortmess+=A                " Don't bother me when a swapfile exists
set showbreak=                  " Show for lines that have been wrapped, like Emacs
set showmatch                   " Highlight matching braces/parens/etc.
set showcmd                     " the bottom line in your editor will show you
" information about the current command going on
set sidescrolloff=3             " Keep cursor away from this many chars left/right
set smartcase                   " Lets you search for ALL CAPS
set softtabstop=2               " Spaces 'feel' like tabs
set tabstop=2                   " The One True Tab
" set termencoding=utf8           " UTF-8 by default
set visualbell t_vb=            " No flashing or beeping at all
set textwidth=100               " 100 is the new 80
set wildmenu                    " Show possible completions on command line
set wildmode=list:longest,full  " List all options and complete
set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules
" Ignore certain files in tab-completion

" Essential for filetype plugins.
filetype plugin indent on

" ------------------------------------------------------------------------------------------------
" CUSTOM COMMANDS AND FUNCTIONS
" ------------------------------------------------------------------------------------------------

" I always hit ":W" instead of ":w" because I linger on the shift key...
command! Q q
command! W w

" Trim spaces at EOL and retab. I run `:CLEAN` a lot to clean up files.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" ------------------------------------------------------------------------------------------------
" PLUGIN SETTINGS
" ------------------------------------------------------------------------------------------------

" Use Pathogen for plugin management. See update.sh in this directory.
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<CR>

" Tell ack.vim to use ag (the Silver Searcher) instead
let g:ackprg = 'ag --vimgrep'

" Use incsearch.vim to highlight as I search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Highlight YAML frontmatter in Markdown files
let g:vim_markdown_frontmatter = 1

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Copilot
" let g:copilot_filetypes = {'yaml': v:true, 'gitcommit': v:true}

" ------------------------------------------------------------------------------------------------
" COLORS
" ------------------------------------------------------------------------------------------------
syntax on

" Some plugin seems to search for something at startup, so this fixes that.
silent! nohlsearch

" Write with sudo permissions
ca w!! w !sudo tee >/dev/null "%"<CR>

" vim:set tw=100:
