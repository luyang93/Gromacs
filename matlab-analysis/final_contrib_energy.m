clearvars
clc
FID = fopen('final_contrib_energy.dat','rt');
DATA = textscan(FID,'%s %f %f %f %f %f %f %f %f','HeaderLines',12,'CommentStyle','@');
fclose(FID);
res_name = DATA{:,1};
DATA(1) = [];
final_contrib_energy_data = cell2mat(DATA);
% x1 MM Energy
% x2 MM Energy_dev/error
% x3 Polar Energy
% x4 Polar Energy_dev/error
% x5 APolar Energy
% x6 APolar Energy_dev/error
% x7 Total Energy
% x8 Total Energy_dev/error
