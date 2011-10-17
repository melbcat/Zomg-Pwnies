        ;; === Minimalistic Linux shell ===
        ;;
        ;; This will eventually become a detailed but concise description.
        %define FD_IN   STD_IN
        %define FD_OUT  STD_OUT
        ;;
        ;; ================================

        %define BUF_SZ 4096
        %include "32.asm"
        [bits 32]
        mov ebp, esp
        ;; Allocate string buffer and variable "TMP"
        sub esp, BUF_SZ + 4
        ;; Save in- and output descriptors
        push dword FD_IN
        push dword FD_OUT
        ;; Local variable offsets:
        %define BUF (BUF_SZ)
        %define TMP (BUF_SZ + 4)
        %define IN  (BUF_SZ + 8)
        %define OUT (BUF_SZ + 12)
        ;; Loop start
loop:
        ;; BEGIN: Prompt
        ;; Get CWD
        mov eax, SYS_getcwd
        lea ebx, [ebp - BUF]
        mov ecx, BUF_SZ
        int 0x80
        cmp eax, 0
        jg getcwd_success
        mov [ebp - BUF], word "??"
        mov eax, 2
getcwd_success:
        mov [ebp - BUF + eax], word "> "
        mov edx, eax
        add edx, 2
        ;; Print prompt
        mov eax, SYS_write
        mov ebx, [ebp - OUT]
        lea ecx, [ebp - BUF]
        int 0x80
        ;; END: Prompt
        ;; Read input
        mov eax, SYS_read
        mov ebx, [ebp - IN]
        lea ecx, [ebp - BUF]
        mov edx, BUF_SZ
        int 0x80
        mov [ebp - BUF + eax - 1], byte 0 ; Cut away '\n'
        mov eax, [ebp - BUF]
        mov ebx, [ebp - BUF + 4]

        cmp eax, "cat "
        jz cat

        cmp ax, "cd"
        jz cd

        cmp ax, "ls"
        jz ls

        ;; Print error message
        mov [ebp - BUF], dword `???\n`
        mov eax, SYS_write
        mov ebx, [ebp - OUT]
        lea ecx, [ebp - BUF]
        mov edx, 4
        int 0x80
        jmp loop

        %include "cat.asm"
        %include "cd.asm"
        %include "ls.asm"
        %include "error.asm"
