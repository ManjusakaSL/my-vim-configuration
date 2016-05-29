set nocompatible
set history=500
set hlsearch
set number
set tabstop=4
set shiftwidth=4
set autoindent
set nobackup
set ruler
"set showmode
set incsearch
" 搜索到达文件尾就结束 set wrapscan
" 搜索忽略大小写 set ignorecase
set backspace=2 " 退格键可用
colorscheme torte
let mapleader=","

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


" map
map			 <C-p>				"+gP
map  		 <F5> 				:call CompileRunGcc()<CR>
map			 <F2>				:!pydoc 
map          <F4>               :call Debug()<CR>
map			 <F3>               :call InsertCode()<CR>
nmap 		 <C-a>				ggVG
nmap 		 <leader>n 			<plug>NERDTreeTabsToggle<CR>    
nmap		 <leader>t			:TagbarToggle<CR>   
nmap         <leader>w          :resize 10<CR>
vmap		 <C-c>				"+y
vmap         <C-x>              "+x

" Vundle
set nocompatible               " be iMproved
filetype off                   " required! /**  从这行开始，vimrc配置 **/

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:  /* 插件配置格式 */
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
" Bundle "davidhalter/jedi"
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

" C/C++ debug
func! Debug()
	exec "!g++ -g % -o %<"
	let g:pyclewn_args = "--window=none"
	exec "Pyclewn"
	exec "Cfile %<" 
	exec "Cinferiortty"
	exec "Cmapkeys"
endfunc

filetype plugin indent on
