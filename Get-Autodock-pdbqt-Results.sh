#!/bin/bash

#Copyleft 2010, Martin Christen (GNU GPL)
#GETLIGANDS script to extract all docked ligand conformations from a docking
#and save the individual PDBQT files.
#Filenames will include free energy of binding and run information.

# Modified by Aster Wang (march_happy@njucm.edu.cn), 2020-Jan-18
# Always believe something pawsome is about to happen🐾🐾
# Convert csh to bash for convenience
# And instead of exporting to pdb, I'll convert them to mol2

# Let's check if there is existing .dlg before creating subfolder
if [ ! -f *.dlg ]; then
echo "Sorry, no dlg file found... Exiting..."
exit 1
fi

#create subdirectories
echo ""
echo "GETLIGANDS started: $(date)"
echo ""
if [ ! -d PDBQT ]; then
mkdir PDBQT
fi
# if [ ! -d PDB ]; then
# mkdir PDB
# fi
if [ ! -d MOL2 ]; then
mkdir PDBQT
fi
#extract all docked conformations from all docking logs
echo -n "Extracting models . . ."
test "$(ls -1 *.dlg|wc -l)" = '1'&&grep '^DOCKED' *.dlg|sed "s/^/$(ls -1 *.dlg):/" > temp.pdbqt||grep '^DOCKED' *.dlg > temp.pdbqt

#split multimodel pdbqt
a=$(grep ENDMDL temp.pdbqt | wc -l)
b=$(expr "$a" - 2)
csplit -k -s -n 4 -f ligand temp.pdbqt '/ENDMDL/+1' '{'"$b"'}'
echo " done."

#rename individual docked ligands to include energy of binding and run information
echo ""
echo -n "Extracting energies "
# foreach f (ligand????) 
for f in ligand*
do
		i=$(grep "MODEL" "$f"|sed 's/.dlg:DOCKED://'|awk '{print $1 "_" $3}')
	 	j=$(grep "Estimated Free" "$f"| awk '{printf ("%06.2f \n",$9)}'|sed 's/\./#/g')
	 	k=$(echo "${j}(${i})")
	 	sed 's/.*DOCKED: //' "$f" > PDBQT/"${k}".pdbqt
	 	echo -n ". "
done
rm -rf ligand* && rm -rf temp.pdbqt
echo "Spliting dlg done."

# #create a pseudo-PDB file with all models for quick analysis
# echo -n "Cleaning up . . ."
# sed 's/.*DOCKED: //' temp.pdbqt|cut -c-66 > docked.pdb
# rm -rf temp.pdbqt

# #cleanup - move PDB files to PDB directory and delete all temporary files
# mv PDBQT/*.pdb -t PDB
# echo " done."
# echo ""
# echo ""
# echo "GETLIGANDS successfully terminated: $(date)"
