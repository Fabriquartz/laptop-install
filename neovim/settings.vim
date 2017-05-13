" ==============================================================================
" 3.0 Settings {{{
" ==============================================================================

" ------------------------------------------------------------------------------
"  3.1 Native settings {{{
" -----------------------------------------------------------------------------

set autoindent                         " Copy indent from current line
set autoread                           " Read open files again when changed outside Vim
set autowrite                          " Write a modified buffer on each :next , ...
set backspace=indent,eol,start         " Backspacing over everything in insert mode
set history=200                        " Keep 200 lines of command line history
set hlsearch                           " Highlight the last used search pattern
set incsearch                          " Do incremental searching
set mouse=a                            " Enable mouse support
set nobackup                           " Don't constantly write backup files
set noswapfile                         " Ain't nobody got time for swap files
set noerrorbells                       " Don't beep
set nowrap                             " Do not wrap lines
set nowritebackup
set number                             " Show line numbers
set numberwidth=5                      " Make line number gutter at least 5 chars wide
set popt=left:8pc,right:3pc            " Print options
set ruler                              " show the cursor position all the time
set shiftwidth=2                       " Number of spaces to use for each step of indent
set showcmd                            " Display incomplete commands in the bottom line of the screen
set ignorecase                         " Ignore case when searching....
set smartcase                          " ...unless uppercase letter are used
set tabstop=2                          " Number of spaces that a <Tab> counts for
set expandtab                          " Make vim use spaces and not tabs
set undolevels=1000                    " Never can be too careful when it comes to undoing
set hidden                             " Don't unload the buffer when we switch between them. Saves undo history
set visualbell                         " Visual bell instead of beeping
set shell=bash                         " Required to let zsh know how to run things on command line
set ttimeoutlen=50                     " Fix delay when escaping from insert with Esc
set clipboard+=unnamed                 " Allow to use system clipboard
set scrolloff=3                        " Start scrolling the window 3 rows before the end
set sidescrolloff=3                    " Start scrolling the window 3 columns before the end
set colorcolumn=80                     " Mark the 81st column
set laststatus=2                       " Make the second to last line of vim our status line
set noshowmode                         " disable showmode in favor of airline
set splitbelow                         " Vertical splits open under the current
set splitright                         " Horizontal splits open next to the current
set modeline                           " Respect modelines
set modelines=4
set diffopt+=vertical
set title                              " Show the PWD and current file in terminal title
"}}}

" ------------------------------------------------------------------------------
"  3.2 persistent undo settings {{{
" ------------------------------------------------------------------------------
if has('persistent_undo')
  set undofile
  set undodir=~/.local/share/nvim/tmp/undo//
endif
"}}}

" ------------------------------------------------------------------------------
" 3.3 White characters settings {{{
" ------------------------------------------------------------------------------
set list                                    " Show listchars by default
set listchars=tab:»·,trail:·,nbsp:·
set showbreak=↪\
"}}}

" ------------------------------------------------------------------------------
" 3.4 Neovim specific settings {{{
" ------------------------------------------------------------------------------
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1                   " Set an environment variable to use the t_SI/t_EI hack
  let g:loaded_python_provider=1                        " Disable python 2 interface
  let g:python_host_skip_check=1                        " Skip python 2 host check
  let g:python3_host_prog='/usr/local/bin/python3'      " Set python 3 host program
  set inccommand=nosplit                                " Live preview of substitutes and other similar commands
endif
"}}}

" ------------------------------------------------------------------------------
" 3.5 completion settings {{{
" ------------------------------------------------------------------------------
set completeopt-=preview           " Don't show preview scratch buffers
" ignore the following:
set wildignore=*.swp,*.bak,*.pyc,*.class,tmp/**,dist/**,node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
"}}}

" ------------------------------------------------------------------------------
" 3.6 Folding settings {{{
" ------------------------------------------------------------------------------
set foldmethod=marker              " Markers are used to specify folds.
set foldlevel=2                    " Start folding automatically from level 2
set fillchars="fold: "             " Characters to fill the statuslines and vertical separators
"}}}

"}}}

" ==============================================================================
" 4.0 Plugin settings {{{
" ==============================================================================

" ------------------------------------------------------------------------------
"  4.1 ctrl-p {{{
" ------------------------------------------------------------------------------

let g:ctrlp_custom_ignore = '\v[\/](transpiled)|dist|tmp|node_modules|(\.(swp|git|bak|pyc|DS_Store))$'
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"}}}

" ------------------------------------------------------------------------------
"  4.2 Airline  {{{
" ------------------------------------------------------------------------------

let g:airline_section_x = ''
let g:airline_section_y = "%p%% ☰ %l:%c"
let g:airline_section_z = '%{strftime("%H:%M")}'
"}}}

" ------------------------------------------------------------------------------
"  4.3 Neomake  {{{
" ------------------------------------------------------------------------------

" checks
let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_sh_enabled_makers = ['shellcheck']
let g:neomake_verbose=0

" gutter signs
let g:neomake_warning_sign = {
      \ 'text': '❯',
      \ 'texthl': 'WarningMsg'
      \ }
let g:neomake_error_sign = {
      \ 'text': '❯',
      \ 'texthl': 'ErrorMsg',
      \ }

"}}}

" ------------------------------------------------------------------------------
"  4.4 NerdTree  {{{
" ------------------------------------------------------------------------------

let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeRespectWildIgnore=1
"}}}

" -----------------------------------------------------
" 4.5 Ultisnips settings {{{
" -----------------------------------------------------
let g:UltiSnipsUsePythonVersion=3
"}}}

" -----------------------------------------------------
" 4.6 Deoplete autocomplete settings {{{
" -----------------------------------------------------

let g:deoplete#enable_at_startup=1
let g:deoplete#enable_refresh_always=0
let g:deoplete#file#enable_buffer_path=1

let g:deoplete#sources={}
let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips']
let g:deoplete#sources.ruby = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.vim  = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.js   = ['buffer', 'file', 'ultisnips', 'ternjs']
let g:deoplete#sources.css  = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.scss = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.html = ['buffer', 'member', 'file', 'omni', 'ultisnips']
"}}}

" -----------------------------------------------------
" 4.7 Deoplete-tern settings {{{
" -----------------------------------------------------
let g:tern_request_timeout=1
let g:tern_show_signature_in_pum=1
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
"}}}

" -----------------------------------------------------
" 4.7 Deoplete-tern settings {{{
" -----------------------------------------------------
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
"}}}

"}}}
