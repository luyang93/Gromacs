clearvars
clc
FID = fopen('apolar.xvg','rt');
DATA = textscan(FID,'%f %f %f %f %f %f %f %f %f %f','HeaderLines',12,'CommentStyle','@');
fclose(FID);
apolar_data = cell2mat(DATA);
% x1 Time
% x2 Protein-Surf-ten energy
% x3 MOL-Surf-ten energy
% x4 Protein+MOL-Surf-ten energy
% x5 Protein-Press-Vol energy
% x6 MOL-Press-Vol energy
% x7 Protein+MOL-Press-Vol energy
% x8 Protein-WCA energy
% x9 MOL-WCA energy
% x10 Protein+MOL-WCA energy

FID = fopen('polar.xvg','rt');
DATA = textscan(FID,'%f %f %f %f','HeaderLines',12,'CommentStyle','@');
fclose(FID);
polar_data = cell2mat(DATA);
% x1 Time
% x2 Protein PB energy
% x3 MOL PB energy
% x4 Protein=MOL PB energy

FID = fopen('energy_MM.xvg','rt');
DATA = textscan(FID,'%f %f %f %f %f %f %f %f','HeaderLines',12,'CommentStyle','@');
Time = DATA{1};
Time = Time/1000;
energy_MM_data = cell2mat(DATA);
% x1 Time
% x2 Protein VdW Energy
% x3 Protein Elec. Energy
% x4 MOL VdW Energy
% x5 MOL Elec. Energy
% x6 Protein-MOL VdW Energy
% x7 Protein-MOL Elec. Energy
% x8 Protein-MOL Total Energy

MM = energy_MM_data(:,6) + energy_MM_data(:,7) - energy_MM_data(:,2) - energy_MM_data(:,3) - energy_MM_data(:,4) - energy_MM_data(:,5);
VdW = energy_MM_data(:,6) - energy_MM_data(:,2) - energy_MM_data(:,4);
Elec = energy_MM_data(:,7) - energy_MM_data(:,3) - energy_MM_data(:,5);
Pol = polar_data(:,4) - polar_data(:,2) - polar_data(:,3);
Apol = apolar_data(:,4) - apolar_data(:,2) - apolar_data(:,3);
Binding = VdW + Elec + Pol + Apol;

% 创建 figure
figure0 = figure;

% 创建 axes
axes0 = axes('Parent',figure0);
plot(Time, VdW, Time, Elec, Time, Pol,Time, Apol, Time,Binding)
legend('VdW','Elec','Pol','Apol','Binding')
xlabel({'Time(ns)'});
ylabel('Energy(kJ*mol-1)');
set(legend,'Orientation','horizontal');
ylim(axes0,[-400 400]);
xlim(axes0,[0,100]);
box(axes0,'off');
set (gcf,'unit','centimeters','Position',[0,0,14,11], 'color','w')


% % 截取start_time ns后的数据，并去除NaN
% start_time = 1;
% end_time =2001;
% 
% % start_time ns后计算平均值和标准差
% mean_VdW = mean(VdW(start_time:end_time));
% std_VdW = std(VdW(start_time:end_time));
% mean_Elec = mean(Elec(start_time:end_time));
% std_Elec = std(Elec(start_time:end_time));
% mean_Pol = mean(Pol(start_time:end_time));
% std_Pol = std(Pol(start_time:end_time));
% mean_Apol = mean(Apol(start_time:end_time));
% std_Apol = std(Apol(start_time:end_time));
% mean_Binding = mean(Binding(start_time:end_time));
% std_Binding = std(Binding(start_time:end_time));
% 
% % 输出结果
% fprintf('%dns~%dns\n',round((start_time-1)/100),round((end_time-1)/100));
% fprintf('VdW = %.2f ± %.2f\n',mean_VdW,std_VdW);
% fprintf('Elec = %.2f ± %.2f\n',mean_Elec,std_Elec);
% fprintf('Pol = %.2f ± %.2f\n',mean_Pol,std_Pol);
% fprintf('Apol = %.2f ± %.2f\n',mean_Apol,std_Apol);
% fprintf('Binding = %.2f ± %.2f\n',mean_Binding,std_Binding);
% 
% 
% % 截取start_time ns后的数据，并去除NaN
% start_time = 1;
% end_time = 1001;
% 
% % start_time ns后计算平均值和标准差
% mean_VdW = mean(VdW(start_time:end_time));
% std_VdW = std(VdW(start_time:end_time));
% mean_Elec = mean(Elec(start_time:end_time));
% std_Elec = std(Elec(start_time:end_time));
% mean_Pol = mean(Pol(start_time:end_time));
% std_Pol = std(Pol(start_time:end_time));
% mean_Apol = mean(Apol(start_time:end_time));
% std_Apol = std(Apol(start_time:end_time));
% mean_Binding = mean(Binding(start_time:end_time));
% std_Binding = std(Binding(start_time:end_time));
% 
% % 输出结果
% fprintf('%dns~%dns\n',round((start_time-1)/100),round((end_time-1)/100));
% fprintf('VdW = %.2f ± %.2f\n',mean_VdW,std_VdW);
% fprintf('Elec = %.2f ± %.2f\n',mean_Elec,std_Elec);
% fprintf('Pol = %.2f ± %.2f\n',mean_Pol,std_Pol);
% fprintf('Apol = %.2f ± %.2f\n',mean_Apol,std_Apol);
% fprintf('Binding = %.2f ± %.2f\n',mean_Binding,std_Binding);
% 
% 
% % 截取start_time ns后的数据，并去除NaN
% start_time = 1000;
% end_time =2001;
% 
% % start_time ns后计算平均值和标准差
% mean_VdW = mean(VdW(start_time:end_time));
% std_VdW = std(VdW(start_time:end_time));
% mean_Elec = mean(Elec(start_time:end_time));
% std_Elec = std(Elec(start_time:end_time));
% mean_Pol = mean(Pol(start_time:end_time));
% std_Pol = std(Pol(start_time:end_time));
% mean_Apol = mean(Apol(start_time:end_time));
% std_Apol = std(Apol(start_time:end_time));
% mean_Binding = mean(Binding(start_time:end_time));
% std_Binding = std(Binding(start_time:end_time));
% 
% % 输出结果
% fprintf('%dns~%dns\n',round((start_time-1)/100),round((end_time-1)/100));
% fprintf('VdW = %.2f ± %.2f\n',mean_VdW,std_VdW);
% fprintf('Elec = %.2f ± %.2f\n',mean_Elec,std_Elec);
% fprintf('Pol = %.2f ± %.2f\n',mean_Pol,std_Pol);
% fprintf('Apol = %.2f ± %.2f\n',mean_Apol,std_Apol);
% fprintf('Binding = %.2f ± %.2f\n',mean_Binding,std_Binding);
