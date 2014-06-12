execute pathogen#infect()

set nocp
set nu
set bs=2
set laststatus=2 
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set modeline

syntax enable
set background=dark
colorscheme solarized
let g:airline_theme = 'solarized'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

cmap w!! w !sudo tee > /dev/null %
map ,t :NERDTreeToggle<CR>
map ,l :!love ./<CR>
map ,lb :!busted ./spec<CR>
