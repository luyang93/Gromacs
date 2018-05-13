clearvars
clc
FID = fopen('rmsd.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
rmsd_data = cell2mat(DATA);
% x1 Time
% x2 RMSD
Time = rmsd_data(:,1);
RMSD = rmsd_data(:,2);

% 移动平均
type = 'linear';
windowSize = 100;
ma = movavg(RMSD,type,windowSize);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time(1:10:end), RMSD(1:10:end), Time, ma)
legend('RMSD')
set(legend,'Orientation','horizontal');
xlabel({'Time(ns)'});
ylabel('RMSD(nm)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[0, 1]);
xlim(axes0,[min(Time), max(Time)]);
box(axes0,'off');
