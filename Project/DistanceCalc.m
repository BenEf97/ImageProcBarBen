function [Z,time] = DistanceCalc(LeftImage,RightImage,f,T)
%This fucnction calculates the distance of an object from a stereo camera.
%The function has 4 inputs:
%LeftImage- The left image, taken before the camera moved.
%RightImage- The right image, taken after the camera moved or a stereo
%camera has been used.
%f- The focal length of the camera. You may get the value using Matlab's Camera
%Calibration app. Computer Vision Toolbox is needed.
%T- The baseline, the distance between the 2 camera lenses. The user needs
%to determine this value.
%
%The function return Z- The distance of the object from the cameras.
% Z is calculated by this equation: Z=f*T/(xl-xr)

%Getting the left image.
Il=LeftImage;
%Getting the right image and turning it to gray.
Ir=rgb2gray(RightImage);

%Display the left image to the user, the image is colored. The user needs
%to choose a mask of the object that it's distance is wanted.
selectObj = figure();
imshow(Il);
title('Select an object by drawing a rectangle');
%Get the coordinates of the selected rectangle [x, y, width, height]
rect = getrect;
tic
%Extract the object from the left image.
object_Mask = imcrop(Il, rect);
close (selectObj);

%Turn the left image and the mask to gray.
Il=rgb2gray(Il);
object_Mask = rgb2gray(object_Mask);

%Getting the correlation to find the object corrdinates.
corr_objL = normxcorr2(object_Mask,Il);
corr_objR = normxcorr2(object_Mask,Ir);


%Getting the original objects corrdinates by finding the largest value in
%the correlation.
[original_y1, original_x1] = find(corr_objL == max(max(corr_objL)));

%Getting the shifted objects corrdinates.
[shifted_y1, shifted_x1] = find(corr_objR == max(max(corr_objR)));

%Dispairity calculation.
dispairtyX=original_x1-shifted_x1;

%The distance equation and returning the value.
Z=(f*T)/dispairtyX;
time=toc;
end

