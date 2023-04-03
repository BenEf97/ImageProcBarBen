%% 2
clear;
clc;
x=uint8([10, 30, 50, 70, 90, 110, 110, 110, 10, 10, 10, 10, 30]);
xstretch=stretch_LUT(x,10,110);
figure(1)
h1=imhist(xstretch);
ylim([0 5.2])
bar(h1,3);
title('xstretch histogram')
%% 3
figure(2)
xhisteq=histeq(x);
subplot(2,1,1)
h2=imhist(x);
ylim([0 5.2])
bar(h2,3);
title('x histogram')
subplot(2,1,2)
h3=imhist(xhisteq);
ylim([0 5.2])
bar(h3,3);
title('xhisteq histogram')

minhisteq=min(xhisteq(:))
maxhisteq=max(xhisteq(:))

%% 4

xhisteqstretch=stretch_LUT(xhisteq,49,227);
figure(3)
h4=imhist(xhisteqstretch);
ylim([0 5.2])
bar(h4,3);
title('xhisteqstretch histogram')

%% 5

clear
clc
x=rand(100)*255;
figure(4)
x_hd= imhist(x);
bar(x_hd,0.3);

xuint8=uint8(x);
figure(5)
x_hduint8= imhist(xuint8);
bar(x_hduint8,0.3);

%% 6

x_vect=reshape(x,[],1);
h_vect=hist(x_vect,0:255);
figure(6)
bar(h_vect,0.3);

%% 7

clear
clc

v=rand(10000,1)*255;
v=uint8(v);
vhist=imhist(v);
vh=vhist/10000;
PDFmean= mean(vh)
PDFmin= min(vh)
PDFmax= max(vh,[],1)
PDFstd= std(vh)
PDFmedian= median(vh)
cdf=cumsum(vh);
per5 = find(cdf>0.05,1)

