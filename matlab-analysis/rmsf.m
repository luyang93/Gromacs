clearvars
clc
FID = fopen('rmsf.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
rmsf_data = cell2mat(DATA);
% x1 Time
% x2 RMSF
Time = rmsf_data(:,1);
RMSF = rmsf_data(:,2);

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot([1:size(Time,1)], RMSF)
legend('RMSF')
set(legend,'Orientation','horizontal');
xlabel({'Residues C-alpha Atom'});
ylabel('RMSF(nm)');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
ylim(axes0,[0, 0.5]);
xlim(axes0,[1, size(Time,1)]);
box(axes0,'off');
