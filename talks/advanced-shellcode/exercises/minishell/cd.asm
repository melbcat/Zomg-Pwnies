cd:
        mov eax, SYS_chdir
        lea ebx, [ebp - BUF + 3] ; Go past 'cd '
        int 0x80
        cmp eax, 0
        jl error
        jmp loop