clearvars
clc
FID = fopen('sasa.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
sasa_data = cell2mat(DATA);
plot(sasa_data(:,2))
% x1 Time
% x2 Area