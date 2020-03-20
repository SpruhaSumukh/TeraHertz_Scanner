clc

% Read the video file from ‘save video’ location on the system

   p=VideoReader('D:\EXTC\Second year\Project Code\demo2\scan1.avi');
   
% Count the total number of frames (b) and choose an interval m to pick 60 equally spaced images : m = b/60
   
b = p.NumberOfFrames
m = (int16((b)/20))+10
a=1;
% From t = 1 to total number of frames b, read only the frames that appear after given interval 
% and store in desired folder naming them in ascending order   
for t= 70: m :b
    c = read(p,t);
    outputBaseFileName = sprintf('%d.png', a);
    outputFullFileName = fullfile('D:\EXTC\Second year\Project Code\demo2', outputBaseFileName);
     f = imrotate(c,90);
%          e = imcrop(f, [14,14,100,100]);
    imwrite(f, outputFullFileName, 'png');
    
    a = a+1;
    
end
%
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\7.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\14.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\21.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\28.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\35.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\42.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\49.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\56.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\63.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\70.png');
%    delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\77.png');
% delete('D:\Triveni\MATLAB IMAGE PROCESSING\Programs\Alternate Precise\workingDir2\images_2\67.png');

   
   %Read all files under 'filenames'
   folder = fullfile('D:\EXTC\Second year\Project Code\demo2');
   dirOutput = dir(fullfile(folder,'*.png'))
   filenames = {dirOutput.name}';
   
%    match any file names that contain a sequence of numeric digits. Convert the strings to doubles.
imageStrings = regexp([filenames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);
%    Sort the frame numbers from lowest to highest

    [~,sortedIndices] = sort(imageNumbers, 'ascend');
sortedImageNames = filenames(sortedIndices)


%  Create figure by using 6 x 10 montage command to stitch the images in desired order
%  figure(1)
%  montage(sortedImageNames, 'Size', [9 4], 'Indices', [1:1:4, 8:-1:5,9:1:12, 16:-1:13 , 17:1:20, 24: -1:21, 25: 1 : 28, 32: -1 : 29, 33: 1: 36]);
%  montage(sortedImageNames, 'Size', [11 6], 'Indices', [1:1:6, 12:-1:7,13:1:18, 24:-1:19 , 25:1:30, 36: -1:31, 37: 1 : 42, 48: -1 : 43, 49: 1: 54, 60:-1:55, 61:1:65]);


%For inverted set up, as camera direction has changed
%  montage(sortedImageNames, 'Size', [4 5], 'Indices', [5:-1:1, 6:1:10, 15:-1:11, 16:1:20]);
 montage(sortedImageNames, 'Size', [4 5], 'Indices', [1:1:5, 10:-1:6, 11:1:15, 20:-1:16]);
stitch_image = imrotate(figure(1), 180); 
%Save image
saveas(stitch_image,'D:\EXTC\Second year\Project Code\demo2\trial.jpg');





figure(1)
imshow('bottlesimple.jpg')
