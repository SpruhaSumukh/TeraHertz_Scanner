function [mse, psnr]=getPSNR(frameReference,frameUnderTest)
%Written by: Mahmoud Afifi ~ Assiut University, Egypt
% im=imread('plate.jpg');
% im2=imread('plate1.jpg');
% im=imread('bottle_original.jpg');
% im2=imread('Bottlesimple.jpg');
frameReference = double(frameReference);
frameUnderTest = double(frameUnderTest);
% frameReference = im;
% frameUnderTest = im2;
        [x,y, z] = size(frameReference);
        frameUnderTest = imresize(frameUnderTest, [x y]);
        
        
s1=double((frameReference-frameUnderTest)/frameReference).^2;
    
    s = sum(sum(s1)); 
    sse = s; %(:,:,1)+s(:,:,2)+s(:,:,3);
    if( sse <= 1e-10) 
        psnr=0;
    else
        mse  = sse /(double(size(frameReference,1)*size(frameReference,2)))/100;
        psnr = 10.0 * log10((x * y) / mse);
    end
end
