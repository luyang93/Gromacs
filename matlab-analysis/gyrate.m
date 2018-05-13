clearvars
clc
FID = fopen('gyrate.xvg','rt');
DATA = textscan(FID,'%f %f %f %f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
gyrate_data = cell2mat(DATA);
% x1 Time
% x2 Rg
% x3 Rg_X
% x4 Rg_Y
% x5 Rg_Z
Time = gyrate_data(:,1)/10;
Rg = gyrate_data(:,2);
Rg_x = gyrate_data(:,3);
Rg_y = gyrate_data(:,4);
Rg_z = gyrate_data(:,5);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time, Rg, Time, Rg_x, Time, Rg_y, Time, Rg_z)
legend('Radius of gytation')
set(legend,'Orientation','horizontal');
legend('Rg','Rg_x','Rg_y','Rg_z')
xlabel({'Time(ns)'});
ylabel('Rg(nm)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[1, 3]);
xlim(axes0,[min(Time), max(Time)]);
box(axes0,'off');
