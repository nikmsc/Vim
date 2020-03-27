" Maintainer: Nikos Kanistras
" last Change: 2020 February 16

" === Plug-in Installation ===

" *** Settings for Correct Plug-in Loading *** 
    "Force plugins to load correctly.
    filetype on

    " For plug-ins to load correctly.
    filetype plugin indent on
    filetype indent on

" *** Auto Installation ***
    if empty(glob('~/.vim/autoload/plug.vim'))
       silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif

" *** Plugins Installation ***
    call plug#begin('~/.vim/plugged')
    Plug 'lervag/vimtex'
    Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
    Plug 'sirver/ultisnips'
    Plug 'ycm-core/YouCompleteMe'
    Plug 'liuchengxu/space-vim-dark'
    Plug 'dense-analysis/ale'
    Plug 'jiangmiao/auto-pairs'
    call plug#end()

" *** LaTeX ***
    " SyncTeX funcionality with zathura.
    function! SyncTexForward()
    let execstr = "silent !zathura --synctex-forward ".line(".").":".col(".").":%:p %:p:r.pdf &"
    exec execstr
    endfunction
    au FileType tex nmap <Leader>f :call SyncTexForward()<CR>    au BufNewFile,BufRead *.tikz set filetype=tex
    let g:tex_flavor ='latex'
    let g:vimtex_quickfix_open_on_warning = 0
    let g:vimtex_quickfix_mode = 0
    set conceallevel=2
    let g:tex_conceal="abdgm"
    let g:latex_view_general_viewer = "zathura"
    let g:vimtex_view_method = "zathura"
    set makeprg=texwrapper
    set errorformat=%f:%l:%c:%m
    nnoremap \lc :VimtexStop<cr>:VimtexClean<cr>

" *** UltiSnips ***
    let g:UltiSnipsSnippetsDir="~/.vim/ultisnips"
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" === General Settings ===

" *** Basic Stuff ***
    " Set vim with no compatibility to Vi.
    set nocompatible

    " Save as sudo
    command! -nargs=0 Sw w !sudo tee % > /dev/null

    " Automatic source of .vimrc file.
    autocmd! bufwritepost .vimrc source %

    " text encoding.
    set encoding=utf8

    " Syntax
    syntax enable

    " Copy Paste from everywhere
    set clipboard=unnamedplus

    " Paste in insert mode with Ctrl+V
    imap <C-V> <C-R>+

    " Set backspace behavior.
    set backspace=indent,eol,start

    " No swap, backup and undo file.
    set nobackup
    set noswapfile
    set noundofile

    " Set line numbers.
    set number

    " Wrap Lines.
    set wrap

    " Wrap lines by the end of a word.
    set linebreak
    
    " Set Vim to not show @@@ on long lines
    set display+=lastline

    " Highlight cursor.
    " set cursorline

    " Set tab behavior.
    set autoindent
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set shiftround

    " Redraw only when it's needed.
    set lazyredraw

    " Highlight matching braces.
    set showmatch

    " Blink cursor on error instead of beeping.
    " set visualbell
    " No beeps when an error occurs.
    set noerrorbells

    " Improved searching.
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
    set showmatch
    " Clear search results.
    nnoremap <silent> // :noh<CR>

    " Make command line height. 
    " The value correspond to number of lines.
    set ch=2
    
    " Hide mouse
    set mousehide

    " Enable Mouse to scroll and resize.
    set mouse=a

    " Undo history.
    set history=1000

" *** File Searching ***
    " Fuzzy search for subdirectories
    set path+=**
    " Display all matching files when hitting tab complete
    set wildmenu
    " Ignores files with those extensions.
    set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
    " set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
    set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf 

" *** File Browser ***
    " Tree file browser inside vim.
    let g:netrw_anner=0
    let g:netrw_browse_split=4
    let g:netrw_altv=1
    let g:netrw_liststyle=3 

" *** Spliting ***
    set splitright
    set splitbelow

" *** Navigation ***
    " Moving around wrapped lines.
    nnoremap j gj
    nnoremap k gk

    " Move to beginning/end of line.
    nnoremap B ^
    nnoremap E $

    " $/^ doesn't do anything.
    nnoremap $ <nop>
    nnoremap ^ <nop>

    " Split navigation.
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    
    " Tab Navigation 
    " New tab shortcut.
    map tt :tabnew 
    " Next Tab
    map <M-Right> :tabn<CR>
    imap <M-Right> <ESC>:tabn<CR>
    " Previus Tab
    map <M-Left> :tabp<CR>
    imap <M-Left> <ESC>:tabp<CR>

    " *** Folding ***
    " Enable folding.
    set foldenable
    
    " Set the level we start to fold.
    set foldlevel=0

    " Open most folds by default.
    set foldlevelstart=00

    " Set max nested folds to 10.
    set foldnestmax=10

    " Folds based on indentation.
    set foldmethod=indent

    set foldignore=

    " Remaps space key to open/close folds.
    nnoremap <space> za

