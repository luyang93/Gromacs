clearvars
clc
filename = {'LJ-14.xvg' 'LJ-14:MOL-MOL.xvg' 'LJ-14:MOL-rest.xvg' 'LJ-14:Protein-MOL.xvg' 'LJ-14:Protein-Protein.xvg' 'LJ-14:Protein-rest.xvg' 'LJ-14:rest-rest.xvg' 'LJ-SR.xvg' 'LJ-SR:MOL-MOL.xvg' 'LJ-SR:MOL-rest.xvg' 'LJ-SR:Protein-MOL.xvg' 'LJ-SR:Protein-Protein.xvg' 'LJ-SR:Protein-rest.xvg' 'LJ-SR:rest-rest.xvg'};
for i = 1:14
    FID = fopen(filename{i},'rt');
    DATA = textscan(FID,'%f %f','HeaderLines',13,'CommentStyle','@');
    fclose(FID);
    Time = DATA{1};
    LJ_data(:,1) = Time;
    LJ_data = [LJ_data DATA{2}];
end
% x1 Time
% x2 LJ. recip.
% x3 LJ-14:MOL-MOL
% x4 LJ-14:MOL-rest
% x5 LJ-14:Protein-MOL
% x6 LJ-14:Protein-Protein
% x7 LJ-14:Protein-rest
% x8 LJ-14:rest-rest
% x9 LJ (SR)
% x10 LJ-SR:MOL-MOL
% x11 LJ-SR:MOL-rest
% x12 LJ-SR:Protein-MOL
% x13 LJ-SR:Protein-Protein
% x14 LJ-SR:Protein-rest
% x15 LJ-SR:rest-rest