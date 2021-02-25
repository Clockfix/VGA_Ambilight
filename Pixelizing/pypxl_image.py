#!/usr/local/bin/python3
import sys
import mmap
import struct
import os
from PIL import Image
import numpy as np
# import binascii #HEX converter

rgb_addr = 0x0006000        # Address from where image is readed
base_addr = 0xC000000       # Address where converted image is stored
fname = '/dev/mem'          # Memory for storin Image RGB values
read_w = 25                 # Readed image width
read_h = 20                 # Readed image high
read_image = read_w*read_h  # Read image dimension W x H

# For calculating script runtime
# import time
# start = time.time()

# For some debugging
# import serial

# Pixelise Width & Hight definition
width = 20
hight = 10

# Pixel brightness treshold
brightness = 7

# Read RGB data from memory
mem_window_size2 = read_image*4
f = os.open(fname, os.O_RDWR | os.O_SYNC)
mem = mmap.mmap(f, mem_window_size2, mmap.MAP_SHARED,
    mmap.PROT_READ | mmap.PROT_WRITE,
    offset=rgb_addr)

data_rgb = []       # Create array
for i in range(read_image):
    data_portion2 = mem.read(4)
    word2 = struct.unpack_from('B'*3,data_portion2)
    data_rgb.append(word2)  # Fill array with data
    
# convert list to numpy array
np_array=np.asarray(data_rgb)
# reshape array into 5 rows x 10 columns, and transpose the result
reshaped_array = np_array.reshape(read_h, read_w, 3)

#print(reshaped_array)
#print(data_rgb)
mem.seek(0)

# # Open RGB values from array file
# pixels = open('img_rgb.dat', 'rb') 
# #pixels = open('img_rgb.txt', 'rb').read()

# Convert the pixels into an array using numpy
array = np.array(reshaped_array, dtype=np.uint8)

# Use PIL to create an image from the new array of pixels
new_image = Image.fromarray(array)

# Save image from rgb_addr memory
#new_image.save('new.png')       # save as image values from "rgb_addr" memory

# Close before opened file
# pixels.close()

# Open Paddington if we want make manipulation with image from file
#new_image = Image.open("new.png")

# Resize smoothly down to defined pixel size
imgSmall = new_image.resize((width, hight),resample=Image.BILINEAR)

# Multiply each pixel for making pixels more brighter
outImage = imgSmall.point(lambda i: i * 1)

# Scale back up using NEAREST to original size
#resultemp = out.resize(img.size,Image.NEAREST)

# Get Pixels RGB values in DEC
pixel_png = list(outImage.getdata())

width, height = outImage.size
pixel_png_test = [pixel_png[i * width:(i + 1) * width] for i in range(height)]

# Store RGB values in HEX string
hex_list=[]
for px in pixel_png:
    he='%02x%02x%02x' % px
    hex_list.append(he)

# Define used list for output ///Uncomment oly one of them
pixel_list = pixel_png
#pixel_list = hex_list

# print('Selected list:')
# print(pixel_list)

############ Store Pixels data in a file
#sys.stdout = open("resultsOut.txt", "w")

# print('Image pixel data in HEX:')
# print(hex_list)

# print('Image pixel data in RGB2:')
# print(pixel_png_test)
# print('Image pixel data in RGB:')
# print(pixel_png)
# print(pixel_png_test[0])
# print(pixel_png_test[9,3])

# print('')
# print('Image first reference row:')
# print(pixel_png[0:width])
# print('')
#================================
# Code part for searching dark pixels and replace with pixels below them
firstRow = []
count = 0
for fr in pixel_png[0:width]:
    if int((fr[0] + fr[1] + fr[2])/3) < brightness:   # Replace dark pixel with pixel below
        frPlace = width+count
        fr = pixel_list[frPlace]  # Get value from list
    else:
        fr = pixel_list[count]
    count = count + 1
    np.array(firstRow.append(fr))

# print('Image first row modified:')
# print('')
# print(firstRow)
# End code part
#=================================
# # print('')

# print('Image Left column referebce:')
# left_column = pixel_png[0:width*hight-1:width]
# print(left_column)

#================================
# Code part for searching dark pixels and replace with pixels to the right of them
leftCol = []
count = 0
for lc in pixel_png[0:width*hight-1:width]:
    if int((lc[0] + lc[1] + lc[2])/3) < brightness:   # Replace dark pixel with pixel to the right
        pxPlace = (width*count)+1
        lc = pixel_list[pxPlace]  # Get value from list
    else:
        lc = pixel_list[width*count]
    count = count + 1
    np.array(leftCol.append(lc))
# End code part
# print('Print Left column modified:')
# print(leftCol)
#================================
# print('')

# print('Image Right column reference:')
# right_column = pixel_png[width-1:width*hight:width]
# print(right_column)

#================================
# Code part for searching dark pixels and replace with pixels to the left of them
rightCol = []
count = 1
for rc in pixel_png[width-1:width*hight:width]:
    if int((rc[0] + rc[1] + rc[2])/3) < brightness:   # Replace dark pixel with pixel to the left
        rcPlace = (width*count)-2
        rc = pixel_list[rcPlace]  # Get value from list
    else:
        rc = pixel_list[(width*count-1)]
    count = count + 1
    np.array(rightCol.append(rc))
    
# End code part
# print('Print right column modified:')
# print(rightCol)
#================================

#print('It took', time.time()-start, 'seconds.')

# Close file with stored results
#sys.stdout.close()

# Save temp output image
outImage.save('resulTemp.png')

# Save result output image
#result.save('result.png')

list_to_write = firstRow

mem_window_size = len(list_to_write)*4
f = os.open(fname, os.O_RDWR | os.O_SYNC)
mem = mmap.mmap(f, mem_window_size, mmap.MAP_SHARED,
    mmap.PROT_READ | mmap.PROT_WRITE,
    offset=base_addr)

for rgb_el in list_to_write:
    data_portion = list(rgb_el)+[0]
    word = struct.pack('BBBB', *data_portion)
    # print('writing at position = {}: {}, initial data: {}'.
    #             format(mem.tell(), word, data_portion))
    #debugger #import pdb;pdb.set_trace()
    mem.write(word)

mem.seek(0)

#print('It took', time.time()-start, 'seconds.')