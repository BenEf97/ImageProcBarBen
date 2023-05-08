%% Lab 2

%% A histogram calculation
%1
%reading the file
kids=imread("kids.tif");
race=imread("race.tif");

%getting the mean of the photos (ממוצע-בהירות)
kids_mean= mean(kids);
race_mean= mean(race);

%getting the standard deviation (נגידויות- שונות)
kids_std = std(double(kids));
race_std = std(double(race));

%2+3
fi=figure();
%turning the photos into vectors.
kids_vec=kids(:);
race_vec=race(:);

%plotting
subplot(2,2,1);
hist(kids_vec, [0:255]);
title("hist for kids");
xlabel("gray value (k)");
ylabel("n_k");
subplot(2,2,2);
hist(race_vec, [0:255]);
title("hist for race");
xlabel("gray value (k)");
ylabel("n_k");
subplot(2,2,3);
imshow(kids);
title("kids.tif");
subplot(2,2,4);
imshow(race);
title("race.tif");
saveas(fi,"PartA_result");

%% B contrast streching
%1+2
fi=figure();
subplot(1,2,1);
hist(kids_vec, 0:255);
title("hist for kids");
xlabel("gray value (k)");
ylabel("n_k");
subplot(1,2,2);
imshow(kids);
title("kids.tif");
saveas(fi,"PartB_2");
%3+4
fi=figure();
out=stretch_LUT(kids,70,180); %minimum and maximum- T1=70, T2=180
subplot(2,2,1);
imshow(out);
title("kids- after strech LUT");
subplot(2,2,2);
imshow(kids);
title("kids.tif original");
subplot(2,2,3);
kids_hist=hist(kids_vec, [0:255]);
title("hist for kids original");
xlabel("gray value (k)");
ylabel("n_k");
subplot(2,2,4);
hist(out(:), [0:255]);
title("hist for kids after LUT strech");
xlabel("gray value (k)");
ylabel("n_k");
saveas(fi,"PartB_3+4");

%5 after lut is better

%6 try to find T1 and T2 automaticly
%6.1- using std and mean??
%6.2 only 98% of the values will get streched.
%normalizeing the values to be at [0,1]
kids_hist_normalized = double(kids_hist)/sum(kids_hist);
kids_cdf = cumsum(kids_hist_normalized);
T1 = find(kids_cdf>0.01,1);
T2 = find(kids_cdf<0.99,1,'last');