prerr:
        pop ecx
        neg eax
        shl eax, 1
        add ecx, eax

        xor edx, edx
        mov dx, word [ecx + 2]
        sub dx, word [ecx]
        add edx, 2

        add cx, word [ecx]

        mov eax, SYS_write
        mov ebx, [ebp - OUT]
        int 0x80
        jmp loop
error:
        call prerr
enoerr:                 dw 0
eperm:                  dw seperm - $
enoent:                 dw senoent - $
esrch:                  dw sesrch - $
eintr:                  dw seintr - $
eio:                    dw seio - $
enxio:                  dw senxio - $
e2big:                  dw se2big - $
enoexec:                dw senoexec - $
ebadf:                  dw sebadf - $
echild:                 dw sechild - $
eagain:                 dw seagain - $
enomem:                 dw senomem - $
eacces:                 dw seacces - $
efault:                 dw sefault - $
enotblk:                dw senotblk - $
ebusy:                  dw sebusy - $
eexist:                 dw seexist - $
exdev:                  dw sexdev - $
enodev:                 dw senodev - $
enotdir:                dw senotdir - $
eisdir:                 dw seisdir - $
einval:                 dw seinval - $
enfile:                 dw senfile - $
emfile:                 dw semfile - $
enotty:                 dw senotty - $
etxtbsy:                dw setxtbsy - $
efbig:                  dw sefbig - $
enospc:                 dw senospc - $
espipe:                 dw sespipe - $
erofs:                  dw serofs - $
emlink:                 dw semlink - $
epipe:                  dw sepipe - $
edom:                   dw sedom - $
erange:                 dw serange - $
edeadlk:                dw sedeadlk - $
enametoolong:           dw senametoolong - $
enolck:                 dw senolck - $
enosys:                 dw senosys - $
enotempty:              dw senotempty - $
eloop:                  dw seloop - $
ewouldblock:            dw sewouldblock - $
enomsg:                 dw senomsg - $
eidrm:                  dw seidrm - $
echrng:                 dw sechrng - $
el2nsync:               dw sel2nsync - $
el3hlt:                 dw sel3hlt - $
el3rst:                 dw sel3rst - $
elnrng:                 dw selnrng - $
eunatch:                dw seunatch - $
enocsi:                 dw senocsi - $
el2hlt:                 dw sel2hlt - $
ebade:                  dw sebade - $
ebadr:                  dw sebadr - $
exfull:                 dw sexfull - $
enoano:                 dw senoano - $
ebadrqc:                dw sebadrqc - $
ebadslt:                dw sebadslt - $
edeadlock:              dw sedeadlock - $
ebfont:                 dw sebfont - $
enostr:                 dw senostr - $
enodata:                dw senodata - $
etime:                  dw setime - $
enosr:                  dw senosr - $
enonet:                 dw senonet - $
enopkg:                 dw senopkg - $
eremote:                dw seremote - $
enolink:                dw senolink - $
eadv:                   dw seadv - $
esrmnt:                 dw sesrmnt - $
ecomm:                  dw secomm - $
eproto:                 dw seproto - $
emultihop:              dw semultihop - $
edotdot:                dw sedotdot - $
ebadmsg:                dw sebadmsg - $
eoverflow:              dw seoverflow - $
enotuniq:               dw senotuniq - $
ebadfd:                 dw sebadfd - $
eremchg:                dw seremchg - $
elibacc:                dw selibacc - $
elibbad:                dw selibbad - $
elibscn:                dw selibscn - $
elibmax:                dw selibmax - $
elibexec:               dw selibexec - $
eilseq:                 dw seilseq - $
erestart:               dw serestart - $
estrpipe:               dw sestrpipe - $
eusers:                 dw seusers - $
enotsock:               dw senotsock - $
edestaddrreq:           dw sedestaddrreq - $
emsgsize:               dw semsgsize - $
eprototype:             dw seprototype - $
enoprotoopt:            dw senoprotoopt - $
eprotonosupport:        dw seprotonosupport - $
esocktnosupport:        dw sesocktnosupport - $
eopnotsupp:             dw seopnotsupp - $
epfnosupport:           dw sepfnosupport - $
eafnosupport:           dw seafnosupport - $
eaddrinuse:             dw seaddrinuse - $
eaddrnotavail:          dw seaddrnotavail - $
enetdown:               dw senetdown - $
enetunreach:            dw senetunreach - $
enetreset:              dw senetreset - $
econnaborted:           dw seconnaborted - $
econnreset:             dw seconnreset - $
enobufs:                dw senobufs - $
eisconn:                dw seisconn - $
enotconn:               dw senotconn - $
eshutdown:              dw seshutdown - $
etoomanyrefs:           dw setoomanyrefs - $
etimedout:              dw setimedout - $
econnrefused:           dw seconnrefused - $
ehostdown:              dw sehostdown - $
ehostunreach:           dw sehostunreach - $
ealready:               dw sealready - $
einprogress:            dw seinprogress - $
estale:                 dw sestale - $
euclean:                dw seuclean - $
enotnam:                dw senotnam - $
enavail:                dw senavail - $
eisnam:                 dw seisnam - $
eremoteio:              dw seremoteio - $
edquot:                 dw sedquot - $
enomedium:              dw senomedium - $
emediumtype:            dw semediumtype - $
ecanceled:              dw secanceled - $
enokey:                 dw senokey - $
ekeyexpired:            dw sekeyexpired - $
ekeyrevoked:            dw sekeyrevoked - $
ekeyrejected:           dw sekeyrejected - $
eownerdead:             dw seownerdead - $
enotrecoverable:        dw senotrecoverable - $
erfkill:                dw serfkill - $

