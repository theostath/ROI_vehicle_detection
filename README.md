# ROI_vehicle_detection
Region Of Interest for automated vehicle detection in a highway.
Project for Digital Image Processing subject, Electrical and Computer Engineering department, University of Patras.
08 July 2019

# Prerequisites

Matlab 2017.

# Code

The main code is in the file code/Project.m and this is the one we need to execute. First, we need to put the original video 'april21.avi' in the same folder with Project.m or specify the path.

All the other files contain the techniques used to assist us with the task of defining a Region Of Interest in the video that is given to us.

# Report

## Input video
Read the video 'april21.avi'. This video contains information of 24 bits per pixel. The duration of the film is 10 seconds and FPS is 30. So, we have a total of 300 frames
and each frame is an RGB image of dimensions 480x704x3.

This is a Moving Camera Moving Objects (MCMO) video, which is the hardest situation to analyze in a dynamic scene.

This is the first frame of the video:

![plot](./images/first_frame.jpg "First frame of the video")

## Methods for defining ROI
We define the Region Of Interest for this video as the region in which will appear only the cars.

There are many different methods for this to happen. The three main categories are these:
1) frame differencing
2) background update
3) virtual loop

In this project I use a method from the 1st and a method from the 2nd category.

## First method: Inter-frame Difference Method

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

I also export the video with the name FrameDifferencing.avi when the code is executed.

## Second method: Frame Average Method

With this method I aim to detect the background and then substract it from each frame in order to remain with the ROI.

Convert RGB image to Grayscale. 

I calculate the average value of each pixel for 5 frames (succesively). Then I calculate the absolute difference between the value of a pixel and the average value calculated. I create a binary mask where if this value of the absolute difference is greater than a threshold, then the corresponding pixel takes the value of 1 or else the pixel takes the value of 0.

After some experimentation I choose the value T=10 for the threshold.

In this method too, to minimize the area of work I choose the region [298:480, 183:704].

For this method the function FramesAverage.m is built.

This is the 50th frame for the Frame Average Method:

![plot](./images/ROI_for_frameNo50_frames_average.jpg "50th frame for frames average method")

We can observe that ROI is mainly consisted of vehicles' contour and is smaller comparatively to the 1st method. 

The main disadvantage of this method is the inadequacy to detect stationary or low velocity vehicles.

I also export the video with the name FramesAverage.avi when the code is executed.

## Creeate Noise 

In this project we were called to create 2 different kinds of noise  e.g. Gaussian and Salt & Pepper and then use denoising techniques.

First, I generate **Gaussian** noise of mean value = 0 and variance = 5500. 

These are the 1st and 150th frames before and after applying AWGN:

![plot](./images/example_AWGN.jpg "1st and 150th frames before and after AWGN")

Afterwards, I apply the **Inter-frame Difference Method** pixel by pixel.

This is the 150th frame for the Inter-frame Difference Method pixel by pixel with AWGN:

![plot](./images/ROI_for_frameNo150_pixel_by_pixel_AWGN.jpg "150th frame pixel by pixel difference with AWGN")

We can observe an expansion of the ROI, which is unwanted. This is due to the presence of the noise. To tackle this problem we can increase the value of the threshold from T=2 to T=7.

This is the result:

![plot](./images/ROI_for_frameNo150_pixel_by_pixel_AWGN_T7.jpg "150th frame pixel by pixel difference with AWGN and T=7")

This ROI tends to look like the original with T=2 and without the noise.

Now, I apply the **Frame Average Method** with theshold T=10.

This is the 150th frame for the Frame Average Method with AWGN:

![plot](./images/ROI_for_frameNo150_frames_average_AWGN.jpg "150th frame, frames average with AWGN")

