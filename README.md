# ROI_vehicle_detection
Region Of Interest for automated vehicle detection in a highway.
Project for Digital Image Processing subject, Electrical and Computer Engineering department, University of Patras.
08 July 2019

# Prerequisites

Matlab 2017.

# Code

The main code is in the file code/Project.m and this is the one we need to execute. First, we need to put the original video 'april21.avi' in the same folder with Project.m or specify the path.

All the other files contain the techniques used to assist us with the task of defining a Region Of Interest in the video that is given to us.

# Information

**Input video**
Read the video 'april21.avi'. This video contains information of 24 bits per pixel. The duration of the film is 10 seconds and FPS is 30. So, we have a total of 300 frames
and each frame is an RGB image of dimensions 480x704x3.

This is a Moving Camera Moving Objects (MCMO) video, which is the hardest situation to analyze in a dynamic scene.

This is the first frame of the video:
![plot](./images/first_frame.jpg "First frame of the video")

**Methods for defining ROI**
We define the Region Of Interest for this video as the region in which will appear only the cars.

There are many different methods for this to happen. The three main categories are these:
1) frame differencing
2) background update
3) virtual loop

In this project I use a method from the 1st and a method from the 2nd category.

**First method: Inter-frame Difference Method**

Convert RGB image to Grayscale. 

Then calculate for each pixel the absolute difference between the current value and the value of the next frame. 

If this value is greater than a threshold, T, that we define then there is possibly a moving object in this region.

So, we create a binary map where the value of the pixels are equal to 1 if there is a moving object in this position, or an environment with varying brightness and 0 if there isn't.

After experimenting with different values for the threshold, I chose the value T=2.

If I work with a mask 4x4 and I calulate the sum of the absolute differences the results are even better. For this case I set the value of threshold, T=8.

One more way to avoid choosing an unwanted region is to see the video and define the area in which I want to run this algorithm. So I can set an offset for the values (x,y) of the image by watching the first and the last frame of the video. The region I end up with is the following: [298:480, 183:704].

For this process I built the function FrameDifferencingMask.m which works with blocks of pixels 4x4.

This is the 50th frame for the Inter-frame Difference Method block by block:
![plot](./images/ROI_for_frameNo50_block_by_block.jpg "50th frame block by block difference")

I also built the function FrameDifferencing.m which works pixel by pixel.

This is the 50th frame for the Inter-frame Difference Method pixel by pixel:
![plot](./images/ROI_for_frameNo50_pixel_by_pixel.jpg "50th frame pixel by pixel difference")

The advantage of this technique is not the precision, but the low computing cost.

**Second method: Frame Average Method**






