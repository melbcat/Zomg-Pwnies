
all: demo server hello-trampoline huge-shellcode connect-back bindshell \
  egg-hunter

demo:
	gcc demo.c -o demo -z execstack

server:
	gcc server.c -o server -z execstack -O0 -fno-stack-protector \
  -fno-builtin-memset

hello-trampoline:
	nasm -I linux/ hello-trampoline.asm

huge-shellcode:
	nasm -I linux/ huge-shellcode.asm

connect-back:
	nasm -I linux/ connect-back.asm

bindshell:
	nasm -I linux/ bindshell.asm

egg-hunter:
	nasm -I linux/ egg-hunter.asm

.PHONO:clean
clean:
	rm -f demo server hello-trampoline huge-shellcode connect-back bindshell \
  egg-hunter