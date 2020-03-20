% close all
% clear all
% data = imread('plate1.jpg');
data = imread('Bottlesimple.jpg');
% data = imread('plier_in_box.jpg');
% data = imread('wrench2.jpg');
% data = imread('wrench1.jpg');
% data = imread('scissor1.jpg');
% data = imread('Bottle_under_Towel.jpg');
% data = imread('Bottle_under_paper.jpg');


% data = imread('plate1.jpg');
% data = imread('Bottle_under_Towel.jpg');
[x,y, z] = size(data);
add_image = 0;
for j = 1:x
    for k = 1:y
        for i = 1:z
             compute_whole_image(j, k) = data(j, k, i)+add_image;
             add_image = compute_whole_image(j, k)/z;
        end
    end
end



% figure(1),imshow(compute_whole_image);

[Gmag1,Gdir1] = imgradient(compute_whole_image);
% figure(2),imshow(Gmag1, []);
% figure(3),imshow(Gdir, []);

level = multithresh(compute_whole_image);
% Segment the image into two regions using imquantize , specifying the threshold level returned by multithresh .

seg_compute_whole_image = imquantize(compute_whole_image,level);
% figure(4)
% imshow(seg_compute_whole_image,[])


%Correction in image w.r.t. neighbourhood with 2 nearest neighbours
adjusted_image_2 = nearest_neighbourhood(seg_compute_whole_image, 2); 

% figure(5),imshow(adjusted_image_2, []);


%Correction in image w.r.t. neighbourhood with 2 nearest neighbours
adjusted_image_3_3 = rms_with_nn(seg_compute_whole_image, 3); 
adjusted_image_3_1 = rms_with_nn(seg_compute_whole_image, 1); 
adjusted_image_3_2 = rms_with_nn(seg_compute_whole_image, 2); 
adjusted_image_3_4 = rms_with_nn(seg_compute_whole_image, 4); 
adjusted_image_3_5 = rms_with_nn(seg_compute_whole_image, 5); 
adjusted_image_3_6 = rms_with_nn(seg_compute_whole_image, 6); 
adjusted_image_3_7 = rms_with_nn(seg_compute_whole_image, 7); 
adjusted_image_3_8 = rms_with_nn(seg_compute_whole_image, 8); 
adjusted_image_3_9 = rms_with_nn(seg_compute_whole_image, 9); 
adjusted_image_3_10 = rms_with_nn(seg_compute_whole_image, 10); 

figure(6),subplot(2,5,1),imshow(adjusted_image_3_1, []), title('NN = 1');
subplot(2,5,2),imshow(adjusted_image_3_2, []), title('NN = 2');
subplot(2,5,3),imshow(adjusted_image_3_3, []), title('NN = 3');
subplot(2,5,4),imshow(adjusted_image_3_4, []), title('NN = 4');
subplot(2,5,5),imshow(adjusted_image_3_5, []), title('NN = 5');
subplot(2,5,6),imshow(adjusted_image_3_6, []), title('NN = 6');
subplot(2,5,7),imshow(adjusted_image_3_7, []), title('NN = 7');
subplot(2,5,8),imshow(adjusted_image_3_8, []), title('NN = 8');
subplot(2,5,9),imshow(adjusted_image_3_9, []), title('NN = 9');
subplot(2,5,10),imshow(adjusted_image_3_10, []), title('NN = 10');


%Correction in image w.r.t. neighbourhood with 3 nearest neighbours
adjusted_image_4 = combinations_for_nn(seg_compute_whole_image, 4); 
% figure(7),imshow(adjusted_image_4/max(adjusted_image_4(:)));


adjusted_image_5 = avg_with_nn(seg_compute_whole_image, 4); 
% figure(8),imshow(adjusted_image_5/max(adjusted_image_5(:)));


adjusted_image_6 = rms_with_nn(adjusted_image_5, 2); 
% figure(9),imshow(adjusted_image_6/max(adjusted_image_6(:)));

% threshold_optimized1 = thresholding_avg(adjusted_image_5);
% figure(10),imshow(threshold_optimized1, []);
% Thresholding
I_max=max(max(adjusted_image_5));
I_min=min(min(adjusted_image_5));
level=0.1*(I_max-I_min)+I_min;
Ibw=max(adjusted_image_5,level.*ones(size(adjusted_image_5)));
% figure(10),imshow(Ibw);
% title('After Thresholding');

[Gmag2,Gdir2] = imgradient(Ibw);
% figure(11),imshow(Gmag2);
% figure(12),imshow(Gdir2);
% 
% adjusted_image_7 = avg_with_nn(Gmag2, 2); 
% figure(8),imshow(adjusted_image_7/max(adjusted_image_7(:)));

for index = 1:x
for index_col = 1:y
if(Gmag2(index, index_col) > 0.8*((max(Gmag2(:)) - mean(Gmag2(:))))/((max(Gmag2(:)) + mean(Gmag2(:))))) %max(Gmag2(:)) - ((max(Gmag2(:)) / mean(Gmag2(:)) - 2)*mean(Gmag2(:))))
    img2(index, index_col) = 0;
else img2(index, index_col) = 255;
end
end
end
figure(15), imshow(img2)
    se = strel('square', 3);
    im3 = imdilate(img2 , se);

    im4(1:x,1:y) = zeros(x,y);
   for index = 1: x
       for index_c = 1:y
           if im3(index, index_c) == 255
               im4(index, index_c) = -1;
           else if im3(index, index_c) == 0
                   im4(index, index_c) = 254;
               end
           end
       end
   end
figure(14), imshow(im4)
% %Correction in image w.r.t. neighbourhood with 3 nearest neighbours
% adjusted_image_14 = mode_for_nn(img2, 4); 
% figure(14),imshow(imbinarize(adjusted_image_14));

BW1 = edge(compute_whole_image,'sobel');
BW2 = edge(compute_whole_image,'canny');
figure(2), imshow(BW1)
figure(3), imshow(BW2)