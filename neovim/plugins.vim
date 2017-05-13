" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" 1.1 Plugin list {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call plug#begin('~/.local/share/nvim/plugged')
" ------------------------------------------------------------------------------
" Interface {{{
" ------------------------------------------------------------------------------

" Airline (status line)
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" file browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabToggle' }
" enhanced nerdtree
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabToggle' }
" buffer tabs
Plug 'ap/vim-buftabline'
"}}}

" ------------------------------------------------------------------------------
" Colorschemes {{{
" ------------------------------------------------------------------------------

" Github
Plug 'croaky/vim-colors-github'
" Kalisi
Plug 'freeo/vim-kalisi'
" Gruvbox
Plug 'morhetz/gruvbox'
" big pack with themes
Plug 'flazz/vim-colorschemes'
"}}}

" ------------------------------------------------------------------------------
" Javascript {{{
" ------------------------------------------------------------------------------

" Handlebars support
Plug 'mustache/vim-mustache-handlebars'
" Ember support
Plug 'AndrewRadev/ember_tools.vim',
" file locations for ember support
Plug 'tpope/vim-projectionist'
" Modern JS support (indent, syntax, etc)
Plug 'pangloss/vim-javascript'
" Autocomplete (npm install -g tern)
Plug 'carlitux/deoplete-ternjs'
" Tern for vim
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
" JSON syntax
Plug 'sheerun/vim-json'
"}}}

" ------------------------------------------------------------------------------
" Ruby/Rails {{{
" ------------------------------------------------------------------------------

" Ruby support
Plug 'vim-ruby/vim-ruby'
" Rails support
Plug 'tpope/vim-rails'
" Bundler support
Plug 'tpope/vim-bundler'
" Rspec support
Plug 'thoughtbot/vim-rspec'
"}}}

" ------------------------------------------------------------------------------
" Other languages {{{
" ------------------------------------------------------------------------------

" Elixir syntax
Plug 'elixir-lang/vim-elixir'
" Rust syntax
Plug 'rust-lang/rust.vim'
" Git syntax
Plug 'tpope/vim-git'
" Markdown syntax
Plug 'tpope/vim-markdown'
" Dockerfile
Plug 'honza/dockerfile.vim'
"}}}

" ------------------------------------------------------------------------------
" Quality of Life {{{
" ------------------------------------------------------------------------------

" fuzzy open file with ctrl-p
Plug 'ctrlpvim/ctrlp.vim'
" Easy alignment
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }
" automatically create directory when saving a new file
Plug 'pbrisbin/vim-mkdir'
" support repeat (.) for plugin commands
Plug 'tpope/vim-repeat'
" change surrounding tags
Plug 'tpope/vim-surround'
" a bunch of shortcuts
Plug 'tpope/vim-unimpaired'
" universal comment plugin
Plug 'vim-scripts/tComment'
" async commands
Plug 'tpope/vim-dispatch'
"}}}

" ------------------------------------------------------------------------------
" External tools integration {{{
" ------------------------------------------------------------------------------

" Git changes showed on line numbers
Plug 'airblade/vim-gitgutter'
" Git integration
Plug 'tpope/vim-fugitive'
"}}}

" ------------------------------------------------------------------------------
" language agnostics {{{
" ------------------------------------------------------------------------------

" Async maker and linter
Plug 'benekastah/neomake'
" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Snippet support (C-j)
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'
" Tag bar
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
"}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" 1.2 Local plugins {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if ! empty(glob("~/.config/nvim/local_plugins.vim"))
  source ~/.config/nvim/local_plugins.vim
endif
"}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" 1.3 End of plugin declaration
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call plug#end()
"}}}
