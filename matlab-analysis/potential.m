clearvars
clc
FID = fopen('potential.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
potential_data = cell2mat(DATA);
% x1 Time
% x2 Potential
step = potential_data(:,1);
E_potential = potential_data(:,2);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(step, E_potential)
legend('Potential Energy')
set(legend,'Orientation','horizontal');
xlabel({'Energy Minimization Step'});
ylabel('Energy of Potential(kJ*mol-1)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[min(E_potential)-1e5, max(E_potential)+1e5]);
xlim(axes0,[min(step), max(step)]);
box(axes0,'off');
