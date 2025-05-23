" General settings {{{
set encoding=utf-8
set t_Co=256                      " more colors
set clipboard=unnamedplus         " use system clipboard
set nocompatible                  
syntax enable                     " enable syntax highlighting...
filetype plugin indent on         " depending on filetypes
runtime macros/matchit.vim        " with advanced matching capabilities
set pastetoggle=<F12>             " for pasting code into Vim
set timeout tm=1000 ttm=10        " fix slight delay after pressing Esc then O
set autoread                      " auto load files if vim detects change
set nobackup                      " disable backup files...
set noswapfile                    " and swap files
set shortmess+=I                  " disable intro message
set autowriteall                  " autosave

" Style
set termguicolors
set number                        " line numbers
set relativenumber                " and relative ones
set ruler                         " show the cursor position all the time
set nocursorline                  " disable cursor line
set showcmd                       " display incomplete commands
set novisualbell                  " no flashes
set scrolloff=3                   " provide some context when editing
set hidden                        " allow backgrounding buffers without writing them, and
                                  " remember marks/undo for backgrounded buffers
" Mouse
set mouse=a                       " mouse support
if !has('nvim')
  set ttymouse=xterm2             " fast
endif
set mousehide                     " hide it when we're writing

" Whitespace
set wrap                          " wrap long lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set softtabstop=2                 " when deleting, treat spaces as tabs
set expandtab                     " use spaces, not tabs
set list                          " show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent                    " keep indentation level when no indent is found

