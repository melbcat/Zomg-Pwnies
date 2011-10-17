error:
        neg eax
        mov bl, 0x10
        div bl
        add ax, 0x3030

        cmp ah, 0x39
        jle errno_a
        add ah, 7
errno_a:
        cmp al, 0x39
        jle errno_b
        add al, 7
errno_b:

        mov [ebp - BUF + 0], dword "EE  "
        mov [ebp - BUF + 3], ax
        mov [ebp - BUF + 5], byte `\n`

        mov eax, SYS_write
        mov ebx, [ebp - OUT]
        lea ecx, [ebp - BUF]
        mov edx, 6
        int 0x80

        jmp loop