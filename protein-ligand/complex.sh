awk '
        NR == FNR {
                if ( FNR == 2 )
                        lig_atoms = $1
                if ( FNR > 2 )
                        atom[++i] = $0
                next
        }
        {
                if ( FNR == 2 )
                {
                        com_atoms = $1
                        $0 = com_atoms + lig_atoms
                }
                if ( FNR > 2 )
                        ++j
                if ( j > com_atoms )
                {
                        for ( c = 1; c < i; c++ )
                                print atom[c]
                }
                print
        }
' lig.gro protein.gro