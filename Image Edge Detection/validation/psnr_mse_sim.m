    % MSE & PSNR for a grayscale image (cameraman.tif) & its filtered
    % version
im=imread('bottle_original.jpg');
im1=imread('Bottlesimple.jpg');
%         [x,y, z] = size(im2);
%         im = imresize(im, [x y]);
%     im=imread('plate.jpg');
    im=im2double(im);
        im=rgb2gray(im);
%         im1 = imread('fullplatesim.jpg');
    im1=im2double(im1);
        im1=rgb2gray(im1);
        [x,y, z] = size(im1);
        im = imresize(im, [x y]);
    MSE1=mean(mean((im-im1).^2));
    MaxI=max(max(im(:)),max(im2(:)));% the maximum possible pixel value of the images.
    PSNR1=10*log10((MaxI^2)/MSE1);


    im2=imread('plate1.jpg');
    im2=im2double(im2);
        im2=rgb2gray(im2);
    [x,y, z] = size(Gmag2);
    im1 = imresize(im1, [x y]);    
    MSE2=mean(mean((im1-im2).^2));
    MaxI=1;% the maximum possible pixel value of the images.
    PSNR2=10*log10((MaxI^2)/MSE2);
    
    im = imresize(im, [x y]);   
    MSE3=mean(mean((im-im2).^2));
    MaxI=max(max(im(:)),max(im2(:)));% the maximum possible pixel value of the images.
    PSNR3=10*log10((MaxI^2)/MSE3);
     