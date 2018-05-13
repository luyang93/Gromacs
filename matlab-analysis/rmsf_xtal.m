clearvars
clc
FID = fopen('rmsf_xtal.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
rmsf_xtal_data = cell2mat(DATA);
plot(rmsf_xtal_data(:,1),rmsf_xtal_data(:,2))
% x1 Time
% x2 rmsf_xtal
