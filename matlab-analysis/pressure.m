clearvars
clc
FID = fopen('pressure.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
pressure_data = cell2mat(DATA);
% x1 Time
% x2 pressure
Time = pressure_data(:,1);
Pressure = pressure_data(:,2);

% 移动平均
type = 'linear';
windowSize = 20;
ma = movavg(Pressure,type,windowSize);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time, Pressure, Time, ma)
legend('Pressure')
set(legend,'Orientation','horizontal');
xlabel('Time(ps)');
ylabel('Pressure(bar)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[-500, 500]);
xlim(axes0,[min(Time), max(Time)]);
box(axes0,'off');
