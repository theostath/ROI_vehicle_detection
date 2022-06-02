function [final_clock_moving] = MovingAverageFilter(clock)

% zero padding
[x, y] = size(clock); % diastasteis eikonas

padd = floor(3/2); % opou 3 to megethos tou parathyrou

clock_moving = zeros(x+2*padd,y+2*padd);

for i = padd+1:padd+x
    for j = padd+1:padd+y
        clock_moving(i,j) = clock(i-padd,j-padd);
    end
end

M = zeros(1,9); % maska 3x3

final_clock_moving = clock; %arxikopoihsh

% ypologismos timwn
for i = padd+1:padd+x
    for j = padd+1:padd+y
        % 1h grammh
        M(1) = clock_moving(i-1,j-1);
        M(2) = clock_moving(i-1,j);
        M(3) = clock_moving(i-1,j+1);
        % 2h grammh
        M(4) = clock_moving(i,j-1);
        M(5) = clock_moving(i,j);
        M(6) = clock_moving(i,j+1);
        %3h grammh
        M(7) = clock_moving(i+1,j-1);
        M(8) = clock_moving(i+1,j);
        M(9) = clock_moving(i+1,j+1);
        % athroisma
        sum = M(1)+M(2)+M(3)+M(4)+M(5)+M(6)+M(7)+M(8)+M(9);
        final_clock_moving(i-padd,j-padd) = uint8(sum/(3*3)); % arithmitikos mesos
    end
end
end