#!/bin/bash
###One step calculation
# echo "1 13" | echo "1 13" | g_mmpbsa -f ../md_0_1_mol_center.xtc -s ../md_0_1.tpr -n ../index.ndx -i ../pbsa.mdp -pdie 2 -pbsa -decomp -b 0 -e 100000 -dt 100 -mm energy_MM.xvg -pol polar.xvg -apol apolar.xvg -mmcon contrib_MM.dat -pcon contrib_pol.dat -apcon contrib_apol.dat 

cp 0/* ./
cp 1/* ./
cp 2/* ./
cp 3/* ./

python3 MmPbSaCombine.py
rm polar_* energy_MM_* apolar_* contrib_pol_* contrib_apol_* contrib_MM_*
mv contrib_apol.xvg contrib_apol.dat
mv contrib_pol.xvg contrib_pol.dat
mv contrib_MM.xvg contrib_MM.dat

###Average Binding Energy Calculation
echo " " | sudo -S python MmPbSaStat.py -m energy_MM.xvg -p polar.xvg -a apolar.xvg
#Contribution of residues to the binding energy
echo " " | sudo -S python MmPbSaDecomp.py -m contrib_MM.dat -p contrib_pol.dat -a contrib_apol.dat 
export GMXLIB=/opt/gromacs/share/gromacs/top
echo "1 13" | energy2bfac -s md_0_1.tpr -i energyMapIn.dat

cp *.xvg ./analysis
cp pbsa.log ./analysis
cp contrib_MM.dat contrib_pol.dat full_energy.dat contrib_apol.dat summary_energy.dat final_contrib_energy.dat complex.pdb subunit_1.pdb subunit_2.pdb energyMapIn.dat ./analysis
