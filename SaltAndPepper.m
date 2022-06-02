function [image_impulse] = SaltAndPepper(image,p)

% p = pososto kroustikou thorivou
image_impulse = image;
impulse = rand(size(image)); % random pixels [0:1]
d = find(impulse < p/2);       % vriskw pixels me times < p/2  
image_impulse(d) = 0 ;      % minimum noise
d = find(impulse >= p/2 & impulse < p); % vriskw pixels me times >= p/2 kai < p
image_impulse(d) = 255;   % maximum noise
end