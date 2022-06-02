function [redMask,blackMask,SobelMask] = ColorDetection(Image,Sobel)

% xwrizw sta 3 kanalia (Red - Greeen - Blue)
redBand = Image(:,:,1,:);
greenBand = Image(:,:,2,:);
blueBand = Image(:,:,3,:);

% entopizw xrwmata
redMask = uint8((redBand >= 179) & (greenBand <= 82) & (blueBand <= 82));

blackMask = uint8((redBand <= 32) & (redBand >= 1) & (greenBand <= 32) & ...
(greenBand >= 1) & (blueBand <= 32) & (blueBand >= 1) );

SobelMask = Sobel; % arxikopoihsh

for i = 298:480
    for j = 183:704
        for k = 1:300
            if redMask(i,j,1,k) > 0  
                SobelMask(i,j,k) = 255;
            end
            if blackMask(i,j,k) > 0  
                SobelMask(i,j,k) = 255;
            end
        end
    end
end
end