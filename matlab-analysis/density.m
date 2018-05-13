clearvars
clc
FID = fopen('density.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
density_data = cell2mat(DATA);
% x1 Time
% x2 Density
Time = density_data(:,1);
Density = density_data(:,2);

% 移动平均
type = 'linear';
windowSize = 20;
ma = movavg(Density,type,windowSize);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time, Density, Time, ma)
legend('Density')
set(legend,'Orientation','horizontal');
xlabel({'Time(ps)'});
ylabel('Density(kg*m-3)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[1010, 1030]);
xlim(axes0,[min(Time), max(Time)]);
box(axes0,'off');
