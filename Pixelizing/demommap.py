import struct
import mmap
import os

a = [(16, 87, 109), (14, 81, 105), (13, 74, 100), (13, 71, 98), (12, 68, 96), (12, 65, 93), (11, 62, 91), (11, 61, 90), (12, 61, 90), (13, 62, 92), (14, 64, 93), (14, 67, 95), (15, 71, 99), (17, 76, 103), (19, 82, 108), (21, 89, 113), (23, 98, 120), (23, 95, 116), (15, 63, 83), (25, 99, 115)]
b = [(16, 87, 109), (25, 110, 134), (39, 124, 140), (16, 64, 93), (6, 35, 64), (4, 27, 54), (4, 26, 52), (4, 22, 48), (4, 22, 48), (3, 19, 44)]
c = [(25, 99, 115), (34, 138, 155), (19, 74, 97), (11, 42, 68), (5, 28, 55), (4, 26, 53), (5, 35, 64), (4, 29, 55), (3, 20, 45), (3, 19, 44)]

list_to_write = c

base_addr = 0xc000000

fname = '/dev/mem'

mem_window_size = len(list_to_write)*4
f = os.open(fname, os.O_RDWR | os.O_SYNC)
mem = mmap.mmap(f, mem_window_size, mmap.MAP_SHARED,
    mmap.PROT_READ | mmap.PROT_WRITE,
    offset=base_addr)

for rgb_el in list_to_write:
    data_portion = list(rgb_el)+[0]
    word = struct.pack('BBBB', *data_portion)
    print('writing at position = {}: {}, initial data: {}'.
                format(mem.tell(), word, data_portion))
    #debugger #import pdb;pdb.set_trace()
    mem.write(word)