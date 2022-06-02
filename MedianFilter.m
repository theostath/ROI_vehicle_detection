function [final_clock_median] = MedianFilter(clock)

% zero padding
[x, y] = size(clock); % diastasteis eikonas

padd = floor(3/2); % opou 3 to megethos tou parathyrou

clock_median = zeros(x+2*padd,y+2*padd);

for i = padd+1:padd+x
    for j = padd+1:padd+y
        clock_median(i,j) = clock(i-padd,j-padd);
    end
end

Med = zeros(1,9); % maska 3x3

final_clock_median = clock; %arxikopoihsh

% ypologismos timwn
for i = padd+1:padd+x
    for j = padd+1:padd+y
        % 1h grammh
        Med(1) = clock_median(i-1,j-1);
        Med(2) = clock_median(i-1,j);
        Med(3) = clock_median(i-1,j+1);
        % 2h grammh
        Med(4) = clock_median(i,j-1);
        Med(5) = clock_median(i,j);
        Med(6) = clock_median(i,j+1);
        %3h grammh
        Med(7) = clock_median(i+1,j-1);
        Med(8) = clock_median(i+1,j);
        Med(9) = clock_median(i+1,j+1);
        % the sorted neighbourhood matrix
        SortMed = sort(Med);
        %the new intensity of pixel at (i,j) will be median of this
        %matrix
        final_clock_median(i-padd,j-padd) = SortMed(5);
    end
end
end