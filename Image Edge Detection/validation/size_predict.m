data = imread('Bottlesimple.jpg');


[x,y, z] = size(data);
% im4 = im4;

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
% 
% figure(6),subplot(2,5,1),imshow(adjusted_image_3_1, []), title('NN = 1');
% subplot(2,5,2),imshow(adjusted_image_3_2, []), title('NN = 2');
% subplot(2,5,3),imshow(adjusted_image_3_3, []), title('NN = 3');
% subplot(2,5,4),imshow(adjusted_image_3_4, []), title('NN = 4');
% subplot(2,5,5),imshow(adjusted_image_3_5, []), title('NN = 5');
% subplot(2,5,6),imshow(adjusted_image_3_6, []), title('NN = 6');
% subplot(2,5,7),imshow(adjusted_image_3_7, []), title('NN = 7');
% subplot(2,5,8),imshow(adjusted_image_3_8, []), title('NN = 8');
% subplot(2,5,9),imshow(adjusted_image_3_9, []), title('NN = 9');
% subplot(2,5,10),imshow(adjusted_image_3_10, []), title('NN = 10');


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
% figure(15), imshow(img2)
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
% figure(14), imshow(im4)


% size prediction code start 

for s_x = 1:x
    for s_y = 1:y
        if im4(s_x,s_y) == 254
           p1_y = s_x;           
           p1_x = s_y;   
        s_x = x;
        s_y = y;
        end
    end
end

for s_y = 1:y
    for s_x = 1:x
        if im4(s_x,s_y) == 254
           p2_y = s_x;           
           p2_x = s_y;   
        s_x = x;
        s_y = y;
        end
    end
end

for e_y = y:-1:1
    for e_x = x:-1:1
        if im4(e_x,e_y) == 254
           p3_y = e_x;           
           p3_x = e_y;   
        e_x = 1;
        e_y = 1;
        end
    end
end


for e_x = x:-1:1
    for e_y = y:-1:1
        if im4(e_x,e_y) == 254
           p4_y = e_x;           
           p4_x = e_y;   
        e_x = 1;
        e_y = 1;
        end
    end
end
% h = drawpolygon('FaceAlpha',0);
figure(1), 
subplot(1,3,1), imshow('Bottlesimple.jpg');
subplot(1,3,2), imshow(im4);

subplot(1,3,3), imshow(im4)
my_vertices = [p1_x p1_y;p2_x p2_y;p4_x p4_y;p3_x p3_y];
h = impoly(gca,my_vertices);
addNewPositionCallback(h,@(p) title(mat2str(p,3)));
fcn = makeConstrainToRectFcn('impoly',get(gca,'XLim'),...
    get(gca,'YLim'));
setPositionConstraintFcn(h,fcn);

Xv = my_vertices(:,1);
Yv = my_vertices(:,2);
obj_area = polyarea(Xv,Yv);

Xo = [1,1,x,x]
Yo = [1,y,y,1]

Total_area = polyarea(Xo,Yo);

percentage = obj_area/Total_area * 100

X1 = [p2_x p2_y;p4_x p4_y];
dx1 = pdist(X1,'euclidean');
X2 = [p1_x p1_y;;p3_x p3_y];
dx2 = pdist(X2,'euclidean');
dx = (dx1+dx2)/2;

length = dx/sqrt(x^2+y^2)*34

Y1 = [p1_x p1_y;p2_x p2_y];
dy1 = pdist(Y1,'euclidean');
Y2 = [p3_x p3_y;p4_x p4_y];
dy2 = pdist(Y2,'euclidean');
dy = (dy1+dy2)/2;

width = dy/sqrt(x^2+y^2)*22

[icondata,iconcmap] = imread('Bottlesimple.jpg'); 
h=msgbox(strcat('Scan has detected an object with width = ', num2str(width), 'and length =' , num2str(length), '. The Total area showing low intensity in the scan is = ', num2str(percentage), '%'), 'Success','custom',icondata,iconcmap);