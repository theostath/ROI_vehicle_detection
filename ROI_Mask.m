function mask = ROI_Mask(Image1,Image2,Threshold)

% zero padding
M = size(Image1,1);
N = size(Image1,2); 

padd = 4;

Image1_padded = zeros(M+padd,N+padd);
Image2_padded = zeros(M+padd,N+padd);

for i = 1:M
    for j = 1:N
        Image1_padded(i,j) = Image1(i,j);
        Image2_padded(i,j) = Image2(i,j);
    end
end

% block by block substraction
mask = zeros(M,N);

% ftiaxnw maskes 4x4 kai ypologizw to apolyto ths diaforas se afta
for i = 1:480
    for j = 1:704
        if i <298 || j<183  % ta oria pou ethesa apo 1o kai teleftaio frame 
            mask(i,j) = 0;
        else
            frame_diff = sum(sum(abs(Image1_padded(i:i+4,j:j+4)-Image2_padded(i:i+4,j:j+4))));
            if frame_diff>Threshold
                mask(i,j) = 1;
            else
                mask(i,j) = 0;
            end 
        end
    end
end

end