#include <math.h>

#if 1
typedef struct {
    unsigned char rgbtRed;
    unsigned char rgbtGreen;
    unsigned char rgbtBlue;
} __attribute__((__packed__)) RGBTRIPLE;
#endif

// Blur image
void
blur(int height, int width,
    RGBTRIPLE image[height][width],
    RGBTRIPLE imgout[height][width])
{
    int wid = width - 1;
    int hgt = height - 1;
    RGBTRIPLE *pixel;

    // For each row..
    for (int ycur = 0;  ycur <= hgt;  ++ycur) {
        int ylo = (ycur == 0) ? 0 : -1;
        int yhi = (ycur == hgt) ? 0 : 1;

        // ..and then for each pixel in that row...
        for (int xcur = 0;  xcur <= wid;  ++xcur) {
            int xlo = (xcur == 0) ? 0 : -1;
            int xhi = (xcur == wid) ? 0 : 1;

            int avgRed = 0;
            int avgGreen = 0;
            int avgBlue = 0;

            for (int yoff = ylo;  yoff <= yhi;  ++yoff) {
                for (int xoff = xlo;  xoff <= xhi;  ++xoff) {
                    pixel = &image[ycur + yoff][xcur + xoff];
                    avgRed += pixel->rgbtRed;
                    avgGreen += pixel->rgbtGreen;
                    avgBlue += pixel->rgbtBlue;
                }
            }

            int tot = ((yhi - ylo) + 1) * ((xhi - xlo) + 1);

            pixel = &imgout[ycur][xcur];
            pixel->rgbtRed = roundf((float) avgRed / tot);
            pixel->rgbtGreen = roundf((float) avgGreen / tot);
            pixel->rgbtBlue = roundf((float) avgBlue / tot);
        }
    }
}