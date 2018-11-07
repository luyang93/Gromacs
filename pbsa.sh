#!/bin/bash
###One step calculation
# echo "1 13" | echo "1 13" | g_mmpbsa -f ../md_0_1_mol_center.xtc -s ../md_0_1.tpr -n ../index.ndx -i ../pbsa.mdp -pdie 2 -pbsa -decomp -b 0 -e 100000 -dt 100 -mm energy_MM.xvg -pol polar.xvg -apol apolar.xvg -mmcon contrib_MM.dat -pcon contrib_pol.dat -apcon contrib_apol.dat 

python3 ../merge.py -p `pwd`

###Average Binding Energy Calculation
echo " " | sudo -S python MmPbSaStat.py -m analysis/energy_MM.xvg -p analysis/polar.xvg -a analysis/apolar.xvg -of analysis/full_energy.dat -os analysis/summary_energy.dat -om analysis/meta_energy.dat
#Contribution of residues to the binding energy
echo " " | sudo -S python MmPbSaDecomp.py -m analysis/contrib_MM.dat -p analysis/contrib_pol.dat -a analysis/contrib_apol.dat -o analysis/final_contrib_energy.dat
export GMXLIB=/opt/gromacs/share/gromacs/top
echo "1 13" | energy2bfac -s md_0_1.tpr -i energyMapIn.dat -c analysis/complex.pdb -s1 analysis/subunit_1.pdb -s2 analysis/subunit_2.pdb

python3 ../plot.py -p `pwd`

cp pbsa.log ./analysis