seperm:
        db `Operation not permitted\n`
senoent:
        db `No such file or directory\n`
sesrch:
seintr:
seio:
senxio:
se2big:
senoexec:
sebadf:
sechild:
seagain:
senomem:
seacces:
        db `Permission denied\n`
sefault:
senotblk:
sebusy:
seexist:
        db `File exists\n`
sexdev:
senodev:
senotdir:
        db `Not a directory\n`
seisdir:
        db `Is a directory\n`
seinval:
senfile:
semfile:
senotty:
setxtbsy:
sefbig:
senospc:
sespipe:
serofs:
        db `Read only file system\n`
semlink:
sepipe:
sedom:
serange:
sedeadlk:
senametoolong:
senolck:
senosys:
senotempty:
seloop:
sewouldblock:
senomsg:
seidrm:
sechrng:
sel2nsync:
sel3hlt:
sel3rst:
selnrng:
seunatch:
senocsi:
sel2hlt:
sebade:
sebadr:
sexfull:
senoano:
sebadrqc:
sebadslt:
sedeadlock:
sebfont:
senostr:
senodata:
setime:
senosr:
senonet:
senopkg:
seremote:
senolink:
seadv:
sesrmnt:
secomm:
seproto:
semultihop:
sedotdot:
sebadmsg:
seoverflow:
senotuniq:
sebadfd:
seremchg:
selibacc:
selibbad:
selibscn:
selibmax:
selibexec:
seilseq:
serestart:
sestrpipe:
seusers:
senotsock:
sedestaddrreq:
semsgsize:
seprototype:
senoprotoopt:
seprotonosupport:
sesocktnosupport:
seopnotsupp:
sepfnosupport:
seafnosupport:
seaddrinuse:
seaddrnotavail:
senetdown:
senetunreach:
senetreset:
seconnaborted:
seconnreset:
senobufs:
seisconn:
senotconn:
seshutdown:
setoomanyrefs:
setimedout:
seconnrefused:
sehostdown:
sehostunreach:
sealready:
seinprogress:
sestale:
seuclean:
senotnam:
senavail:
seisnam:
seremoteio:
sedquot:
senomedium:
semediumtype:
secanceled:
senokey:
sekeyexpired:
sekeyrevoked:
sekeyrejected:
seownerdead:
senotrecoverable:
serfkill:
