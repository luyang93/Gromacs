clearvars
clc
FID = fopen('hbnum.xvg','rt');
DATA = textscan(FID,'%f %f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
hbnum_data = cell2mat(DATA);
plot(hbnum_data(:,2))
% x1 Time
% x2 Hydrogen bonds
% x3 Pairs within 0.35 nm