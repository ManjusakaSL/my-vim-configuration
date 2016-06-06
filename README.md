配置如下：

<-------------------------------------------------tagbar-------------------------------------------------->

需要安装ctags: 

	sudo apt-get install ctags


<----------------------------------------------YouCompleteMe---------------------------------------------->

若vim不支持python: 

	完全卸载掉之前的vim: 
	
	sudo apt-get remove vim 
	
	sudo apt-get remove vim-runtime 
	
	sudo apt-get remove gvim 
	
	sudo apt-get remove vim-tiny 
	
	sudo apt-get remove vim-common 
	
	sudo apt-get remove vim-gui-common
	
	
	下载编译的相关工具和一些库： 
	
	sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial

	下载最新版本的vim7.4: ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 
	
	解压后，进入vim74目录，配置需要安装的vim 
	./configure --with-features=huge --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --enable-cscope --enable-multibyte --prefix=/usr

		--with-features=huge：支持最大特性
		--enable-pythoninterp：启用Vim对python编写的插件的支持
		--enable-multibyte：多字节支持 可以在Vim中输入中文
		--enable-cscope：Vim对cscope支持
		--with-python-config-dir=/usr/lib/python2.7/config-i386-linux-gnu/ 指定 python 路径
		--prefix=/usr：编译安装路径
		需要重新配置可 输入 make distclean #清理一下上一次编译生成的所有文件。

	sudo make VIMRUNTIMEDIR=/usr/share/vim/vim74
	sudo make install

vim支持python后，参考: https://github.com/Valloric/YouCompleteMe 安装YouCompleteMe

<-------------------------------------------------pyclewn------------------------------------------------->

设置断点: Cbreak num 或者　CTRL-b 设置光标所在行为断点

清除光标所在行断点： CTRL-k

运行到下一个断点: R
	
单步执行跳过函数: CTRL-n

单步执行不跳过函数: S

查看变量: Cdbgvar varname

<-------------------------------------------------shortcut------------------------------------------------->

以下快捷键未指明模式的都工作在Normal模式

F3                     自动插入c++和python首部

F4                     调试c/c++, python

F5                     编译运行C/C++, java, python

ctrl+a                 全选

ctrl+p                 粘贴粘贴板的内容（粘贴板用于和外部交互）

ctrl+c                 Visual模式下选中之后，复制到粘贴板

ctrl+x                 Visual模式下选中之后，剪切到粘贴板

,t	                   打开tagbar

,n	                   打开NERDTree

\p	                   给单词加大括号

\c	                   给单词加小括号
