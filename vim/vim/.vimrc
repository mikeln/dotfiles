" MLN setup for vim
" created 2/20/2015
"
" run pathogen to handle all bundle plubins
call pathogen#infect()
call pathogen#helptags()
"
" enable completion on certain files
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
"
" solorize color schemeing
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
