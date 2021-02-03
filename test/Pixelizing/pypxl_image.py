#!/usr/local/bin/python3
import sys
from PIL import Image

# Pixelise Width & Hight definitio
width = 20
hight = 10

# Open Paddington
img = Image.open("forest.jpg")

# Resize smoothly down to 16x16 pixels
imgSmall = img.resize((width, hight),resample=Image.BILINEAR)

# Multiply each pixel for making pixels more brighter
out = imgSmall.point(lambda i: i * 1.3)

# Scale back up using NEAREST to original size
resultemp = out.resize(img.size,Image.NEAREST)

# Resize Image to pixels size
result = resultemp.resize((width, hight), Image.ANTIALIAS)

# Get Pixels RGB values
pixel_png = list(result.getdata())

# Store Pixels data in a file
sys.stdout = open("resultsOut.txt", "w")
print(pixel_png)
sys.stdout.close()

# Save temp
resultemp.save('resulTemp.png')

# Save
result.save('result.jpg')
