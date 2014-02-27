execute pathogen#infect()

set nocp
set nu
set bs=2
set laststatus=2 

syntax enable
set background=dark
colorscheme solarized
let g:airline_theme = 'solarized'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

cmap w!! w !sudo tee > /dev/null %

