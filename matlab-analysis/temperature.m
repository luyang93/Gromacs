clearvars
clc
FID = fopen('temperature.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
temperature_data = cell2mat(DATA);
% x1 Time
% x2 Temperature
Time = temperature_data(:,1);
Temperature = temperature_data(:,2);

% 移动平均
type = 'linear';
windowSize = 20;
ma = movavg(Temperature,type,windowSize);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time, Temperature, Time, ma)
legend('Temperature')
set(legend,'Orientation','horizontal');
xlabel({'Time(ps)'});
ylabel('Temperature(K)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[280, 320]);
xlim(axes0,[min(Time), max(Time)]);
box(axes0,'off');