" Wild life
set wildmenu                      " wildmenu gives autocompletion to vim
set wildmode=list:longest,full    " autocompletion shouldn't jump to the first match
set wildignore+=*.scssc,*.sassc,*.csv,*.pyc,*.xls,*.rbi
set wildignore+=tmp/**,node_modules/**,bower_components/**

" List chars
set listchars=""                  " reset the listchars
" set listchars=tab:▸\ ,eol:¬       " a tab should display as "▸ ", end of lines as "¬"
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " the character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " the character to show in the first column when wrap is
                                  " off and the line continues beyond the left of the screen
set fillchars+=vert:\             " set vertical divider to empty space

" Searching
set hlsearch                      " highlight matches
nohlsearch                        " but don't highlight last search when reloading
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive
set smartcase                     " unless they contain at least one capital letter

" Windows
set splitright                    " create new horizontal split on the right
set splitbelow                    " create new vertical split below the current window

" Status line
set laststatus=2

" Gitgutter
highlight clear SignColumn
set signcolumn=yes
" }}}

" FileType settings {{{
if has("autocmd")
  " in Makefiles use real tabs, not tabs expanded to spaces
  augroup filetype_make
    au!
    au FileType make setl ts=8 sts=8 sw=8 noet
  augroup END

  " make sure all markdown files have the correct filetype set and setup wrapping
  augroup filetype_markdown
    au!
    au FileType markdown setl tw=75 | syntax sync fromstart
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
  augroup END

  " disable endwise for anonymous functions
  augroup filetype_elixir_endwise
    au!
    au BufNewFile,BufRead *.{ex,exs}
          \ let b:endwise_addition = '\=submatch(0)=="fn" ? "end)" : "end"'
  augroup END

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  augroup filetype_python
    au!
    au FileType python setl sts=4 ts=4 sw=4
  augroup END

  " follow Elm conventions
  augroup filetype_elm
    au!
    au FileType elm setl sts=4 ts=4 sw=4
  augroup END

  " delete Fugitive buffers when they become inactive
  augroup filetype_fugitive
    au!
    au BufReadPost fugitive://* set bufhidden=delete
  augroup END

  " fold automatically with triple {
  augroup filetype_vim
    au!
    au FileType vim,javascript,python,c setlocal foldmethod=marker nofoldenable
  augroup END

  " enable <CR> in command line window and quickfix
  augroup enable_cr
    au!
    au CmdwinEnter * nnoremap <buffer> <CR> <CR>
    au BufWinEnter quickfix nnoremap <buffer> <CR> <CR>
  augroup END

  " disable automatic comment insertion
  augroup auto_comments
    au!
    au FileType * setlocal formatoptions-=ro
  augroup END

  " disable numbers in terminal windows
  if has('nvim')
    augroup terminal_numbers
      au!
      au TermOpen * setlocal nonumber
    augroup END
  endif

  " run all formatters
  if !exists('g:vscode')
    augroup fmt
      au!
      au BufWritePre * Neoformat
    augroup END

    " remember last location in file, but not for commit messages,
    " or when the position is invalid or inside an event handler,
    " or when the mark is in the first line, that is the default
    " position when opening a file. See :help last-position-jump
    augroup last_position
      au!
      au BufReadPost *
        \ if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END
  endif
endif
" }}}

" Mappings {{{
nnoremap <SPACE> <Nop>
let mapleader=' '

" Autosave
inoremap <Esc> <Esc>:w<CR>

" Y u no consistent?
nnoremap Y y$

" open vimrc and reload it
nnoremap <Leader>vv :vsplit $HOME/.config/home-manager/vimrc<CR>
nnoremap <Leader>sv :source $HOME/.config/home-manager/vimrc<CR>

" open NERDTree
nnoremap <Leader>pp :NERDTreeToggle<CR>

" disable man page for word under cursor
nnoremap K <Nop>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" expand %% to current directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <Leader>e :e %%

" easy way to switch between latest files
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>vs :execute "vsplit " . bufname("#")<CR>
nnoremap <Leader>sp :execute "split " . bufname("#")<CR>

" find merge conflict markers
nnoremap <silent> <Leader>cf <Esc>/\v^[<=>]{7}( .*\|$)<CR>

" show colorcolumn
nnoremap <silent> <Leader>sc :set colorcolumn=80<CR>

" easy substitutions
nnoremap <Leader>r :%s///gc<Left><Left><Left>
nnoremap <Leader>R :%s:::gc<Left><Left><Left>

" remove whitespaces and windows EOL
command! KillWhitespace :normal :%s/\s\+$//e<CR><C-O><CR>
command! KillControlM :normal :%s/<C-V><C-M>//e<CR><C-O><CR>
nnoremap <Leader>kw :KillWhitespace<CR>
nnoremap <Leader>kcm :KillControlM<CR>

" easy global search
nnoremap <C-S> :Rg <C-R><C-W><CR>
vnoremap <C-S> y<Esc>:Rg <C-R>"<CR>

" Resize windows
nnoremap <Leader><Down> :resize -10<CR>
nnoremap <Leader><Left> :vertical resize +40<CR>
nnoremap <Leader><Right> :vertical resize -40<CR>
nnoremap <Leader><Up> :resize +10<CR>

" Plugins {{{
noremap <Leader>w :ALEDetail<CR>
nnoremap <Leader>x :ALENextWrap<CR>
nnoremap <Leader>dd :ALEGoToDefinition<CR>
nnoremap <Leader>dt :ALEGoToTypeDefinition<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :History<CR>
nnoremap <silent> <S-left> <Esc>:bp<CR>
nnoremap <silent> <S-right> <Esc>:bn<CR>
nnoremap <Leader>a <Esc>:Rg<space>
nnoremap <Leader>u :MundoToggle<CR>
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap <C-n> <plug>(YoinkPostPasteSwapBack)
nmap <C-p> <plug>(YoinkPostPasteSwapForward)

let g:UltiSnipsSnippetDirectories = ['~/.config/home-manager/snippets']
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
      \ 'nix': [],
      \ 'typescript': ['tsserver'],
      \ 'elm': ['make'] }
let g:fzf_layout = { 'down': '~30%' }
let g:goldenview__enable_default_mapping = 0
let g:lightline = { 'mode_fallback': { 'terminal': 'normal' } }
let g:loaded_python_provider = 1
let g:mundo_right = 1
let NERDTreeShowHidden=1
let g:neoformat_nix_nixfmt = {
  \ 'exe': 'nixfmt',
  \ 'args': ['--width', '80'],
  \ 'stdin': 1,
  \ }
let g:neoformat_enabled_json = []
let g:neoformat_enabled_nix = ['nixfmt']
let g:neoformat_enabled_yaml = []
let g:neoformat_only_msg_on_error = 1
let g:test#preserve_screen = 1
let g:test#strategy = "vimux"
let g:tmux_navigator_disable_when_zoomed = 1
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkSavePersistently = 1
let g:yoinkSwapClampAtEnds = 0

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
" }}}

" Clipboard integration in spin
if $SPIN == 1
    let g:clipboard = {
        \ 'name': 'pbcopy',
        \ 'copy': {'+': 'pbcopy', '*': 'pbcopy'},
        \ 'paste': {'+': 'pbpaste', '*': 'pbpaste'},
        \ 'cache_enabled': 1 }
end
