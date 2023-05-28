%%video reading and avging (code from instructions)
% 
% [fname fpath] = uigetfile();
% path = [fpath fname];
% 
% vidobj = VideoReader(path);
numFrames = get(vidobj, 'NumberOfFrames');
Frame_Avrg=im2double(read(vidobj,1));
ORG_ALG_frame_avg = Frame_Avrg;
std1 = std(Frame_Avrg(:));
figure(100); imshow(Frame_Avrg); title('Original Pic');
mask1_ = rgb2gray(Frame_Avrg);
mask1=mask1_([198:216], [161:194]);
mask2=mask1_([209:222],[484:505]);

fixed_x1 = floor((161 + 194)/2);
fixed_y1 = floor((198 + 216)/2);
fixed_x2 = floor((484 + 505)/2);
fixed_y2 = floor((209 + 222)/2);

fixed_p = [fixed_y1 fixed_x1; fixed_y2 fixed_x2];

figure(1); subplot(311); hist(Frame_Avrg(:),255); title(['Original Hist {\sigma} = ' num2str(std1)]); grid on;
figure(4); subplot(321);imshow(Frame_Avrg(250:350,:,:)); title('ORIGINAL Pic ACROSS WINDOW AREA');
subplot(322); plot(Frame_Avrg(340,:)); grid on; title('Power Across Windows Line ORIGINAL pic');

N_avg=16;
for i=2:N_avg
 Frame=im2double(read(vidobj, i));
 ORG_ALG_frame = Frame;

 Frame_ = rgb2gray(Frame);
 corr1_frame_i=normxcorr2(mask1,Frame_);
 corr2_frame_i=normxcorr2(mask2,Frame_);

 [moving_y1, moving_x1] = find(corr1_frame_i == max(max(corr1_frame_i)));
 [moving_y2, moving_x2] = find(corr2_frame_i == max(max(corr2_frame_i)));
 moving_p = [moving_y1 moving_x1; moving_y2 moving_x2];

 tform_frame_i = fitgeotform2d(moving_p,fixed_p,"similarity");
 sameAsInput = affineOutputView(size(Frame),tform_frame_i,"BoundsStyle","SameAsInput");
 imwarp(Frame,tform_frame_i,"OutputView",sameAsInput);
 
 ORG_ALG_frame_avg = ORG_ALG_frame_avg + ORG_ALG_frame;
 Frame_Avrg= Frame_Avrg+Frame;
end

ORG_ALG_frame_avg= ORG_ALG_frame_avg/N_avg;
Frame_Avrg= Frame_Avrg/N_avg;

std2 = std(Frame_Avrg(:));
std3 = std(ORG_ALG_frame_avg(:));

figure(2)
montage({Frame,Frame_Avrg})
title('Average Frame after 16 interaction AND TRANSFORMATIONS');

figure(3)
montage({Frame,ORG_ALG_frame_avg})
title('Average Frame after 16 interaction ORIGINAL ALGORITHM');

figure(1);subplot(312);hist(Frame_Avrg(:),255); title(['AVG and TRNSFRM hist {\sigma} = ' num2str(std2)]); grid on;
subplot(313);hist(ORG_ALG_frame_avg(:),255); title(['ORIGINAL ALGORITHM hist {\sigma} = ' num2str(std3)]); grid on;

figure(4); subplot(325);imshow(Frame_Avrg(250:350,:,:)); title('AVG and TRNSFRM Pic ACROSS WINDOW AREA');
subplot(326); plot(Frame_Avrg(340,:)); grid on; title('Power Across Windows Line AVG and TRNSFRM');

subplot(323);imshow(ORG_ALG_frame_avg(250:350,:,:)); title('AVG Pic ACROSS WINDOW AREA');
subplot(324); plot(ORG_ALG_frame_avg(340,:)); grid on; title('Power Across Windows Line AVG pic');