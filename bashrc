# modify for the rm to move all files to Trash
alias rm="trash"
alias RM="trash" 
alias trash-rm="/bin/rm -rf $HOME/.local/share/Trash/files/"
alias rm-trash="/bin/rm -rf $HOME/.local/share/Trash/files/"
alias rm-trash-root="/bin/rm -rf /root/.local/share/Trash/files/"

# MGLTools
export PATH='/opt/MGLTools-1.5.6/bin:'$PATH

# MATLAB
alias MATLAB='/opt/MATLAB/R2018a/bin/glnxa64/MATLAB'

# 禁止笔记本键盘##
alias keyboard='xinput set-prop 15 "Device Enabled" 0'

# pymol
alias pymol='/opt/pymol/pymol'

# gromacs
source /opt/gromacs/bin/GMXRC

# g_mmpbsa
export PATH=${PATH}:/opt/g_mmpbsa/bin
export GMXLIB=/opt/gromacs/share/gromacs/top

# Gaussian09 GaussView
export g09root=/opt
export GAUSS_SCRDIR=$g09root/g09/scratch
source $g09root/g09/bsd/g09.profile
export GV_DIR=$g09root/gv
