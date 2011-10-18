GCC=gcc -m32 -O0 -z execstack -fno-stack-protector -fno-builtin

all: demo server hello-trampoline huge-shellcode connect-back bindshell \
  c-bindshell egg-hunter

demo:
	$(GCC) demo.c -o demo

server:
	$(GCC) server.c -o server

c-bindshell:
	$(GCC) c-bindshell.c -o c-bindshell

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
  c-bindshell egg-hunter