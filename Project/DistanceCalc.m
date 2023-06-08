function [Z] = DistanceCalc(LeftImage,RightImage,f,T)
%DISTANCECALC Summary of this function goes here
%   Detailed explanation goes here

Il=LeftImage;
Ir=rgb2gray(RightImage);

% Display the first image
selectObj = figure();
imshow(Il);
title('Select an object by drawing a rectangle');
rect = getrect; % Get the coordinates of the selected rectangle [x, y, width, height]

% Extract the object from the first image and display
object_Mask = imcrop(Il, rect);
close (selectObj);

Il=rgb2gray(Il);
object_Mask = rgb2gray(object_Mask);

%getting the correlation
corr_objL = normxcorr2(object_Mask,Il);
corr_objR = normxcorr2(object_Mask,Ir);


%getting the original objects corrdinates
[original_y1, original_x1] = find(corr_objL == max(max(corr_objL)));

%getting the shifted objects corrdinates
[shifted_y1, shifted_x1] = find(corr_objR == max(max(corr_objR)));

%Dispairity calculation.
dispairtyX=original_x1-shifted_x1;
Z=(f*T)/dispairtyX;
end

