clearvars
clc
FID = fopen('rmsd.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
rmsd_data = cell2mat(DATA);

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
xlim(axes1,[0,200]);
ylim(axes1,[0 1]);
plot1 = plot(rmsd_data(1:end,1)*10 ,rmsd_data(1:end,2),'Parent',axes1);
nstep = 50;
move_data = [];
for i = 1:size(rmsd_data)
    if i < nstep+1
        move_data = [move_data sum(rmsd_data(1:i,2))/i];
    else
        move_data = [move_data sum(rmsd_data(i-nstep:i,2))/nstep];
    end
end
move_data = move_data';
plot(rmsd_data(1:10:end,1)*10 ,move_data(1:10:end,:))
%movavg(rmsd_data(:,2),100,1000,1)
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')
% x1 Time
% x2 rmsd
