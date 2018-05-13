#!/bin/sh
antechamber -i lig.gesp -fi gesp -o lig.mol2 -fo mol2 -pf y -c resp
parmchk2 -i lig.mol2 -f mol2 -o lig.frcmod
tleap -f leap.in
python2 /opt/amber16/acpype/acpype.py -p lig.prmtop -x lig.inpcrd -d
cp MOL_GMX.gro lig.gro
cp MOL_GMX.top lig.itp
echo    >> lig.itp
echo    >> lig.itp
sed -r '/\[ defaults ]/{:a;N;/\n$/{d};ba}' lig.itp -i
sed -r '/\[ atomtypes ]/{:a;N;/\n$/{d};ba}' lig.itp -i
sed -r '/\[ system ]/{:a;N;/\n$/{d};ba}' lig.itp -i
sed -r '/\[ molecules ]/{:a;N;/\n$/{d};ba}' lig.itp -i
