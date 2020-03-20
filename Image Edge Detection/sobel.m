%%https://www.quora.com/I-want-MATLAB-code-to-detect-edges-in-eye-using-sobel-edge-detection

%%http://deepeshrawat987.blogspot.com/2013/04/edge-detection.html
% close all;
% clc;
% img=adjusted_image_5;
% B=rgb2gray(img);
% subplot(2,2,1)
% imshow(B)
% pause(2)
I=double(adjusted_image_5);

for i=1:size(I,1)-2
for j=1:size(I,2)-2
%Sobel mask for x-direction:
mx=((2*I(i+2,j+1)+I(i+2,j)+I(i+2,j+2))-(2*I(i,j+1)+I(i,j)+I(i,j+2)));
%Sobel mask for y-direction:
my=((2*I(i+1,j+2)+I(i,j+2)+I(i+2,j+2))-(2*I(i+1,j)+I(i,j)+I(i+2,j)));

B(i,j)=sqrt(mx.^2+my.^2);
end
end
subplot(2,2,2)
imshow(B); title('Sobel gradient');
pause(2)
%Define a threshold value


Thresh=10;
B_max=max(B,Thresh);
B(B_max==round(Thresh))=0;
B_max=uint8(B);

subplot(2,2,3)
imshow(~B_max);title('Edge detected Image');