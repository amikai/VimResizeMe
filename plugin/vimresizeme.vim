if exists("g:loaded_vimresizeme")
    finish
endif

function! s:resize_window(dir) abort
    let l:dir = a:dir
    let l:resize_dir = { 'left':'<', 'right':'>', 'up':'-', 'down':'+' }
    let l:move = { 'left':'h', 'right':'l', 'up':'k', 'down':'j' }
    let l:oppsite_dir = { 'left':'right', 'right':'left', 'down':'up', 'up':'down' }

    let l:orig_winnr = winnr()
    execute 'wincmd ' . l:move[l:dir]
    let l:jump_winnr = winnr()

    if(l:dir == 'right' || l:dir == 'down')
        execute l:orig_winnr . 'wincmd w'
    endif

    if(l:orig_winnr == l:jump_winnr)
        execute 'wincmd ' . l:move[l:dir]
        let l:dir = l:dir == 'right' || l:dir == 'down' ?
                    \ oppsite_dir[l:dir] : l:dir
    endif

    execute 'wincmd ' . l:resize_dir[l:dir]
    execute l:orig_winnr . 'wincmd w'
endfunction


command! VrmResizeUp call <SID>resize_window('up')
command! VrmResizeDown call <SID>resize_window('down')
command! VrmResizeRight call <SID>resize_window('right')
command! VrmResizeLeft call <SID>resize_window('left')
