function [image_impulse] = SaltAndPepper(image,p)

% p = percentage of impalse noise
image_impulse = image;
impulse = rand(size(image)); % random pixels [0:1]
d = find(impulse < p/2);       % find pixels with value < p/2  
image_impulse(d) = 0 ;      % minimum noise
d = find(impulse >= p/2 & impulse < p); % find pixels with value >= p/2 and < p
image_impulse(d) = 255;   % maximum noise
end
