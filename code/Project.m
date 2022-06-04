% date: 08/07/2019
% name: Stathakopoulos Thodoris
% AM: 1047043

%% 1. ROI SELECTION 

%% Read Video plus Information

file = VideoReader('april21.avi');

%% Read Frames

frames = read(VideoReader('april21.avi'));

figure(1);
imshow(frames(:,:,:,1));
title('First frame of the video');

figure(2);
imshow(frames(:,:,:,300));
title('Last frame of the video');

%% 1st ROI technique: Frame differencing (block by block)

[ROI_mask,frames_ROI] = FrameDifferencingMask(frames,8); %Theshold = 8

figure(3);
imshow(ROI_mask(:,:,1));
title('ROI mask for the first frame');

figure(4);
imshow(frames_ROI(:,:,:,50));
title('ROI for frame No 50');

%% 1st ROI technique: Frame differencing (pixel by pixel)

[ROI_mask1,frames_ROI1] = FrameDifferencing(frames,2); %Theshold = 2

figure(5);
imshow(ROI_mask1(:,:,1));
title('ROI mask for the first frame');

figure(6);
imshow(frames_ROI1(:,:,:,50));
title('ROI for frame No 50');                

%% export video 

video = VideoWriter('FrameDifferencing.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,frames_ROI1(:,:,:,ii)); %write the image to file
end
close(video); %close the file

%% 2nd ROI technique: Frames Average

[ROI_mask2,frames_ROI2] = FramesAverage(frames,10); %Threshold = 10

figure(7);
imshow(ROI_mask2(:,:,1));
title('ROI mask for the first frame');

figure(8);
imshow(frames_ROI2(:,:,:,50));
title('ROI for frame No 50');

%% export video 

video = VideoWriter('FramesAverage.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,frames_ROI2(:,:,:,ii)); %write the image to file
end
close(video); %close the file

%% 2a. NOISE GENERATION

%% AWGN

% AWGN
mean = 0;
variance = 5500;
gaussian = uint8(sqrt(variance)*randn(size(frames(:,:,:,1))) + mean); 

frames_gaussian  = (frames + gaussian);

figure(9);
subplot(2,2,1);
imshow(frames(:,:,:,1));
title('Frame No 1');
subplot(2,2,2);
imshow(frames(:,:,:,150));
title('Frame No 150');
subplot(2,2,3);
imshow(frames_gaussian(:,:,:,1));
title('Frame No 1 (AWGN)');
subplot(2,2,4);
imshow(frames_gaussian(:,:,:,150));
title('Frame No 150 (AWGN)');

%% 1st ROI technique: Frame differencing 

[ROI_mask1_gaussian1,frames_ROI1_gaussian1] = FrameDifferencing(frames_gaussian,2); %Theshold = 2

figure(10);
imshow(ROI_mask1_gaussian1(:,:,1));
title('ROI mask for the first frame');

figure(11);
imshow(frames_ROI1_gaussian1(:,:,:,150));
title('ROI for frame No 150');

%% 1st ROI technique: Frame differencing 

[ROI_mask1_gaussian2,frames_ROI1_gaussian2] = FrameDifferencing(frames_gaussian,7); %Theshold = 7

figure(12);
imshow(ROI_mask1_gaussian2(:,:,1));
title('ROI mask for the first frame');

figure(13);
imshow(frames_ROI1_gaussian2(:,:,:,150));
title('ROI for frame No 150');

%% 2nd ROI technique: Frames Average

[ROI_mask2_gaussian,frames_ROI2_gaussian] = FramesAverage(frames_gaussian,10); %Theshold = 10

figure(14);
imshow(ROI_mask2_gaussian(:,:,1));
title('ROI mask for the first frame');

figure(15);
imshow(frames_ROI2_gaussian(:,:,:,150));
title('ROI for frame No 150');

%% Impulse Noise

p = 0.2;
frames_impulse = SaltAndPepper(frames,p);

figure(16);
subplot(2,2,1);
imshow(frames(:,:,:,1));
title('Frame No 1');
subplot(2,2,2);
imshow(frames(:,:,:,150));
title('Frame No 150');
subplot(2,2,3);
imshow(frames_impulse(:,:,:,1));
title('Frame No 1 (impulse noise)');
subplot(2,2,4);
imshow(frames_impulse(:,:,:,150));
title('Frame No 150 (impulse noise)');

%% 1st ROI technique: Frame differencing 

[ROI_mask1_impulse,frames_ROI1_impulse] = FrameDifferencing(frames_impulse,2); %Theshold = 2

figure(17);
imshow(ROI_mask1_impulse(:,:,1));
title('ROI mask for the first frame');

figure(18);
imshow(frames_ROI1_impulse(:,:,:,150));
title('ROI for frame No 150');

%% 2nd ROI technique: Frames Average 

[ROI_mask2_impulse,frames_ROI2_impulse] = FramesAverage(frames_impulse,10); %Theshold = 10

figure(19);
imshow(ROI_mask2_impulse(:,:,1));
title('ROI mask for the first frame');

figure(20);
imshow(frames_ROI2_impulse(:,:,:,150));
title('ROI for frame No 150');

%% 2b. DENOISING

%% Removing AWGN 

frames_moving = frames_gaussian; % initialize

for i = 1:300
    for k = 1:3
        frames_moving(:,:,k,i) = MovingAverageFilter(frames_gaussian(:,:,k,i));
    end
end

figure(21);
subplot(2,2,1);
imshow(frames_gaussian(:,:,:,1));
title('Frame No 1 (AWGN)');
subplot(2,2,2);
imshow(frames_gaussian(:,:,:,150));
title('Frame No 150 (AWGN)');
subplot(2,2,3);
imshow(frames_moving(:,:,:,1));
title('Frame No 1 after denoising');
subplot(2,2,4);
imshow(frames_moving(:,:,:,150));
title('Frame No 150 after denoising');

%% Mean Square Error before - after 

mse1 = MeanSquareError(frames(:,:,:,1),frames_gaussian(:,:,:,1));
mse2 = MeanSquareError(frames(:,:,:,1),frames_moving(:,:,:,1));

%% 1st ROI technique: Frame differencing 

[ROI_mask1_moving,frames_ROI1_moving] = FrameDifferencing(frames_moving,2); %Theshold = 2

figure(22);
imshow(ROI_mask1_moving(:,:,1));
title('ROI mask for the first frame');

figure(23);
imshow(frames_ROI1_moving(:,:,:,150));
title('ROI for frame No 150');

%% 2nd ROI technique: Frames Average 

[ROI_mask2_moving1,frames_ROI2_moving1] = FramesAverage(frames_moving,10); %Theshold = 10

figure(24);
imshow(ROI_mask2_moving1(:,:,1));
title('ROI mask for the first frame');

figure(25);
imshow(frames_ROI2_moving1(:,:,:,150));
title('ROI for frame No 150');

%% 2nd ROI technique: Frames Average 

[ROI_mask2_moving2,frames_ROI2_moving2] = FramesAverage(frames_moving,7); %Theshold = 7

figure(26);
imshow(ROI_mask2_moving2(:,:,1));
title('ROI mask for the first frame');

figure(27);
imshow(frames_ROI2_moving2(:,:,:,150));
title('ROI for frame No 150');

%% Removing Impulse Noise

frames_median = frames_impulse; % initialize

for i = 1:300
    for k = 1:3
        frames_median(:,:,k,i) = uint8(MedianFilter(frames_impulse(:,:,k,i)));
    end
end

figure(28);
subplot(2,2,1);
imshow(frames_impulse(:,:,:,1));
title('Frame No 1 (impulse noise)');
subplot(2,2,2);
imshow(frames_impulse(:,:,:,150));
title('Frame No 150 (impulse noise)');
subplot(2,2,3);
imshow(frames_median(:,:,:,1));
title('Frame No 1 after denoising');
subplot(2,2,4);
imshow(frames_median(:,:,:,150));
title('Frame No 150 after denoising');

%% Mean Square Error before - after 

mse3 = MeanSquareError(frames(:,:,:,1),frames_impulse(:,:,:,1));
mse4 = MeanSquareError(frames(:,:,:,1),frames_median(:,:,:,1));

%% 1st ROI technique: Frame differencing 

[ROI_mask1_median,frames_ROI1_median] = FrameDifferencing(frames_median,2); %Theshold = 2

figure(29);
imshow(ROI_mask1_median(:,:,1));
title('ROI mask for the first frame');

figure(30);
imshow(frames_ROI1_median(:,:,:,150));
title('ROI for frame No 150');

%% 1st ROI technique: Frame differencing 

[ROI_mask1_median2,frames_ROI1_median2] = FrameDifferencing(frames_median,5); %Theshold = 5

figure(31);
imshow(ROI_mask1_median2(:,:,1));
title('ROI mask for the first frame');

figure(32);
imshow(frames_ROI1_median2(:,:,:,150));
title('ROI for frame No 150');

%% 2nd ROI technique: Frames Average 

[ROI_mask2_median,frames_ROI2_median] = FramesAverage(frames_median,10); %Theshold = 10

figure(33);
imshow(ROI_mask2_median(:,:,1));
title('ROI mask for the first frame');

figure(34);
imshow(frames_ROI2_median(:,:,:,150));
title('ROI for frame No 150');

%% 3a. VEHICLE DETECTION MASK (Sobel Mask)

%% RGB to Grayscale Frames

frames_gray = zeros(480,704,300); % arxikopoihsh

for i = 1:300
    frames_gray(:,:,i) = uint8(rgb2gray(frames(:,:,:,i)));
end

%% Edge Detection: Sobel mask (Frame differencing)

frames_sobel = zeros(480,704,300);
frames_sobel1 = zeros(480,704,300);
p_sobel1 = zeros(1,300);

for i = 1:300
    frames_sobel(:,:,i) = EdgeDetectionSobel(frames_gray(:,:,i).*(ROI_mask1(:,:,i)));
    [frames_sobel1(:,:,i),p_sobel1(i)] = EdgeDetectionThreshold(frames_sobel(:,:,i),ROI_mask1(:,:,i),0.55);
end

figure(35);
plot(p_sobel1);
title('Percentage of pixels retained (Frame Differencing)');

av1 = sum(p_sobel1)/300; % mean value of the percentage of pixels retained

figure(36);
imshow(ROI_mask1(:,:,50));
title('ROI mask for frame No 50');

figure(37);
imshow(frames_sobel1(:,:,50));
title('Sobel mask for frame No 50');
                
%% export video 

video = VideoWriter('framesSobelFrameDiff.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,frames_sobel1(:,:,ii)/255); %write the image to file
end
close(video); %close the file

%% Edge Detection: Sobel mask (Frames Average)

frames_sobel2 = zeros(480,704,300);
frames_sobel12 = zeros(480,704,300);
p_sobel2 = zeros(1,300);

for i = 1:300
    frames_sobel2(:,:,i) = EdgeDetectionSobel(frames_gray(:,:,i).*(ROI_mask2(:,:,i)));
    [frames_sobel12(:,:,i),p_sobel2(i)] = EdgeDetectionThreshold(frames_sobel2(:,:,i),ROI_mask2(:,:,i),0.55);
end

figure(38);
plot(p_sobel2);
title('Pososto pixel pou krataw (Frames Average)');

av2 = sum(p_sobel2)/300; % mesos oros tou posostou pixel pou krataw

figure(39);
imshow(ROI_mask2(:,:,50));
title('ROI mask for frame No 50');

figure(40);
imshow(frames_sobel12(:,:,50));
title('Sobel mask for frame No 50');

%% export video 

video = VideoWriter('framesSobelFramesAv.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,frames_sobel12(:,:,ii)/255); %write the image to file
end
close(video); %close the file

%% 3b. VEHICLE DETECTION MASK (Color Detection)

%% Color Detection: Frame Differencing

[redMask1,blackMask1,Sobel1] = ColorDetection(frames_ROI1,frames_sobel1);

figure(41);
imshow(redMask1(:,:,50), []);
title('Is-red Mask (Frame Differencing)');

figure(42);
imshow(blackMask1(:,:,50), []);
title('Is-black Mask (Frame Differencing)');

figure(43);
imshow(Sobel1(:,:,95));
title('New vehicle detection mask for frame No 95');

%% export video 

video = VideoWriter('framesSobelFrameDiffColor.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,Sobel1(:,:,ii)/255); %write the image to file
end
close(video); %close the file

%% Color Detection: Frames Average

[redMask2,blackMask2,Sobel2] = ColorDetection(frames_ROI2,frames_sobel12);

figure(44);
imshow(redMask2(:,:,50), []);
title('Is-red Mask (Frames Average)');

figure(45);
imshow(blackMask2(:,:,50), []);
title('Is-black Mask (Frames Average)');

figure(46);
imshow(Sobel2(:,:,95));
title('New vehicle detection mask for frame No 95');

%% export video 

video = VideoWriter('framesSobelFramesAvColor.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,Sobel2(:,:,ii)/255); %write the image to file
end
close(video); %close the file

%% 3c. VEHICLE DETECTION MASK (morphological opening)

%% Morphological opening: Frame Differencing

% a tropos (den doulevei kala se afth thn periptwsh)
sedisk1 = strel('disk',2); % structuring element
noSmallStructures1 = imopen(Sobel1, sedisk1);

% b tropos (doulevei kala)
VehicleDetection1 = bwareaopen(Sobel1/255,32);

figure(47);
imshow(VehicleDetection1(:,:,95));
title('Vehicle detection mask for frame No 95');

%% export video 

video = VideoWriter('FinalVehicleDetection1.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,double(VehicleDetection1(:,:,ii))); %write the image to file
end
close(video); %close the file

%% Morphological opening: Frames Average

% a tropos (den doulevei kala se afth thn periptwsh)
sedisk2 = strel('disk',2); % structuring element
noSmallStructures = imopen(Sobel2, sedisk2);

% b tropos (doulevei kala)
VehicleDetection2 = bwareaopen(Sobel2/255,28);

figure(48);
imshow(VehicleDetection2(:,:,95));
title('Vehicle detection mask for frame No 95');

%% export video 

video = VideoWriter('FinalVehicleDetection2.avi'); %create the video object
open(video); %open the file for writing
for ii=1:300 %where N is the number of images
  %I = imread('the ith image.jpg'); %read the next image
  writeVideo(video,double(VehicleDetection2(:,:,ii))); %write the image to file
end
close(video); %close the file
