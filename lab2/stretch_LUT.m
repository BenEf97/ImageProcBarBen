
function out = stretch_LUT(I,T1,T2)

T1=double(T1);
T2=double(T2);
I=double(I);

a= (255/(T2-T1));
b= 255*T1/(T1-T2);

x=0:255;

LUT=a*x+b;

out=LUT(I+1);

out=uint8(out);

end
