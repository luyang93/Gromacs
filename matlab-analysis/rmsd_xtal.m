clearvars
clc
FID = fopen('rmsd_xtal.xvg','rt');
DATA = textscan(FID,'%f %f','Headerlines',13,'CommentStyle','@');
fclose(FID);
rmsd_xtal_data = cell2mat(DATA);

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
xlim(axes1,[0,10000]);
ylim(axes1,[0.1 1]);
plot1 = plot(rmsd_xtal_data(:,1)*100,rmsd_xtal_data(:,2),'Parent',axes1);
nstep = 1000;
move_data = [];
for i = 1:size(rmsd_xtal_data)
    if i < nstep+1
        move_data = [move_data sum(rmsd_xtal_data(1:i,2))/i];
    else
        move_data = [move_data sum(rmsd_xtal_data(i-1000:i,2))/1000];
    end
end
move_data = move_data';
plot(rmsd_xtal_data(:,1)*100,move_data)

% x1 Time
% x2 rmsd_xtal