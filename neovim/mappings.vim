" ------------------------------------------------------------------------------
" 5.1 Setting leader {{{
" ------------------------------------------------------------------------------
let mapleader=","
"}}}

" ------------------------------------------------------------------------------
" 5.2 Disable some defaults {{{
" ------------------------------------------------------------------------------
inoremap <F1> <NOP>
nnoremap <F1> <NOP>
"}}}

" ------------------------------------------------------------------------------
" 5.3 Vim defaults overriding {{{
" ------------------------------------------------------------------------------

" Easier windows switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Create window splits easier.
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" switch between buffer tabs
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>
"}}}

" ------------------------------------------------------------------------------
"  5.4 Common tasks {{{
" ------------------------------------------------------------------------------

" Easier fold toggling
nnoremap ,z za
" Run test suites
map <Leader>rs :!rspec<cr>
map <Leader>te :!ember test<cr>
map <Leader>tx :!mix test<cr>
"}}}

" -----------------------------------------------------
" 5.5 NerdTree mapping {{{
" -----------------------------------------------------

map <Leader>d :NERDTreeTabsToggle<CR>
nmap <Leader>nt :NERDTreeTabsFind<CR>
"}}}

" -----------------------------------------------------
" 5.6 Deoplete autocomplete {{{
" -----------------------------------------------------
" Insert <TAB> or select next match
inoremap <silent> <expr> <Tab> functions#TabComplete()

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
"}}}

" -----------------------------------------------------
" 5.7 Ultisnips {{{
" -----------------------------------------------------
" Disable built-in cx-ck to be able to go backward
inoremap <C-x><C-k> <NOP>
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-s>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
"}}}

" -----------------------------------------------------
" 5.8 Vim-Plug {{{
" -----------------------------------------------------
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pU :PlugUpgrade<CR>
nnoremap <leader>pc :PlugClean<CR>
"}}}

" -----------------------------------------------------
" 5.9 F-key actions {{{
" -----------------------------------------------------

" NERDTree toggle
nnoremap <silent> <F1> :NERDTreeToggle<CR>
" Tagbar toggle
nnoremap <silent> <F2> :TagbarToggle<CR>
" Free
" nnoremap <silent> <F3>
" Free
" nnoremap <silent> <F4>
" reload current file
nnoremap <silent> <F5> :e <CR>
" Toggle search highlight
nnoremap <silent> <F6> :set nohlsearch!<CR> :set nohlsearch?<CR>
" Toggle white characters visibility
nnoremap <silent> <F7> :set list!<CR> :set list?<CR>
" New term buffer
nnoremap <silent> <F8> :terminal<CR>
" Free
" nnoremap <silent> <F9>
" Free
" nnoremap <silent> <F10>
" Free
" nnoremap <silent> <F11>
" Free
"}}}

