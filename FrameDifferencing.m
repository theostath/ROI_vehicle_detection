function [ROI_mask,frames_roi] = FrameDifferencing(frames,Threshold)

%% RGB to Grayscale Frames
gray_frames = zeros(480,704,300); % arxikopoihsh

for i = 1:300
    gray_frames(:,:,i) = uint8(rgb2gray(frames(:,:,:,i)));
end

%% Create ROI mask trhough Frame Differencing technique (Backgound Subtraction)

ROI_mask = zeros(480,704,300); % arxikopoihsh

for i = 1:300
    if i == 300 % eidikh periptwsh gia to teleutaio frame pou den exei epomeno
        ROI_mask(:,:,i) = ROI_Mask1(gray_frames(:,:,i-1),gray_frames(:,:,i),Threshold);
    else
        ROI_mask(:,:,i) = ROI_Mask1(gray_frames(:,:,i),gray_frames(:,:,i+1),Threshold);
    end
end

%% pointwise pollaplasiasmos ths maskas me ta arxika frames se RGB

frames_roi = frames; %arxikopoihsh

for i = 1:300
    frames_roi(:,:,:,i) = frames(:,:,:,i).*uint8(ROI_mask(:,:,i));
end
end