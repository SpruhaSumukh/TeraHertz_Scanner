%demo
im=rgb2gray(imread('plate.jpg'));

% im=rgb2gray(imread('bottle_original.jpg'));
% image1=im2;
% image1=median_image;
image2=im3;

[mse_original, psnr_original]=getPSNR(im,Gmag1);
ssim_original=getMSSIM(im,Gmag1, '1');
fprintf('mse_original = %f PSNR original= %f and SSIM original= %f\n',mse_original, psnr_original,ssim_original);

[mse_new, psnr_new]=getPSNR(im,image2);
ssim_new=getMSSIM(im,image2, '2');
fprintf('mse_new = %f PSNR improved= %f and SSIM improved= %f\n',mse_new, psnr_new,ssim_new);
matrix  = [mse_original,psnr_original,ssim_original;mse_new,psnr_new,ssim_new];
csvwrite('vamatrixlues.csv', matrix);