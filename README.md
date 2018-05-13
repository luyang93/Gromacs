Gromacs
___

`Gromacs` `aussian 09` `AmberTools 18` `acpype` `g_mmpbsa` `MATLAB` `Python`

---------
正常运行需要的各种文件

gromacs正常运行需要的各种文件。 

complex.sh:组合lig.gro和protein.gro

em_backup.mdp:em.mdp的备份,adding ions

em_real.mdp:energy minimization

leap.in:ambertools->gromacs

lig.gro:由acpype生成，配体结构

lig.itp:由acpype生产，配体resp电荷

md_backup.mdp:md.mdp的备份,molecular 
dynamic的方法文件

MmPbSaDecomp.py:Contribution of residues to the binding energy

MmPbSaStat.py:Average Binding Energy Calculation

ntp.mdp:NPT平衡的方法文件

nvp.mdp:NVT平衡的方法文件

pbsa.mdp:mmpbsa能量分解的方法文件

protein.pdb:蛋白质结构文件