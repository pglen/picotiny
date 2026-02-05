#!/usr/bin/env python3

import sys

fname = "genver.txt"
BUILD = "1.0.0"
MAXRANGE = 9

buildstr = "char *BUILD";

def incstr(strx):
    carry = 0
    ii = int(strx) + 1
    if ii > MAXRANGE:
       carry = 1
       ii = 0
    return carry, ii

nofile = False

try:
    fp = open(fname, "r")
    buff = fp.read()
    fp.close()
    if not buff:
        nofile = True
except:
    nofile = True

if nofile:
    fp = open(fname, "w")
    buff = "%s = \"0.0.0\";\n" % buildstr
    fp.write(buff)
    fp.close()

#print("read buff", buff)

for aa in buff.split("\n"):
    if aa[:len(buildstr)] == buildstr:
        bb = aa.split('"')
        cc = bb[1].split(".")
        # Increment:
        for idx in range(len(cc)-1, -1, -1):
            carry, cc[idx] = incstr(cc[idx])
            if not carry:
                break
        for ccc in range(len(cc)):
            cc[ccc] = int(cc[ccc])
        #print("cc", cc)
        # Save it back
        try:
            fp = open(fname, "w")
            buff = "%s = \"%d.%d.%d\";\n" % \
                                (buildstr, cc[0],cc[1],cc[2])
            #print("write buff:", buff, end = " ")
            fp.write(buff)
            fp.close()
        except:
            print("cannot write", sys.exc_info())

# EOF