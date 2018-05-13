clearvars
clc
FID = fopen('pressure.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
pressure_data = cell2mat(DATA);
step = 20;
movavg(pressure_data(:,2),step,step,1);
% x1 Time
% x2 pressure