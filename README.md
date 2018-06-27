Gromacs
---------

`Gromacs` `Gaussian 09` `AmberTools 18` `acpype` `g_mmpbsa` `MATLAB` `Python`

---------

[蛋白质配体复合物的示例结果](https://luyang93.github.io/example-result-of-gromacs/)

[项目地址](https://github.com/luyang93/Gromacs)

## 使用Gromacs进行蛋白质配体复合物的分子动力学模拟

* 脚本
    * resp.sh:自动生成RESP电荷
    * md.sh:自动选择AMBER99SB-ILDN力场和TIP3P水模型，选择dodecahedron盒子，添加0.15M的NaCl，调整体系至电中性，进行能量最小化，NVT平衡，NPT平衡，进行Production MD
    * analysis.sh:自动对结果进行初步分析
    * pbsa.sh:自动采用MM/PBSA的方式分解能量，获得VdW、Elec、Pol、Apol、Binding能量。  

* 使用方法
    * ```bash ../resp.sh 2>&1 | tee resp.log```  
    * ```bash ../md.sh 2>&1 | tee md.log```  
    * ```bash ../analysis.sh 2>&1 | tee analysis.log```  
    * ```bash ../pbsa.sh 2>&1 | tee pbsa.log```  

mkdir 0 && screen -S 0  
cd 0  
echo "1 13" | g_mmpbsa -f ../md_0_1_mol_center.xtc -s ../md_0_1.tpr -n ../index.ndx -i ../pbsa.mdp -pdie 2 -pbsa -decomp -b 0 -e 5000 -dt 10 -mm energy_MM_00000_05000.xvg -pol polar_00000_05000.xvg -apol apolar_00000_05000.xvg -mmcon contrib_MM_00000_05000.dat -pcon contrib_pol_00000_05000.dat -apcon contrib_apol_00000_05000.dat

mkdir 1 && screen -S 1  
cd 1  
echo "1 13" | g_mmpbsa -f ../md_0_1_mol_center.xtc -s ../md_0_1.tpr -n ../index.ndx -i ../pbsa.mdp -pdie 2 -pbsa -decomp -b 5010 -e 10000 -dt 10 -mm energy_MM_05010_10000.xvg -pol polar_05010_10000.xvg -apol apolar_05010_10000.xvg -mmcon contrib_MM_05010_10000.dat -pcon contrib_pol_05010_10000.dat -apcon contrib_apol_05010_10000.dat 

mkdir 2 && screen -S 2  
cd 2  
echo "1 13" | g_mmpbsa -f ../md_0_1_mol_center.xtc -s ../md_0_1.tpr -n ../index.ndx -i ../pbsa.mdp -pdie 2 -pbsa -decomp -b 10010 -e 15000 -dt 10 -mm energy_MM_10010_15000.xvg -pol polar_10010_15000.xvg -apol apolar_10010_15000.xvg -mmcon contrib_MM_10010_15000.dat -pcon contrib_pol_10010_15000.dat -apcon contrib_apol_10010_15000.dat 

mkdir 3 && screen -S 3  
cd 3  
echo "1 13" | g_mmpbsa -f ../md_0_1_mol_center.xtc -s ../md_0_1.tpr -n ../index.ndx -i ../pbsa.mdp -pdie 2 -pbsa -decomp -b 15010 -e 20000 -dt 10 -mm energy_MM_15010_20000.xvg -pol polar_15010_20000.xvg -apol apolar_15010_20000.xvg -mmcon contrib_MM_15010_20000.dat -pcon contrib_pol_15010_20000.dat -apcon contrib_apol_15010_20000.dat 

## 正常运行需要的各种文件
complex.sh:组合lig.gro和protein.gro  
em_backup.mdp:em.mdp的备份,adding ions  
em_real.mdp:energy minimization  
leap.in:ambertools->gromacs  
lig.gro:由acpype生成，配体结构  
lig.itp:由acpype生产，配体resp电荷  
md_backup.mdp:md.mdp的备份,molecular dynamic的方法文件  
MmPbSaDecomp.py:Contribution of residues to the binding energy  
MmPbSaStat.py:Average Binding Energy Calculation  
ntp.mdp:NPT平衡的方法文件  
nvp.mdp:NVT平衡的方法文件  
pbsa.mdp:mmpbsa能量分解的方法文件  
protein.pdb:蛋白质结构文件  
