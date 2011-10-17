cat:
        ;; tmp = open(path, O_RDONLY)
        mov eax, SYS_open
        lea ebx, [ebp - BUF + 4] ; Go pas 'cat '
        mov ecx, O_RDONLY
        int 0x80
        cmp eax, 0
        jl error
        mov [ebp - TMP], eax
cat_loop:
        ;; read(tmp, buf, buf_sz)
        mov eax, SYS_read
        mov ebx, [ebp - TMP]
        lea ecx, [ebp - BUF]
        mov edx, BUF_SZ
        int 0x80
        ;; exit if EOF
        cmp eax, 0
        jle loop
        ;; write(out, buf, bytes_read)
        mov edx, eax
        mov eax, SYS_write
        mov ebx, [ebp - OUT]
        lea ecx, [ebp - BUF]
        int 0x80
        jmp cat_loop
