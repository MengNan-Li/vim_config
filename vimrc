if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"文件类型检测，可以针对不同类型的文件加载不同的插件"
filetype on
"根据侦测的文件类型，加载相应的插件"
filetype plugin on

color ron
"support chinese"
set helplang=cn
set encoding=utf-8
"支持鼠标定位滚动等"
set mouse=a
"tab=4个空格"
set smartindent  
set tabstop=4  
set shiftwidth=4  
set expandtab  
" 大括号回车自动对齐
imap { {}<ESC>i<CR><ESC>V<O  
"自动缩进与C语言风格缩进
set autoindent
set cindent
"显示行号
set number
"设置头文件路径
set path +=.,/home/lmn/ros_ws/water_ws/devel/include/,/opt/ros/kinetic/include,/home/lmn/opencv-3.4.1/install/include
"搜索结果高亮
"set hlsearch 
set nohls
set clipboard+=unnamed "使用系统剪切板
set fenc=utf-8      "文件编码"

"-------------------------------------------------------------------------
"syntastic
"设置error和warning的标志
let g:syntastic_enable_signs = 0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='►'
"总是打开Location List（相当于QuickFix）窗口，如果你发现syntastic因为与其他插件冲突而经常崩溃，将下面选项置0
let g:syntastic_always_populate_loc_list = 1
"自动打开Locaton List，默认值为2，表示发现错误时不自动打开，当修正以后没有再发现错误时自动关闭，置1表示自动打开自动关闭，0表示关闭自动打开和自动关闭，3表示自动打开，但不自动关闭
let g:syntastic_auto_loc_list = 2
"修改Locaton List窗口高度
let g:syntastic_loc_list_height = 5
"打开文件时自动进行检查
let g:syntastic_check_on_open = 1
"自动跳转到发现的第一个错误或警告处
let g:syntastic_auto_jump = 1
"进行实时检查，如果觉得卡顿，将下面的选项置为1
let g:syntastic_check_on_wq = 0
"高亮错误1打开，0关闭
let g:syntastic_enable_highlighting=0
"让syntastic支持C++11
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"设置pyflakes为默认的python语法检查工具
let g:syntastic_python_checkers = ['pyflakes']
"修复syntastic使用:lnext和:lprev出现的跳转问题，同时修改键盘映射使用sn和sp进行跳转
function! <SID>LocationPrevious()                       
  try                                                   
    lprev                                               
  catch /^Vim\%((\a\+)\)\=:E553/                        
    llast                                               
  endtry                                                
endfunction                                             
function! <SID>LocationNext()                           
  try                                                   
    lnext                                               
  catch /^Vim\%((\a\+)\)\=:E553/                        
    lfirst                                              
  endtry                                                
endfunction                                             
nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>                                        
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> sp    <Plug>LocationPrevious              
nmap <silent> sn    <Plug>LocationNext
"关闭syntastic语法检查, 鼠标复制代码时用到, 防止把错误标志给复制了
nnoremap <silent> <Leader>ec :SyntasticToggleMode<CR>
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction



"-------------------------------------------------------------------------
let g:ctrlp_map='<leader>p'
let g:ctrlp_cmd='CtrlP'
map <leader>f :CtrlPMRU<CR>
"<Leader>b显示缓冲区文件，并可通过序号进行跳转
nmap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore={'dir':  '\v[\/]\.(git|hg|svn|rvm)$','file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',}
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif



"-------------------------------------------------------------------------
" YCM                                                            
" 允许自动加载.ycm_extra_conf.py，不再提示                         
let g:ycm_confirm_extra_conf=0                                     
" 补全功能在注释中同样有效                                         
let g:ycm_complete_in_comments=1                                   
" 开启tags补全引擎                                                 
let g:ycm_collect_identifiers_from_tags_files=1                    
" 键入第一个字符时就开始列出匹配项                                 
let g:ycm_min_num_of_chars_for_completion=1                        
" YCM相关快捷键，分别是\gl, \gf, \gg                                                    
nnoremap gl :YcmCompleter GoToDeclaration<CR>              
nnoremap gf :YcmCompleter GoToDefinition<CR>               
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
"-------------------------------------------------------------------------

"光标
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
" Highlight current line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

"EasyGrep插件设置
let g:EasyGrepMode = 1     " All:0, Open Buffers:1, TrackExt:2, 
let g:EasyGrepCommand = 0  " Use vimgrep:0, grepprg:1
let g:EasyGrepRecursive  = 1 " Recursive searching
let g:EasyGrepIgnoreCase = 1 " not ignorecase:0
let g:EasyGrepFilesToExclude = "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak"


"行光标移动  
"不起作用
nmap lh ^ 
"不起作用
nmap le $ 
"Ctrl+N 打开NERDTree"
map <C-n> :NERDTree<CR>
nmap fl :NERDTree<CR>
nmap <silent> <C-f> <leader>vv<CR>
nmap <silent> <S-r> <leader>vr
"Ctrl+C复制到剪切板
vmap <C-c> "+y 

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree



"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let g:ycm_min_num_of_chars_for_completion = 2  "开始补全的字符数"
let g:ycm_python_binary_path = '/home/lmn/anaconda3/envs/tensorflow/bin/python'  "jedi模块所在python解释器路径"
let g:ycm_seed_identifiers_with_syntax = 1  "开启使用语言的一些关键字查询"
let g:ycm_autoclose_preview_window_after_completion=1 "补全后自动关闭预览窗口"

"状态栏
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs"
"set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
"let g:Powerline_symbols = 'fancy'

"Python Tab补全
filetype plugin on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
let g:pydiction_menu_height = 3

set tags+=/home/lmn/opencv-3.4.1/tags,
