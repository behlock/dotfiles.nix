"*****************************************************************************
"" GLOBAL SETTINGS
"*****************************************************************************

let g:mapleader = " "                   " Set leader key to space

set nocompatible
syntax enable                           " Enables syntax highlighing
filetype plugin indent on               " Turns on 'detection', 'plugin' and 'indent' at once

set hidden                              " Required to keep multiple buffers open
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" Treat dash separated words as a word text object
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set tabstop=4 softtabstop=4             " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set shiftround                          " >> indents to next multiple of 'shiftwidth'
set smarttab                            " Makes tabbing smarter (will realize you have 2 vs 4)
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set display=lastline                    " Show as much as possible of the last line
set number                              " Line numbers
set relativenumber                      " Relative line numbers
set cursorline                          " Enable highlighting of the current line
set showtabline=4                       " Always show tabs
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=100                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set ignorecase                          " Ignore case when searching through file
set backspace=indent,eol,start          " To make backspace work normally
set colorcolumn=80                      " Grey column
set completeopt=menuone,noinsert,noselect " No autoselect from autocomplete
set noerrorbells                        " No bell sound
set nu                                  " Activate line numbering
set smartcase                           " Search with both cases
set undodir=~/.config/nvim/undodir      " Set undodir directory
set undofile                            " Set undofile
set incsearch                           " Search as characters are entered
set hlsearch                            " Highlight matches
set modifiable                          " Make buffer modifiable for NERDTree
set spell spelllang=en_gb               " Spellcheck language
set showmode                            " Show current mode in command-line
set showcmd                             " Show command in bottom bar
set wildmenu                            " Visual autocomplete for command menu
set ttyfast                             " Faster redrawing
set lazyredraw                          " Redraw only when we need to
set showmatch                           " Highlight matching bracket
set shortmess+=c                        " Don't give ins-completion-menu messages
set signcolumn=yes                      " Always show signcolumns
set wrapscan                            " Searches wrap around end-of-file
set report      =0                      " Always report changed lines
set synmaxcol   =200                    " Only highlight the first 200 columns

"*****************************************************************************
"" PLUGINS
"*****************************************************************************

call plug#begin('~/.vim/plugged')

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'arzg/vim-colors-xcode'
Plug 'kvrohit/rasmus.nvim'

" LSP/Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'godlygeek/tabular'
Plug 'nvim-lua/plenary.nvim'
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Trees
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'kyazdani42/nvim-web-devicons'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Comments
Plug 'tpope/vim-commentary'

" Brackets
Plug 'frazrepo/vim-rainbow'
Plug 'Raimondi/delimitMate'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

"*****************************************************************************
"" THEME
"*****************************************************************************

" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox

" colorscheme xcodedark
" colorscheme xcodedarkhc
"

"*****************************************************************************
"" MAPPINGS
"*****************************************************************************

" Source vim config
nnoremap <leader>sv :source $MYVIMRC<CR>

" Easier way to escape
inoremap jk <Esc>
inoremap kj <Esc>

" Activate rainbow brackets
let g:rainbow_active = 1

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Toggle trees
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>u :UndotreeShow<CR>
" Find current buffer in Tree
map <leader>r :NERDTreeFind<cr>

"" NERDTree configuration
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode=2
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

" TAB in general mode will move to next buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Save buffer
nnoremap <leader>s :w<CR>
" Unload current bugger
nnoremap <leader>w :bd<CR>
" Close all buffers except current one
nnoremap <leader>wk :%bd\|e#<CR>
" Save all buffers and quit
nnoremap <leader>q :wqa<CR>

" Use option + jk to move lines down/up
nnoremap ∆  :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Resize windows
nnoremap <leader><Down> :resize -10<CR>
nnoremap <leader><Left> :vertical resize +40<CR>
nnoremap <leader><Right> :vertical resize -40<CR>
nnoremap <leader><Up> :resize +10<CR>

" Align blocks and keep them selected
vnoremap < <gv
vnoremap > >gv

" Turn off search highlight
nnoremap <leader>h :nohlsearch<CR>

" Insert blank line below/above current in normal mode
map <leader><Enter> o<ESC>
map <leader><S-Enter> O<ESC>

" Remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

" Make Y behave like the other capital letters
nnoremap Y y$

" Keep stuff centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Git hunk
nnoremap <leader>u :GitGutterUndoHunk <CR>

"*****************************************************************************
"" LSP
"*****************************************************************************

" let g:ycm_semantic_triggers = {
"      \ 'elm' : ['.'],
"      \}

let g:rustfmt_autosave = 1
let g:black_virtualenv = '~/.local/pipx/venvs/black'

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'clangd', 'cssls', 'dockerls',
                  'eslint', 'gopls', 'graphql', 'hls', 'html',
                  'java_language_server', 'jsonls', 'jsonnet_ls', 'pylsp',
                  'pyright', 'rnix', 'rust_analyzer', 'solidity_ls', 'sqlls',
                  'terraformls', 'tsserver', 'vimls', 'yamlls'
                }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

--Enable (broadcasting) snippet capability for completion for css/html/json
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
require'lspconfig'.html.setup {
  capabilities = capabilities,
}
require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}

-- TELESCOPE
local telescope = require('telescope')
local telescopeConfig = require('telescope.config')
telescope.load_extension('fzf')
telescope.load_extension "file_browser"

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      }
  }
}

-- https://github.com/nvim-telescope/telescope.nvim#file-pickers
local builtin = require('telescope.builtin')
-- Lists files in your current working directory
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
-- Search for a string in your current working directory and get results live as you type, respects .gitignore
vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
-- Searches for the string under your cursor in your current working directory
vim.keymap.set('n', '<leader>ft', builtin.grep_string, {})
-- Lists open buffers in current neovim instance
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
-- Open File Browser
vim.keymap.set('n', '<leader>fb', ":Telescope file_browser <CR>", { noremap = true })

-- GIT SIGNS
require('gitsigns').setup()

-- THEME
vim.g.rasmus_italic_comments = true
vim.g.rasmus_bold_functions = true
vim.cmd [[colorscheme rasmus]]

EOF

"*****************************************************************************
"" FUZZY FINDER
"*****************************************************************************

" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" " See git status
" map <leader>g :GFiles?<CR>
" " See open buffers
" " map <leader>b :Buffers<CR>
" " Search for word under cursor with fzf
" nnoremap <leader>rg :Rg <C-R>=expand("<cword>")<CR><CR>

" let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
" let $FZF_DEFAULT_COMMAND='rg --files --hidden -g'

" " Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" " Ripgrep advanced
"  function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" " Git grep
" command! -bang -nargs=* GGrep
"   \ call fzf#vim#grep(
"   \   'git grep --line-number '.shellescape(<q-args>), 0,
"   \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)}
