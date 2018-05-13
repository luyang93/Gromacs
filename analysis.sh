#!/bin/bash
echo "10 0" | gmx energy -f em.edr -o potential.xvg
echo "15 0" | gmx energy -f nvt.edr -o temperature.xvg
echo "16 0" | gmx energy -f npt.edr -o pressure.xvg
echo "22 0" | gmx energy -f npt.edr -o density.xvg
echo "8 0"   | gmx energy -f md_0_1.edr -o Coul_SR.xvg
echo "6 0"   | gmx energy -f md_0_1.edr -o LJ_SR.xvg
echo "0"      | gmx trjconv -s md_0_1.tpr -f md_0_1.xtc -o md_0_1_whole.xtc -pbc whole -n index.ndx 
echo "1 0"   | gmx trjconv -s md_0_1.tpr -f md_0_1_whole.xtc -o md_0_1_mol_center.xtc -center -pbc mol -n index.ndx
echo "4 4"   | gmx rms -s md_0_1.tpr -f md_0_1_mol_center.xtc -o rmsd.xvg -tu ns
echo "4 4"   | gmx rms -s em.tpr -f md_0_1_mol_center.xtc -o rmsd_xtal.xvg -tu ns
echo "4"      | gmx rmsf -s md_0_1.tpr -f md_0_1_mol_center.xtc -o rmsf.xvg
echo "4"      | gmx rmsf -s em.tpr -f md_0_1_mol_center.xtc -o rmsf_xtal.xvg
echo "1"      | gmx sasa -s md_0_1.tpr -f md_0_1_mol_center.xtc -o sasa.xvg
gmx sasa -s md_0_1.tpr -f md_0_1_mol_center.xtc -o sasa_Hydrophobe.xvg -surface 'group protein' -output '"Hydrophobic"  group protein and charge {-0.2 to 0.2};"Hydrophilic" group protein and not charge {-0.2 to 0.2}'
echo "1 13"| gmx hbond -s md_0_1.tpr -f md_0_1_mol_center.xtc -num hbnum.xvg
echo "13 24"| gmx cluster -s md_0_1.tpr -f md_0_1_mol_center.xtc -n index.ndx -cl cluster.pdb


###Three steps calculation
####(a) Calculation of potential energy in Vacuum
#echo "1 13" | g_mmpbsa -f md_0_1.xtc -s md_0_1.tpr -n index.ndx -pdie 2 -decomp
####(b) Calculation of polar solvation energy
#echo "1 13" | g_mmpbsa -f md_0_1.xtc -s md_0_1.tpr -n index.ndx -i polar.mdp -nomme -pbsa -decomp
####(c) Calculation of non-polar solvation energy
#####For SASA-only model:
#echo "1 13" | g_mmpbsa -f md_0_1.xtc -s md_0_1.tpr -n index.ndx -i apolar_sasa.mdp -nomme -pbsa -decomp -apol sasa.xvg -apcon sasa_contrib.dat
#####For SAV-only model:
#echo "1 13" | g_mmpbsa -f md_0_1.xtc -s md_0_1.tpr -n index.ndx -i apolar_sav.mdp -nomme -pbsa -decomp -apol sav.xvg -apcon sav_contrib.dat


###One step calculation
#echo "1 13" | g_mmpbsa -f md_0_1.xtc -s md_0_1.tpr -n index.ndx -i pbsa.mdp -pdie 2 -pbsa -decomp
###Average Binding Energy Calculation
#echo " " | sudo -S python MmPbSaStat.py -m energy_MM.xvg -p polar.xvg -a apolar.xvg


#sudo python MmPbSaStat.py -m energy_MM.xvg -p polar.xvg -a sasa.xvg
#sudo python MmPbSaStat.py -bs -nbs 1 -m energy_MM.xvg -p polar.xvg -a sasa.xvg
#sudo python MmPbSaStat.py -m energy_MM.xvg -p polar.xvg -a apolar.xvg
#sudo python MmPbSaStat.py -bs -nbs 1 -m energy_MM.xvg -p polar.xvg -a apolar.xvg

mkdir analysis
cp *.xvg ./analysis
cp md.log ./analysis
cp resp.log ./analysis
cp analysis.log ./analysis
cp rmsd-clust.xpm cluster.pdb ./analysis
