clearvars
clc
FID = fopen('temperature.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
temperature_data = cell2mat(DATA);
step = 20;
movavg(temperature_data(:,2),step,step,1);
% x1 Time
% x2 Temperature
