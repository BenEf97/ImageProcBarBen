function OUTIMG=ImgLoad(PathToFile,fileName, SzX,SzY)
% the program reads raw data image files under the assumption that each
% pixel is represented as 'uint8'
% PathToFile is a string containing the path to file location
% filename is a string containing the file name  
file=fullfile(PathToFile,fileName);
fid=fopen(file);
OUTIMG=fread(fid,[SzX SzY],'uint8=>uint8');
fclose(fid);