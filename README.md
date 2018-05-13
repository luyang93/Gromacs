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
    * ```sh ../resp.sh 2>&1 | tee resp.log```  
    * ```sh ../md.sh 2>&1 | tee md.log```  
    * ```sh ../analysis.sh 2>&1 | tee analysis.log```  
    * ```sh ../pbsa.sh 2>&1 | tee pbsa.log```  

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
