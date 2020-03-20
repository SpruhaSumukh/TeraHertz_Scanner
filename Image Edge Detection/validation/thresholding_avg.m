function [ im_thresh ] = thresholding_avg( image )
%THRESHOLDING_AVG Summary of this function goes here
image_norm = image/max(image(:));
[x,y] = size(image);
sum = zeros(x,y);
for o = 1: x
    for n = 1:y
        img_avg(o, n) = image_norm(o, n) + sum(o, n);
        sum(o, n) = img_avg(o, n);
    end
end
thresh = img_avg/x/y;
im_thresh = imbinarize(image, thresh)

end

