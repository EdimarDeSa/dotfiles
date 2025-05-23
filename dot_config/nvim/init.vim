set nocompatible
set exrc
filetype off

call plug#begin('~/.config/nvim/plugged')

" Linters and fixers
"Plug 'dense-analysis/ale' " Linter
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server
Plug 'sheerun/vim-polyglot' " Syntax highlight
Plug 'jiangmiao/auto-pairs' " Auto pairs
Plug 'vim-scripts/indentpython.vim' " Python indent
Plug 'tmhedberg/SimpylFold' " Python folding
Plug 'rust-lang/rust.vim' " Rust support
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround' " Surround
Plug 'tpope/vim-commentary' " Comment

" Navigation and search
Plug 'nvim-neo-tree/neo-tree.nvim' " File explorer tree
Plug 'nvim-lua/plenary.nvim' " Dependência do Neotree
Plug 'nvim-tree/nvim-web-devicons' " Dependência do Neotree
Plug 'MunifTanjim/nui.nvim' " Dependência do Neotree
Plug 'kien/ctrlp.vim' " Fuzzy file finder

" Git tools
Plug 'airblade/vim-gitgutter' " Git diff
Plug 'tpope/vim-fugitive' " Git support

" Docker tools
Plug 'kkvh/vim-docker-tools'
Plug 'ekalinin/Dockerfile.vim' " Dockerfile syntax

" Themes and UI
Plug 'vim-airline/vim-airline'
Plug 'willothy/nvim-cokeline' " Status line
Plug 'mhinz/vim-startify' " Vim greeting screen
Plug 'doums/darcula' " Theme
Plug 'luochen1990/rainbow' " Rainbow parentheses
Plug 'vim-airline/vim-airline-themes'

" Snippets and autocomplete
Plug 'github/copilot.vim' " Copilot

call plug#end()

" Auto-install plugins on first run
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) |
  \   PlugInstall --sync |
  \   source $MYVIMRC |
  \ endif

" -------------------------------------------------------------------------------------------------
"  General configuration
source ~/.config/nvim/base_settings.vim

if has('gui_running')
  set ts=2 sw=2 et
  set guioptions=egmrt
endif

" Always show the signcolumn, so our buffers doesn't shift on errors
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd FileType nerdtree setlocal signcolumn=no

" -------------------------------------------------------------------------------------------------
" Remaps

source ~/.config/nvim/remaps.vim

" -------------------------------------------------------------------------------------------------
" Theme configuration

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum]"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum]"
  set termguicolors
endif

colorscheme darcula

" -------------------------------------------------------------------------------------------------
" Neotree configuration
nmap <C-a> :Neotree toggle<CR>
autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() > 0 || exists("s:std_in") | execute 'Neotree toggle dir=%:p:h' |
                  \wincmd p | endif

source ~/.config/nvim/setup_neotree.lua

" -------------------------------------------------------------------------------------------------
"  CokeLine configuration
source ~/.config/nvim/setup_cokeline.lua

" -------------------------------------------------------------------------------------------------
"  Airline configuration
let g:airline_theme='google_dark'
let g:airline_powerline_fonts = 1

let g:airline_detect_modified = 1
let g:airline_detect_spell = 1
let g:airline_detect_spelllang = 1

let g:airline_filetype_overrides = {
      \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
      \ 'help':  [ 'Help', '%f' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ }

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#show_line_numbers = 1

" -------------------------------------------------------------------------------------------------
" CtrlP
let g:ctrlp_max_height = 10
let g:ctrlp_custom_ignore = '\v[\/](vendor\/ruby|node_modules|.log|.git|.hg|.svn|.lock|venv)$'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

" -------------------------------------------------------------------------------------------------
"g Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
      \'*': ['remove_trailing_lines', 'trim_whitespace', 'add_blank_lines_for_python_control_statements'],
      \'python': ['black', 'isort', 'autoimport'],
      \'rust': ['rustfmt'],
      \}

let g:ale_linters = {
      \'python': ['flake8', 'bandit', 'pyright'],
      \'rust': ['rust-analyzer'],
      \}

let g:ale_linters_ignore = {
      \   'python': ['ruff'],
      \}

let g:ale_fix_on_save = 1

let g:ale_use_neovim_diagnostics_api = 1
let g:ale_lint_on_text_changed = 'never' " Lint only when saving
let g:ale_lint_on_insert_leave = 0 " Lint only when saving
let g:ale_lint_on_enter = 0 " Lint only when saving
let g:ale_python_auto_poetry = 1
let g:ale_completion_enabled = 1
let g:ale_set_highlights = 0
let g:ale_set_signs = 1

nnoremap <silent> <Plug>(<CR>) :ALEFindReferences -relative<Return>

" Python ALE options
let g:ale_python_flake8_options =
      \'--max-line-length=80 --extend-ignore=E203 --python=$(poetry env info -p)/bin/python'
let g:ale_python_black_options = '--line-length 80'
let g:ale_python_isort_options = '--profile black -l 80'

" -------------------------------------------------------------------------------------------------
" Rainbow
let g:rainbow_active = 1

" -------------------------------------------------------------------------------------------------
" Coc
source ~/.config/nvim/setup_coc.vim

" -------------------------------------------------------------------------------------------------
"  SimpylFold
let g:simpylfold_docstring_preview = 1
let g:simpylfold_fold_python_files = 1

" -------------------------------------------------------------------------------------------------
" Rust
autocmd FileType rust silent! nnoremap <silent> <Leader>f :RustFmt<CR>

" -------------------------------------------------------------------------------------------------
" Python
au BufNewFile, BufRead *.py
      \	set tabstop=4
      \	set softtabstop=4
      \	set shiftwidth=4
      \	set textwidth=79
      \	set fileformat=unix
let python_highlight_all=1
let g:python3_host_prog = '/usr/bin/python3'

au BufRead, BufNewFile *.py, *.pyw, *.c, *.h match BadWhitespace/\s\+$/

" -------------------------------------------------------------------------------------------------
"  Copilot
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" -------------------------------------------------------------------------------------------------
" Hilight de palavra em cursor

function! HighlightWordUnderCursor()
  if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
    exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
  else
    call clearmatches()
  endif
endfunction

" Mapeamento de teclas para chamar a função
autocmd CursorHold * call HighlightWordUnderCursor()
