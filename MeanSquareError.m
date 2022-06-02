function mse = MeanSquareError(Image1,Image2)

X = double(Image1);
Y = double(Image2);

error = X - Y;
mse = sum(sum(sum(error.*error))) / (704*480*3);

end