#!/usr/bin/python
import sys, socket, random, pickle, os, time

MAX_LINES = 20

try:
    with open('data.pickle', 'r') as f:
        (imgs, rel, guesses, bestrun) = pickle.load(f)
except IOError:
    imgs = dict()
    rel = [[False for i in range(0, 71)] for j in range(0, 71)]
    bestrun = 0
    guesses = 0

class SocketIO:
    def __init__ (self, sock):
        self.sock = sock
        self.msg = ''
        self.p = 0

    def next (self):
        if self.p == len(self.msg):
            self.p = 0
            self.msg = self.sock.recv(4096)
            if len(self.msg) == 0:
                raise Exception('Socket closed prematurely')

    def readbytes (self, numbytes):
        bytes = ''
        left = numbytes
        while True:
            self.next()
            if len(self.msg) - self.p >= left:
                bytes += self.msg[self.p : self.p + left]
                self.p += left
                break
            else:
                bytes += self.msg[self.p:]
                left -= len(self.msg) - self.p
                self.p = len(self.msg)
        return bytes

    def readint (self):
        bs = self.readbytes(4)
        return ord(bs[3]) + 256 * (ord(bs[2]) + 256 * (ord(bs[1]) + 256 * ord(bs[0])))

    def write (self, text):
        return self.sock.send(text)

def conv (x):
    x = x ^ 0xc932f768
    if (x & 0x80000000):
        return -0x100000000 + x
    else:
        return x

def savestate ():
    try:
        with open('data.pickle', 'w') as f:
            pickle.dump((imgs, rel, guesses, bestrun), f)
    except:
        pass

def lookup (img):
    ih = hash(img)
    if ih in imgs:
        return imgs[ih]
    else:
        l = len(imgs)
        imgs[ih] = l
        return l

def beats (a, b):
    return rel[a][b]

def insert (a, b):
    global guesses
    guesses = guesses + 1
    print '(added: ' + str(a) + ' beats ' + str(b) + ')'
    rel[a][b] = True
    def loop (a, b):
        for c in range(0, 71):
            # guess what - without the 'new' check the running time becomes O(n^4)!
            new = False
            if rel[b][c] and not rel[a][c]:
                new = True
                rel[a][c] = True
            if rel[c][a] and new:
                loop(c, a)
    loop(a, b)

def run (header):
    n = -1
    res = []
    s = socket.socket()
    # s.connect(('192.41.96.174', 8129))
    # s.connect(('127.0.0.1', 8129))
    s.connect(('192.168.56.101', 8129))
    sio = SocketIO(s)
    sio.write('illogical\n')
    guess = False
    choices = ''
    thisrun = -1
    while True:
        thisrun += 1
        i = conv(sio.readint())
        if i < 0:
            if i == -1 or i == -2:
                insert(right, left)
            elif i == -3:
                if guess:
                    choices = choices + 'L'
                print ''
                print 'Done! (' + choices + ')'
                # print 'Done!'
                sio.write(choices)
                i = conv(sio.readint())
                if i == -4:
                    print 'The answer is: ' + sio.readbytes(sio.readint())
                    savestate()
                    exit(0)
            break
        else:
            if guess:
                insert(left, right)
                choices = choices + 'L'
                guess = False
            n = n + 1
            imgl = sio.readbytes(i)
            imgr = sio.readbytes(conv(sio.readint()))
            left = lookup(imgl)
            right = lookup(imgr)
            print 'Fight: ' + str(left) + ' vs. ' + str(right) + '  \t',
            if beats (left, right):
                print 'Left'
                choices = choices + 'L'
                sio.write('\0')
            elif beats (right, left):
                print 'Right'
                choices = choices + 'R'
                sio.write('\1')
            else:
                guess = True
                print 'Guessing',
                sio.write('\0')
    s.close()
    return thisrun

def main ():
    global bestrun
    tsize = 35 * 71 # 1 + 2 + ... + 70
    while True:
        trues = 0
        for i in range(0, 71):
            for j in range(0, 71):
                if rel[i][j]:
                    trues = trues + 1
        header = 'Best run: %d \t (table %d%% filled (%d/%d) - %d guesses so far)' % \
            (bestrun, (100 * trues) / tsize, trues, tsize, guesses)
        os.system('clear')
        print header
        try:
            thisrun = run(header)
            if thisrun > bestrun:
                bestrun = thisrun
        except KeyboardInterrupt:
            print '\nHave a nice day sir.'
            exit(0)
        except socket.error:
            print 'Problems with the connection. Trying again.'
        finally:
            savestate()
        print ''

if __name__ == '__main__':
    main ()
