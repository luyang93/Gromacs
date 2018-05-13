clearvars
clc
filename = {'Coul-14.xvg' 'Coul-14:MOL-MOL.xvg' 'Coul-14:MOL-rest.xvg' 'Coul-14:Protein-MOL.xvg' 'Coul-14:Protein-Protein.xvg' 'Coul-14:Protein-rest.xvg' 'Coul-14:rest-rest.xvg' 'Coul-SR.xvg' 'Coul-SR:MOL-MOL.xvg' 'Coul-SR:MOL-rest.xvg' 'Coul-SR:Protein-MOL.xvg' 'Coul-SR:Protein-Protein.xvg' 'Coul-SR:Protein-rest.xvg' 'Coul-SR:rest-rest.xvg'};
for i = 1:14
    FID = fopen(filename{i},'rt');
    DATA = textscan(FID,'%f %f','HeaderLines',13,'CommentStyle','@');
    fclose(FID);
    Time = DATA{1};
    Coul_data(:,1) = Time;
    Coul_data = [Coul_data DATA{2}];
end
% x1 Time
% x2 Coul. recip.
% x3 Coul-14:MOL-MOL
% x4 Coul-14:MOL-rest
% x5 Coul-14:Protein-MOL
% x6 Coul-14:Protein-Protein
% x7 Coul-14:Protein-rest
% x8 Coul-14:rest-rest
% x9 Coulomb (SR)
% x10 Coul-SR:MOL-MOL
% x11 Coul-SR:MOL-rest
% x12 Coul-SR:Protein-MOL
% x13 Coul-SR:Protein-Protein
% x14 Coul-SR:Protein-rest
% x15 Coul-SR:rest-rest