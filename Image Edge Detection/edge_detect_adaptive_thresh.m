close all
clear all
data = imread('plate1.jpg');
% data = imread('Bottlesimple.jpg');
n = 4;
[x,y, z] = size(data);
% data = imread('plier_in_box.jpg');
% data = imread('wrench2.jpg');
% data = imread('wrench1.jpg');
% data = imread('scissor1.jpg');
% data = imread('Bottle_under_Towel.jpg');
% data = imread('Bottle_under_paper.jpg');
add_image = 0;
for j = 1:x
    for k = 1:y
        for i = 1:z
             compute_whole_image(j, k) = data(j, k, i)+add_image;
             add_image = compute_whole_image(j, k)/z;
        end
    end
end

BW = compute_whole_image;


addition_image = combinations2_for_nn(BW, n);
new_im = zeros(x,y);
for n = 1:3
for x_now = 1:x
    for y_now = 1:y
        if (BW(x_now,y_now) > addition_image(x_now,y_now)/(n^2))
            new_im(x_now,y_now) = 255;
        else new_im(x_now,y_now) = 0;
        end
    end
end


    
figure(1);
    subplot(1,3,n),imshow(new_im, []), title(strcat('Mean adaptive threshold = ',num2str(n)));
end



for n = 1:3
median_image = combinations3_for_nn(BW, n);
   
figure(2);
    subplot(1,3,n),imshow(median_image, []), title(strcat('Median adaptive threshold = ',num2str(n)));
end


for n = 1:3
mm_image = combinations4_for_nn(BW, n);
   
figure(3);
    subplot(1,3,n),imshow(mm_image, []), title(strcat('Median adaptive threshold = ',num2str(n)));
end