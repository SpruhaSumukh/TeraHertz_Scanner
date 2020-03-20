function mssim=getMSSIM(frameReference,frameUnderTest, test)
im2=frameReference;
im=frameUnderTest;
% im=imread('plate1.jpg');
% im2=imread('plate.jpg');
        [x,y, z] = size(im2);
        im = imresize(im, [x y]);
img1 = double(im);
img2 = double(im2);
[M N] = size(im);
   window = fspecial('gaussian', [M N], 1.5);	%
   K(1) = 0.01;					% default settings
   K(2) = 0.03;					%
   L = 255;                                     %
% automatic downsampling
f = max(1,round(min(M,N)/32));
%downsampling by f
%use a simple low-pass filter 
if(f>1)
    lpf = ones(f,f);
    lpf = lpf/sum(lpf(:));
    img1 = imfilter(img1,lpf,'symmetric','same');
    img2 = imfilter(img2,lpf,'symmetric','same');

    img1 = img1(1:f:end,1:f:end);
    img2 = img2(1:f:end,1:f:end);
end

C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;
window = window/sum(sum(window));
img1 = double(im);
img2 = double(im2);
mu1   = filter2(window, img1, 'same');
mu2   = filter2(window, img2, 'same');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, img1.*img1, 'same') - mu1_sq;
sigma2_sq = filter2(window, img2.*img2, 'same') - mu2_sq;
sigma12 = filter2(window, img1.*img2, 'same') - mu1_mu2;

if (C1 > 0 && C2 > 0)
   ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
else
   numerator1 = 2*mu1_mu2 + C1;
   numerator2 = 2*sigma12 + C2;
	denominator1 = mu1_sq + mu2_sq + C1;
   denominator2 = sigma1_sq + sigma2_sq + C2;
   ssim_map = ones(size(mu1));
   index = (denominator1.*denominator2 > 0);
   ssim_map(index) = (numerator1(index).*numerator2(index))./(denominator1(index).*denominator2(index));
   index = (denominator1 ~= 0) & (denominator2 == 0);
   ssim_map(index) = numerator1(index)./denominator1(index);
end

mssim = mean(ssim_map(:));

% end





if(test=='1')
    mssim = max(ssim_map(:)) + (min(ssim_map(:))/1.5) - 0.03;
end
end