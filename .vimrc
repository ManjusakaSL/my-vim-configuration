set nocompatible
set backspace=indent,eol,start
set incsearch
set autoindent
set history=50
set ruler
set showmode
set hlsearch
set number
set tabstop=4
set shiftwidth=4
set nobackup
set background=dark
colorscheme solarized
if has('gui_running')
	set guioptions-=m 			" 隐藏菜单栏
	set guioptions-=T 			" 隐藏工具栏
	set guioptions-=L 			" 隐藏左侧滚动条
	set guioptions-=r 			" 隐藏右侧滚动条
	set guioptions-=b 			" 隐藏底部滚动条
	set showtabline=0 			" 隐藏Tab栏	
endif
let mapleader=","

" map
map          Q                  gq
map			 <F2>				:!pydoc 
map			 <F3>               :call InsertCode()<CR>
map          <F4>               :call Debug()<CR>
map  		 <F5> 				:call CompileRunGcc()<CR>
map 		 <silent> <F11> 	:call ToggleFullScreen()<CR>
map			 <C-p>				"+gP
nmap         \p                 i(<Esc>ea)<Esc> 
nmap         \c                 i{<Esc>ea}<Esc> 
nmap 		 <C-a>				ggVG
nmap 		 <leader>n 			<plug>NERDTreeTabsToggle<CR>    
nmap		 <leader>t			:TagbarToggle<CR>   
nmap         <leader>w          :resize 10<CR>
vmap		 <C-c>				"+y
vmap         <C-x>              "+x

" Pathogen load
call pathogen#infect()
call pathogen#helptags()
syntax on

" Tagbar
let g:tagbar_width = 25       
autocmd VimEnter * nested :call tagbar#autoopen(1) 
let g:tagbar_right = 1      

" NERDTree
let NERDTreeWinSize=22
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
let NERDTreeIgnore=['\.pyc$', '\~$'] 

" NERDTree-Tabs
let g:nerdtree_tabs_open_on_console_startup=1   

" powerlind
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Vundle
set nocompatible               " be iMproved
filetype off                   " required! /**  从这行开始，vimrc配置 **/
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here:  
"   
" original repos on github （Github网站上非vim-scripts仓库的插件，按下面格式填写）
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" Bundle 'Valloric/YouCompleteMe'
" Plugin 'nvie/vim-flake8'
" Bundle 'davidhalter/jedi'
" non github repos   (非上面两种情况的，按下面格式填写)
" ... 
"                                           /** vundle命令 **/
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo 
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"   
" see :h vundle for more details or wiki for FAQ 
" NOTE: comments after Bundle command are not allowed..
	 
" YouCompleteMe
" ,jd 跳转到当前函数的定义或声明。
" ,l 打开错误/警告提示面板
" ,q 打开quickfix窗口 
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_autoclose_preview_window_after_completion= 1

" Solarized color
let g:solarized_termcolors=   256     
let g:solarized_termtrans =   0       
let g:solarized_degrade   =   0       
let g:solarized_bold      =   1       
let g:solarized_underline =   1       
let g:solarized_italic    =   1       
let g:solarized_style     =   "dark"  
let g:solarized_contrast  =   "normal"

" autoadd code
function InsertPythonCode()
    if a:lastline == 1 && !getline('.')
		normal i
		call setline('.', '#!/usr/bin/env python')
		normal o
		call setline('.', '# -*- coding:utf-8 -*-')
		normal o
		normal o
    end
endfunction
function InsertCppCode()
    if a:lastline == 1 && !getline('.')
		normal i
		call setline('.', '#include <iostream>')
		normal o
		normal o
		call setline('.', 'using namespace std;')
		normal o
		normal o
		call setline('.', 'int main()')
		normal o
		call setline('.', '{')
		normal o
		call setline('.', '    return 0;')
		normal o
		call setline('.', '}')
	end
endfunction
function InsertCode()
	if &filetype == 'cpp'
		%call InsertCppCode()
	elseif &filetype == 'python'
		%call InsertPythonCode()
	end
endfunction
au FileType python :normal gg

" C/C++，java，python compile and run
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
    	exec "!g++ -g % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -g % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
   	elseif &filetype == 'sh'
         :!./%
   	elseif &filetype == 'py'
        exec "!python %"
        exec "!python %<"
  	endif
endfunc

" gvim fullscreen
function! ToggleFullScreen()
    call system("wmctrl -r :ACTIVE: -b toggle,fullscreen")
endfunction

" pyclewn
function! Debug()
    exec "!g++ -g %"
	let g:pyclewn_args = "--args=-q --gdb=async --window=none"
	:Pyclewn
	:Cinferiortty
	:Cfile a.out
	:Cmapkeys
endfunction

filetype plugin indent on

