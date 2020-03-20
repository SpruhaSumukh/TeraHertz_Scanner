    % MSE & PSNR for a grayscale image (cameraman.tif) & its filtered
    % version

    im=imread('plate.jpg');
    im=im2double(im);
        im=rgb2gray(im);
        im = imresize(im, [x y]);
%     h1=1/9*ones(3,3);
%     imf1=imfilter(im,h1,'replicate');
%     h2=1/25*ones(5,5);
%     imf2=imfilter(im,h2,'replicate');
%     %
    imf1 = Gmag1;
    imf2 = Gmag2;
    MSE1=mean(mean((im-imf1).^2));
    MSE2=mean(mean((im-imf2).^2));
    MaxI=1;% the maximum possible pixel value of the images.
    PSNR1=10*log10((MaxI^2)/MSE1);
    PSNR2=10*log10((MaxI^2)/MSE2);