" *** Color ***
    " Terminal
    "set t_Co=256
    set background=dark 

    " Spacemacs dark Theme
    colorscheme space-vim-dark
    hi Comment cterm=italic " Italic comments.
    " hi Comment guifg=#5C6370 ctermfg=59 " Gray comments
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE

" *** Spell Checking ***
    setlocal spell
    set spelllang=en_us,el
    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
            
" === Status Line ===

" *** Current Mode ***
    let g:currentmode={
        \ 'n'  : 'NORMAL ',
        \ 'no' : 'N·Operator Pending ',
        \ 'v'  : 'VISUAL ',
        \ 'V'  : 'V·Line ',
        \ "\<C-v>" : 'V·Block ',
        \ 's'  : 'Select ',
        \ 'S'  : 'S·Line ',
        \ 'i'  : 'INSERT ',
        \ 'R'  : 'REPLACE ',
        \ 'Rv' : 'V·Replace ',
        \ 'c'  : 'Command ',
        \ 'cv' : 'Vim Ex ',
        \ 'ce' : 'Ex ',
        \ 'r'  : 'Prompt ',
        \ 'rm' : 'More ',
        \ 'r?' : 'Confirm ',
        \ '!'  : 'Shell ',
        \ 't'  : 'Terminal '
        \}

" *** Color of Status Line ***
    " Set the colors of status line.
    " guibg corresponds to background and guifg to foreground (letters).
    hi User1 guibg=#32a852 guifg=#a83832
    hi User2 guibg=#005f00 guifg=#afd700
    hi User3 guibg=#222222 guifg=#005f00
    hi User4 guibg=#222222 guifg=#d0d0d0

" *** Active Status ***
    function! ActiveStatus()
	 let statusline=""
	 let statusline.="%0*\ %{toupper(g:currentmode[mode()])}"
	 " let statusline.="%1*"
	 " let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%'):''}\ %)"
	 " let statusline.="%2*"
	 let statusline.=""
	 " let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
	 " let statusline.="%3*"
	 let statusline.=""
	 "let statusline.="%4*"
	 let statusline.="\ %<"
	 let statusline.="%f"
	 let statusline.="%{&modified?'\*':''}"
	 let statusline.="%{&readonly?'\ \ ':''}"
	 let statusline.="%="
	 let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
     let statusline.="\ [%{&fileencoding?&fileencoding:&encoding}]"
	 " let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
	 "  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
	 " let statusline.="%3*"
	 let statusline.="\ "
	 " let statusline.="%2*"
	 let statusline.=""
	 " let statusline.="%1*"
	 let statusline.="%3l:%3c"
	 let statusline.="\ %3p%%\ "
	 return statusline
    endfunction

" *** Inactive Status ***
	function! InactiveStatus()
	 let statusline=""
	 " let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%').'\ \ ':'\ '}%)"
	 " let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':'\ '}"
	 let statusline.="\ %<"
	 let statusline.="%f"
	 let statusline.="%{&modified?'\*':''}"
	 let statusline.="%{&readonly?'\ \ ':''}"
	 let statusline.="%="
	 let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
     let statusline.="\ [%{&fileencoding?&fileencoding:&encoding}]"
	 " let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
	 " let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
	 let statusline.="\ \ "
	 let statusline.="\%3l:%3c"
	 let statusline.="\ %3p%%\ "
	 return statusline
	endfunction

" *** Status Line Configuration ***
    " Always visible status line.
    set laststatus=2
    
    " Set status line at active status by default.
    set statusline=%!ActiveStatus()
augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
 " autocmd ColorScheme kalisi if(&background=="dark") | hi User1 guibg=#afd700 guifg=#005f00 | endif
 " autocmd ColorScheme kalisi if(&background=="dark") | hi User2 guibg=#005f00 guifg=#afd700 | endif
 " autocmd ColorScheme kalisi if(&background=="dark") | hi User3 guibg=#222222 guifg=#005f00 | endif
 " autocmd ColorScheme kalisi if(&background=="dark") | hi User4 guibg=#222222 guifg=#d0d0d0 | endif
 augroup END

" *** Status Line Configuration ***
	"set laststatus=2
	""set statusline=
	""set statusline+=%{ChangeStatuslineColor()}
	""set statusline+=%#PmenuSel#
	""set statusline+=%0*\ %{toupper(g:currentmode[mode()])}
	"""set statusline+=%{Status line Git()}
	""set statusline+=%#LineNr#
	""set statusline+=\ %f
	""set statusline+=%m\
	""set statusline+=%=
	""set statusline+=%#CursorColumn#
	""set statusline+=\ %y
	""set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
	""set statusline+=\[%{&fileformat}\]
	""set statusline+=\ %3l:%3c
	""set statusline+=\ %3p%%
	""set statusline+=\ 

" === GUI Configuration ===
    set guifont=Source\ Code\ Pro\ 12 " -misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
    set guioptions-=T  " no toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
