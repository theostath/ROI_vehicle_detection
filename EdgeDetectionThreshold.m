function [image,p] = EdgeDetectionThreshold(image,roi_mask,c)

threshold_max = max(max(image(:,:)));
threshold_min = min(min(image(:,:)));

threshold = c*(threshold_max-threshold_min)+threshold_min;

N = 0; % posa pixel eixa arxika sthn maska epiloghs ROI
sum = 0; % arithmos pixel pou krataw sthn maska Sobel
for i = 1:size(image,1)
    for j = 1:size(image,2)
        if image(i,j)>=threshold
            image(i,j) = 255;
            sum = sum + 1 ;
        else
            image(i,j) = 0;
        end
        if roi_mask(i,j)>0
            N = N+1;
        end
    end
end
p = sum/N;
end