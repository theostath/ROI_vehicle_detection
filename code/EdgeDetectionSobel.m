function Out = EdgeDetectionSobel(image)

% Sobel mask for edge detection 
SobelX = [-1 0 1; -2 0 2; -1 0 1];
SobelY = [-1 -2 -1; 0 0 0; 1 2 1];

% gradient and magnitude
ImageX = conv2(image, SobelX);
ImageY = conv2(image, SobelY);

Magnitude = sqrt((ImageX).^2 + abs(ImageY).^2);
% krataw ta aparaithta pixel
Out = Magnitude(2:size(Magnitude,1)-1,2:size(Magnitude,2)-1); 
end