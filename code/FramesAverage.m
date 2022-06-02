function [ROI_mask,frames_roi] = FramesAverage(frames,Threshold)

%% RGB to Grayscale Frames
frames_gray = zeros(480,704,300); % initialize

for i = 1:300
    frames_gray(:,:,i) = uint8(rgb2gray(frames(:,:,:,i)));
end

%% find average of frames (per 5 frames)

average = zeros(480,704,60); % initialize

for i = 1:480
    for j = 1:704
        for k = 1:5:300-4
            average(i,j,((k-1)/5)+1) = sum(frames_gray(i,j,k:(k+4)))/5;
        end
    end
end

%% ROI mask

ROI_mask = zeros(480,704,300); % initialize
pointer = 1;

for k = 1:300
    for i = 1:480
        for j = 1:704
            if i <298 || j<183  % limits for (x,y) from the 1st and last frame 
                ROI_mask(i,j,k) = 0;
            else
                diff = abs(frames_gray(i,j,k)-average(i,j,pointer));
                if diff<Threshold
                    ROI_mask(i,j,k) = 0;
                else
                    ROI_mask(i,j,k) = 1;
                end
            end
        end
    end
    % every 5 frames: pointer = pointer + 1
    if mod(k,5)==0
        pointer = pointer + 1;
    end
end

%% pointwise multiplication of the mask with the original frames in RGB
frames_roi = frames; % initialize

for i = 1:300
    frames_roi(:,:,:,i) = frames(:,:,:,i).*uint8(ROI_mask(:,:,i));
end
end
