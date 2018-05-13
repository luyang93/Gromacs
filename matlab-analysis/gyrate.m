clearvars
clc
FID = fopen('gyrate.xvg','rt');
DATA = textscan(FID,'%f %f %f %f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
gyrate_data = cell2mat(DATA);
plot(gyrate_data(:,2:5))
% x1 Time
% x2 Rg
% x3 Rg_X
% x4 Rg_Y
% x5 Rg_Z
