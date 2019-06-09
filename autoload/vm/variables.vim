"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set vim variable to VM compatible values

fun! vm#variables#set() abort
  let F = b:VM_Selection.Funcs
  let v = b:VM_Selection.Vars

  " disable folding, but keep winline
  if &foldenable
    call F.Scroll.get(1)
    let v.oldfold = 1
    set nofoldenable
    call F.Scroll.restore()
  endif

  if g:VM_case_setting ==? 'smart'
    set smartcase
    set ignorecase
  elseif g:VM_case_setting ==? 'sensitive'
    set nosmartcase
    set noignorecase
  else
    set nosmartcase
    set ignorecase
  endif

  "force default register
  set clipboard=

  "disable conceal
  set conceallevel=0
  set concealcursor=

  set virtualedit=onemore
  set ww=h,l,<,>
  set lz

  if !g:VM_manual_infoline
    let &ch = get(g:, 'VM_cmdheight', 2)
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Init VM variables

fun! vm#variables#init() abort
  let F = b:VM_Selection.Funcs
  let v = b:VM_Selection.Vars

  "init search
  let v.def_reg          = F.default_reg()
  let v.oldreg           = F.get_reg()
  let v.oldregs_1_9      = F.get_regs_1_9()
  let v.oldsearch        = [getreg("/"), getregtype("/")]

  "store old vars
  let v.oldvirtual       = &virtualedit
  let v.oldwhichwrap     = &whichwrap
  let v.oldlz            = &lz
  let v.oldch            = &ch
  let v.oldcase          = [&smartcase, &ignorecase]
  let v.indentkeys       = &indentkeys
  let v.cinkeys          = &cinkeys
  let v.synmaxcol        = &synmaxcol
  let v.oldmatches       = getmatches()
  let v.clipboard        = &clipboard
  let v.textwidth        = &textwidth
  let v.conceallevel     = &conceallevel
  let v.concealcursor    = &concealcursor

  "init new vars

  "block: [ left edge, right edge,
  "         minimum edge for all regions,
  "         flag for autocommand ]

  let v.block            = [0,0,0,0]
  let v.search           = []
  let v.IDs_list         = []
  let v.ID               = 0
  let v.active_group     = 0
  let v.index            = -1
  let v.direction        = 1
  let v.nav_direction    = 1
  let v.auto             = 0
  let v.silence          = 0
  let v.eco              = 0
  let v.only_this        = 0
  let v.only_this_always = 0
  let v.using_regex      = 0
  let v.multiline        = 0
  let v.block_mode       = 0
  let v.yanked           = 0
  let v.merge            = 0
  let v.insert           = 0
  let v.whole_word       = 0
  let v.winline          = 0
  let v.restore_scroll   = 0
  let v.find_all_overlap = 0
  let v.dot              = ''
  let v.no_search        = 0
  let v.no_msg           = g:VM_manual_infoline
  let v.visual_regex     = 0
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reset vim variables to previous values

fun! vm#variables#reset()
  let v = b:VM_Selection.Vars

  let &virtualedit = v.oldvirtual
  let &whichwrap   = v.oldwhichwrap
  let &smartcase   = v.oldcase[0]
  let &ignorecase  = v.oldcase[1]
  let &lz          = v.oldlz
  let &ch          = v.oldch
  let &clipboard   = v.clipboard
  let &indentkeys  = v.indentkeys
  let &cinkeys     = v.cinkeys
  let &synmaxcol   = v.synmaxcol
  let &textwidth   = v.textwidth

  let &conceallevel = v.conceallevel
  let &concealcursor = v.concealcursor
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reset VM global variables

fun! vm#variables#reset_globals()
  let b:VM_Backup = {}
  let b:VM_Selection = {}
  let g:Vm.is_active = 0
  let g:Vm.extend_mode = 0
  let g:Vm.selecting = 0
endfun

" vim: et ts=2 sw=2 sts=2 :