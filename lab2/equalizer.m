function I_out = equalizer(I)
%Get Histogram
I_hist=hist(I(:),0:255);
%Get CDF and a LUT
CDF=cumsum(I_hist/sum(I_hist));
LUT=round(255*CDF);
h=LUT(I+1);
hmax=max(h(:));
hmin=min(h(:));
I_out=stretch_LUT(h,hmin,hmax);

end