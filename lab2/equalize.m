function I_out = equalize(I)
%Get Histogram
I_hist=hist(I(:),0:255);
%Get CDF and a LUT
CDF=cumsum(I_hist/sum(I_hist));
LUT=round(255*CDF);
J=LUT(I+1);
J_max=max(J(:));
J_min=min(J(:));
I_out=stretch_LUT(J,J_min,J_max);

end