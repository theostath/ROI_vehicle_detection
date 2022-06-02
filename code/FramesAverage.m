function [ROI_mask,frames_roi] = FramesAverage(frames,Threshold)

%% RGB to Grayscale Frames
frames_gray = zeros(480,704,300); % arxikopoihsh

for i = 1:300
    frames_gray(:,:,i) = uint8(rgb2gray(frames(:,:,:,i)));
end

%% find average of frames (per 5 frames)

average = zeros(480,704,60); % arxikopoihsh

for i = 1:480
    for j = 1:704
        for k = 1:5:300-4
            average(i,j,((k-1)/5)+1) = sum(frames_gray(i,j,k:(k+4)))/5;
        end
    end
end

%% ROI mask

ROI_mask = zeros(480,704,300); %arxikopoihsh
pointer = 1;

for k = 1:300
    for i = 1:480
        for j = 1:704
            if i <298 || j<183  % ta oria pou ethesa apo 1o kai teleftaio frame 
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
    % kathe 5 frames pointer = pointer + 1
    if mod(k,5)==0
        pointer = pointer + 1;
    end
end

%% pointwise pollaplasiasmos ths maskas me ta arxika frames se RGB
frames_roi = frames; %arxikopoihsh

for i = 1:300
    frames_roi(:,:,:,i) = frames(:,:,:,i).*uint8(ROI_mask(:,:,i));
end
end