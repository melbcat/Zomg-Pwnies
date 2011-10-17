ls:
        ;; tmp = open(path, O_RDONLY)
        mov eax, SYS_open
        cmp BYTE [ebp - BUF + 2], 0
        jne has_arg
        mov DWORD [ebp - BUF + 2], ` .\0\0`
has_arg:
        lea ebx, [ebp - BUF + 3] ; Go pas 'ls '
        mov ecx, O_RDONLY
        int 0x80
        cmp eax, 0
        jl error
        mov [ebp - TMP], eax
ls_loop:
        ;; getdents(tmp, buf, buf_sz)
        mov eax, SYS_getdents
        mov ebx, [ebp - TMP]
        lea ecx, [ebp - BUF]
        mov edx, BUF_SZ
        int 0x80
        cmp eax, 0
        ;; exit if end of directory
        jz loop
        jl error

        lea edi, [ebp - BUF]
        ;; int 3
ls_loop_inner:
        ;; printf(buf.d_name)
        mov eax, SYS_write
        mov ebx, [ebp - OUT]
        lea ecx, [edi + 10]     ; buf.d_name
        ;; find string length
        xor edx, edx
ls_len_loop:
        cmp byte [ecx + edx], 0
        jz ls_len_exit
        inc edx
        jmp ls_len_loop
ls_len_exit:
        mov [ecx + edx], byte `\n`
        inc edx
        int 0x80
        ;; Next
        add di, [edi + 8] ; buf.d_reclen
        cmp dword [edi], 0        ; buf.d_inode =? NULL
        jz ls_loop
        jmp ls_loop_inner