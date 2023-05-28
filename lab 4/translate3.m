clc, close all, clear
A = checkerboard;

% create translation transformation matrix
xform = [ 1  0  0
    0  1  0
    2 3  1 ];
tform_translate = affine2d(xform);
sameAsInput = affineOutputView(size(A),tform_translate,'BoundsStyle','SameAsInput');

% create transformed image
Ac = imwarp(A, tform_translate,'OutputView',sameAsInput);

%find inverse transformation to correct the image
k=0;
for i=-4:4,
    for j=-4:4,
        k=k+1;
        xform = [ 1  0  0
            0  1  0
            i j  1 ];
        tform_translate = affine2d(xform);
        %        tform_translate = maketform('affine2d',xform);
        %        At = imtransform(Ac, tform_translate,'XData',[1 size(A,2)],'YData',[1 size(A,1)]);
        sameAsInput = affineOutputView(size(A),tform_translate,'BoundsStyle','SameAsInput');
        At = imwarp(Ac, tform_translate,'OutputView',sameAsInput);
        imagesc(A-At), colormap(gray), colorbar, axis equal, axis square
        sad(k,1)=i;
        sad(k,2)=j;
        sad(k,3)=sum(sum(abs(A-At)));
        title([ num2str(i) '  '  num2str(j)  '  '  num2str(sad(k))])
        pause(0.11)
    end
end
plot(sad(:,3))
I=find(sad(:,3)==min(sad(:,3)));
title(['Min SAD is at i = ' num2str(sad(I,1)) ', j = '  num2str(sad(I,2))])

% find correction of Tform
ic=(sad(I,1));
jc=(sad(I,2));

xform = [ 1  0  0
    0  1  0
    ic jc  1 ];
tform_translate1 = affine2d(xform);

% create corrected image
Ac_corrected = imwarp(Ac, tform_translate1,'OutputView',sameAsInput);
montage({A,Ac, Ac_corrected})

