let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <expr> <BS> v:lua.MiniPairs.bs()
inoremap <C-W> u
inoremap <C-U> u
nnoremap  <Cmd>nohlsearch|diffupdate|normal! 
nmap  d
nnoremap  w <Cmd>bdelete
nnoremap  	 <Cmd>b#
nnoremap  l <Cmd>bnext
nnoremap  h <Cmd>bprevious
nnoremap  dd <Cmd>FzfLua dap_commands
nnoremap  fr <Cmd>FzfLua buffers
nnoremap  ff <Cmd>FzfLua files
tnoremap  tt <Cmd>ToggleTerm
nnoremap  tt <Cmd>ToggleTerm
nnoremap  db <Cmd>DapToggleBreakpoint
nnoremap  dx <Cmd>DapTerminate
nnoremap  dr <Cmd>DapContinue
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nnoremap & :&&
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
nnoremap Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
onoremap <silent> gc <Cmd>lua MiniComment.textobject()
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nmap <C-W><C-D> d
nnoremap <C-L> <Cmd>nohlsearch|diffupdate|normal! 
inoremap <silent> <expr>  v:lua.MiniPairs.cr()
inoremap  u
inoremap  u
inoremap <expr> " v:lua.MiniPairs.closeopen('""', "[^\\].")
inoremap <expr> ' v:lua.MiniPairs.closeopen("''", "[^%a\\].")
inoremap <expr> ( v:lua.MiniPairs.open("()", "[^\\].")
inoremap <expr> ) v:lua.MiniPairs.close("()", "[^\\].")
inoremap <expr> [ v:lua.MiniPairs.open("[]", "[^\\].")
inoremap <expr> ] v:lua.MiniPairs.close("[]", "[^\\].")
inoremap <expr> ` v:lua.MiniPairs.closeopen("``", "[^\\].")
inoremap jj 
inoremap <expr> { v:lua.MiniPairs.open("{}", "[^\\].")
inoremap <expr> } v:lua.MiniPairs.close("{}", "[^\\].")
let &cpo=s:cpo_save
unlet s:cpo_save
set expandtab
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ -uu\ 
set helplang=en
set nohlsearch
set ignorecase
set noloadplugins
set packpath=/nix/store/5akabmajpnd5dqy5yxgb7fz62p7kkwg8-neovim-unwrapped-0.10.1/share/nvim/runtime
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/lualine.nvim,~/.local/share/nvim/lazy/gruvbox-material,~/.local/share/nvim/lazy/fzf-lua,~/.local/share/nvim/lazy/toggleterm.nvim,~/.local/share/nvim/lazy/gruvbox.nvim,~/.local/share/nvim/lazy/kanagawa.nvim,~/.local/share/nvim/lazy/mason.nvim,~/.local/share/nvim/lazy/mason-lspconfig.nvim,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/mini.nvim,~/.local/share/nvim/lazy/indent-blankline.nvim,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/nvim-colorizer.lua,~/.local/share/nvim/lazy/cmp_luasnip,~/.local/share/nvim/lazy/LuaSnip,~/.local/share/nvim/lazy/cmp-buffer,~/.local/share/nvim/lazy/cmp-path,~/.local/share/nvim/lazy/cmp-nvim-lua,~/.local/share/nvim/lazy/cmp-nvim-lsp,~/.local/share/nvim/lazy/nvim-cmp,~/.local/share/nvim/lazy/nvim-nio,~/.local/share/nvim/lazy/nvim-dap-ui,~/.local/share/nvim/lazy/nvim-dap,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/nvim-navic,~/.local/share/nvim/lazy/barbecue.nvim,/nix/store/5akabmajpnd5dqy5yxgb7fz62p7kkwg8-neovim-unwrapped-0.10.1/share/nvim/runtime,/nix/store/5akabmajpnd5dqy5yxgb7fz62p7kkwg8-neovim-unwrapped-0.10.1/share/nvim/runtime/pack/dist/opt/matchit,/nix/store/5akabmajpnd5dqy5yxgb7fz62p7kkwg8-neovim-unwrapped-0.10.1/lib/nvim,~/.local/share/nvim/lazy/indent-blankline.nvim/after,~/.local/share/nvim/lazy/cmp_luasnip/after,~/.local/share/nvim/lazy/cmp-buffer/after,~/.local/share/nvim/lazy/cmp-path/after,~/.local/share/nvim/lazy/cmp-nvim-lua/after,~/.local/share/nvim/lazy/cmp-nvim-lsp/after,~/.config/nvim/after,~/.local/state/nvim/lazy/readme
set scrolloff=8
set shiftwidth=4
set smartcase
set softtabstop=4
set statusline=%#Normal#
set tabstop=4
set termguicolors
set undofile
set window=45
" vim: set ft=vim :
