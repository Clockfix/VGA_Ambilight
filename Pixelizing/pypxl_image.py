#!/usr/local/bin/python3
import sys
from PIL import Image
import numpy as np
# import binascii #HEX converter

# For calculating script runtime
import time
start = time.time()

# import serial

# Pixelise Width & Hight definitio
width = 20
hight = 10

# Pixel brightness treshold
brightness = 7

# Open Paddington
img = Image.open("forest_bl.jpg")

# Resize smoothly down to defined pixel size
imgSmall = img.resize((width, hight),resample=Image.BILINEAR)

# Multiply each pixel for making pixels more brighter
outImage = imgSmall.point(lambda i: i * 1.3)

# Scale back up using NEAREST to original size
#resultemp = out.resize(img.size,Image.NEAREST)

# Resize Image to pixels size
#result = resultemp.resize((width, hight), Image.ANTIALIAS)

# Get Pixels RGB values in DEC
pixel_png = list(outImage.getdata())

# pixel_png_test = np.array(result)

# Store RGB values in HEX string
hex_list=[]
for px in pixel_png:
    he='%02x%02x%02x' % px
    hex_list.append(he)

# Define used list for output ///Uncomment oly one of them
#pixel_list = pixel_png
pixel_list = hex_list

print('Selected list:')
print(pixel_list)

# Store Pixels data in a file
#sys.stdout = open("resultsOut.txt", "w")

print('Image pixel data in HEX:')
print(hex_list)

# print('Image pixel data in RGB2:')
# print(pixel_png_test)
print('Image pixel data in RGB:')
print(pixel_png)
# print(pixel_png_test[0])
# print(pixel_png_test[9,2])
# print(pixel_png_test[9,3])

print('')
print('Image first reference row:')
print(pixel_png[0:width])
# print('')

print('Image first row modified:')
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

# End code part
print(firstRow)
print('')

# print('Image Left column referebce:')
# left_column = pixel_png[0:width*hight-1:width]
# print(left_column)

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
print('Print Left column modified:')
print(leftCol)
# print('')

# print('Image Right column reference:')
# right_column = pixel_png[width-1:width*hight:width]
# print(right_column)

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
print('Print right column modified:')
print(rightCol)

# Close file with stored results
#sys.stdout.close()

# Save temp output image
outImage.save('resulTemp.png')

# Save result output image
#result.save('result.png')


# def write_u32(address, data):
#     assert address % 4 == 0, "Address must be 32-bit aligned"
#     path = path.lib.Path("/dev/uio0")
#     file_size = path.stat().st_size
#     with path.open(mode='w+b') as f:
#         mv = memoryview(mmap.mmap(f.fileno(), file_size))
#         struct.pack_into("<I", mv, address, data)

print('It took', time.time()-start, 'seconds.')