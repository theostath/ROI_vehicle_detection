function mask = ROI_Mask1(Image1,Image2,Threshold)
% pixel by pixel substraction

mask = zeros(480,704);

for i = 1:480
    for j = 1:704
        if i <298 || j<183  % the limits i defined from the 1st and last frames 
            mask(i,j) = 0;
        else
            frame_diff = abs(Image1(i,j)-Image2(i,j));
            if frame_diff>Threshold
                mask(i,j) = 1;
            else
                mask(i,j) = 0;
            end 
        end
    end
end
end
