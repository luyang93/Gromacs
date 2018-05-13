clearvars
clc
FID = fopen('density.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
density_data = cell2mat(DATA);
step = 20;
movavg(density_data(:,2),step,step,1);
% x1 Time
% x2 Density
