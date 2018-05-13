clearvars
clc
FID = fopen('rmsf.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
rmsf_data = cell2mat(DATA);
plot(rmsf_data(:,1),rmsf_data(:,2))
% x1 Time
% x2 rmsf
