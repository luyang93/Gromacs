clearvars
clc
FID = fopen('potential.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
potential_data = cell2mat(DATA);
plot(potential_data(:,2))
% x1 Time
% x2 Potential