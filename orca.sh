#!/bin/bash
# A script to calculate RESP charge based on Gaussian and Multiwfn
# Written by Tian Lu (sobereva@sina.com), 2019-Apr-17
# Example usage: RESP.sh H2O.xyz 0 1

# Modified by Aster Wang (march_happy@njucm.edu.cn), 2019-Nov-09
# Always believe something pawsome is about to happen🐾🐾
# For orca usage
# Sigh... I really hope that I have the money to get a better HPC

# CITATION NOTICE
# Anyone using this script shall remember to cite Multiwfn
# (http://sobereva.com/multiwfn/)
# Tian Lu, Feiwu Chen, Multiwfn: A multifunctional wavefunction analyzer, J. Comput. Chem., 33, 580-592 (2012)
# http://onlinelibrary.wiley.com/doi/10.1002/jcc.22885/abstract
# And orca (https://orcaforum.kofo.mpg.de/viewtopic.php?f=18&t=2297)
# Neese, F.“The ORCA program system” Wiley interdisciplinary Reviews - Computational Molecular Science, 2012, Vol 2., Issue 1, Pages 73–78
# Please do NOT just cite the generic ORCA reference given above but also cite in addition their original papers! 

# keyword_opt="# B3LYP/def2SVP em=GD3BJ scrf(solvent=water) opt"
## 为什么用 B3LYP：http://sobereva.com/441
## 看过一些RESP相关文章的人会知道，早年间计算RESP电荷都是在HF/6-31G*下算的（包括优化和静电势计算）。而且，用Antechamber产生Gaussian输入文件的时候里面自带的关键词也是对应HF/6-31G*的。这是因为，早年间，隐式溶剂模型还没特别成熟和流行，而人们又已经发现，HF/6-31G*下计算的有机小分子的偶极矩一般会被高估百分之十几，而分子在水环境中由于电荷被极化，偶极矩也会增加百分之十几，于是当时人们就刻意用看起来很垃圾的HF/6-31G*去算拟合静电势电荷，这样得到的电荷相当于已经近似等效地反映了水对此分子的电荷产生的极化效果。但是，这种做法在现在来看已经不合时宜了，毕竟隐式溶剂模型都那么成熟了，而且对耗时也就增加20%左右，直接通过隐式溶剂模型体现溶剂对溶质电荷的极化效果远比用HF/6-31G*来试图近似体现这个效果严格、优雅得多。而且抛开静电势不谈，HF/6-31G*优化的几何结构也是挺烂的。AMBER力场开发者早就明白了这一点，因此从AMBER03开始，他们计算RESP电荷时从之前的HF/6-31G*改为了B3LYP/cc-pVTZ（注：cc-pVTZ结合DFT是很不划算的，这在《谈谈量子化学中基组的选择》中特意提了，故大家别这么用）。虽然现在还有文章的作者拘泥于传统或者由于是外行的缘故，还在用HF/6-31G*计算RESP电荷，但大家千万别去效仿。 
## http://sobereva.com/336（《谈谈量子化学中基组的选择》）
## 在陆杨(GitHub: luyang93)的旧脚本里，调用的是 ambertools，然后 gjf 文件里用的是 HF
## 因此，在我修订后的脚本里，用了 scrf(solvent=water) 指定隐式溶剂模型，使用 B3LYP

# 限制内存以及核心数占用
max_mem_per_core=3000
core_number=2
ORCA_PATH=$(which orca)

## For Orca
# I
# keyword_opt="
# ! B3LYP D3 def2-TZVP def2/J RIJCOSX noautostart miniprint nopop TightSCF
# ! CPCM
# %cpcm
# SMD true
# SMDSolvent "WATER"
# end
# %maxcore $max_mem_per_core
# %pal nprocs $core_number end
# "
# Reference for d3: http://sobereva.com/210，*在ORCA中使用DFT-D校正*一节
# 应该和 em=GD3BJ 一致


# 原来的另外一个关键字
# keyword_SP="# B3LYP/def2TZVP em=GD3BJ scrf(solvent=water) pop=CHELPG IOp(6/33=2,6/42=6)"
## The IOp keyword allows the user to set internal options (variables in system common /IOp/) to specific values.
## Sorry that for orca there seems to be no option on this, so I have to ignore this.
## *IOp(6/33=2) 输出拟合静电势时的点（单位为埃）和每个点的精确静电势(a.u.)。
## *IOp(6/42=N) 拟合ESP电荷时每单位面积的点为N个，默认N=1。17时每个原子大概用2500个点，对于大分子可以稍微降低这个值以减少计算量。

## For Orca
# keyword_SP="
# ! B3LYP def2-TZVP d3
## Orca's CHELPG usage is defined at Page 740 or 9.33.2 orca_chelpg in their manual
## Available at https://cec.mpg.de/fileadmin/media/Forschung/ORCA/orca_manual_4_0_1.pdf
# ! CHELPG
# %cosmo smd true
#         solvent “WATER” end

# 配置
export inname=$1
filename=${inname%.*}
suffix=${inname##*.}
if [ $2 ];then
	echo "Net charge = $2"
	chg=$2
else
	echo "Net charge was not defined. Default to 0"
	chg=0
fi
if [ $3 ];then
	echo "Spin multiplicity = $3"
	multi=$3
else
	echo "Spin multiplicity was not defined. Default to 1"
	multi=1
fi

## Multiwfn Pre-processing

# Exporting input .pdb to .xyz for later usage in generating .inp orca input file
Multiwfn $1 > /dev/null << EOF
100
2
2
opt.xyz
0
-10
EOF
# 100 Other functions (Part1)
# 2 Export .pdb/.xyz/.wfn/.wfx/.molden/.fch/.47 files or input file of QC codes
# 2 Output current structure to .xyz file
# So input would be converted into temp.xyz
# 0 Return
# -10 Exit

sed -i '1,2d' opt.xyz

cat > opt.inp << EOL
! B3LYP D3 def2-TZVP def2/J RIJCOSX noautostart miniprint nopop TightSCF
! CPCM
%cpcm
SMD true
SMDSolvent "WATER"
end
%maxcore $max_mem_per_core
%pal nprocs $core_number end
* xyz    $chg    $multi
EOL

cat opt.xyz >> opt.inp

echo "*" >> opt.inp

echo Running ORCA...
$ORCA_PATH opt.inp >> ORCA.log

# formchk gau.chk> /dev/null
echo Running orca_2mkl

orca_2mkl opt -molden
## A similar tool to formchk
# orca_2mkl xxx -molden
## This converts xxx.gbw to xxx.molden.input for later usage in Multiwfn

echo Running Multiwfn...

# # If you bought genuine Gaussian, you could use cubegen to speed up the calculation
# # More info: http://bbs.keinsci.com/thread-12858-2-1.html
# Multiwfn opt.molden.input > /dev/null << EOF
# 1000
# 10
# $core_number
# 100
# 2
# 7
# opt.fch
# 0
# -10
# EOF


# Multiwfn opt.fch > /dev/null << EOF
# 1000
# 10
# $core_number
# 7
# 18
# 1
# opt.molden.input
# y
# 0
# 0
# -10
# EOF

# If you don't have Gaussian
Multiwfn opt.molden.input > /dev/null << EOF
1000
10
$core_number
7
18
1
opt.molden.input
y
0
0
-10
EOF

# rm -r tmp.xyz gau.gjf gau.fchk gau.chk gau.out
# chgname=${1//$suffix/chg}
# mv gau.chg $chgname

echo Finished!

# echo Finished! The optimized atomic coordinates with RESP charges \(the last column\) have been exported to $chgname in current folder
