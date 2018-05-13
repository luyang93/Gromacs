#!/bin/bash
gmx pdb2gmx -f protein.pdb -o protein.gro <<EOF
7
1
EOF
echo "MOL   1"  >> topol.top
sed '0,/#endif/s//#endif\n\n;Include ligand topology\n#include "lig.itp"/' topol.top -i
bash complex.sh > complex.gro
cp md_backup.mdp md.mdp
cp em_backup.mdp em.mdp
gmx editconf -f complex.gro -o newbox.gro -bt dodecahedron -d 1.0
gmx solvate -cp newbox.gro -cs spc216.gro -p topol.top -o solv.gro
gmx grompp -f em.mdp -c solv.gro -p topol.top -o ions.tpr
echo "15"  | gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -conc 0.15 -neutral -pname NA -nname CL
gmx grompp -f em_real.mdp -c solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
echo "2"   | gmx genrestr -f lig.gro -o posre_lig.itp -fc 1000 1000 1000
sed -i '/#include "lig.itp"/ a ; Ligand position restraints\n#ifdef POSRES_LIG\n#include "posre_lig.itp"\n#endif' topol.top -i
gmx make_ndx -f em.gro -o index.ndx<<EOF
1 | 13
q
EOF
gmx grompp -f nvt.mdp -c em.gro -p topol.top -n index.ndx -o nvt.tpr
gmx mdrun -deffnm nvt -v
gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -n index.ndx -o npt.tpr
gmx mdrun -deffnm npt -v
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -n index.ndx -o md_0_1.tpr
gmx mdrun -deffnm md_0_1 -v
