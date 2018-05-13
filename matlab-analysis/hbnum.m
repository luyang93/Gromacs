clearvars
clc
FID = fopen('hbnum.xvg','rt');
DATA = textscan(FID,'%f %f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
hbnum_data = cell2mat(DATA);
% x1 Time
% x2 Rg
% x3 Rg_X
% x4 Rg_Y
% x5 Rg_Z
Time = hbnum_data(:,1)/100;
Hb = hbnum_data(:,2);
Pair = hbnum_data(:,3);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time(1:10:end), Hb(1:10:end), '.')
legend('Hydrogen Bond Number')
set(legend,'Orientation','horizontal');
legend('Hydrogen bonds')
xlabel({'Time(ns)'});
ylabel('Hydrogen Bond Number');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[0, 4]);
xlim(axes0,[0, 100]);
box(axes0,'off');
