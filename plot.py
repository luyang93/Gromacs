#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# @File    : plot.py
# @Date    : 18-10-30
# @Author  : luyang(luyang@novogene.com)
import os
import argparse
from matplotlib import ticker
import matplotlib.pyplot as plt

def parse_input():
    parser = argparse.ArgumentParser(description='draw line charts')
    parser.add_argument('-p', '--filepath', dest='filepath', required=True, help='path to protein-ligand pair folder')
    args = parser.parse_args()
    return args

def main():
    args = parse_input()
    filepath = args.filepath

    # potential
    potential_file = os.path.join(filepath,'analysis','potential.xvg')
    with open(potential_file,'r') as f:
        time = []
        potential = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(int(float(cols[0])))
                    potential.append(float(cols[1]))
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.set_title("Energy Minimization")
        ax.set_xlabel('Energy Minimization Step')
        ax.set_ylabel('Potentail Energy$(kJ·mol^{-1})$')
        ax.plot(time, potential, c='k', label='Potential')
        formatter = ticker.ScalarFormatter(useMathText=True)
        formatter.set_scientific(True)
        formatter.set_powerlimits((-1, 1))
        ax.yaxis.set_major_formatter(formatter)
        ax.legend()
        plt.savefig(os.path.join(filepath,'analysis','potential.svg'))

    # temperature
    temperature_file = os.path.join(filepath, 'analysis', 'temperature.xvg')
    with open(temperature_file, 'r') as f:
        time = []
        temperature = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(int(float(cols[0])))
                    temperature.append(float(cols[1]))
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.set_title("Temperature")
        ax.set_xlabel('Time$(ps)$')
        ax.set_ylabel('Temperature$(K)$')
        ax.plot(time, temperature, c='k', label='Temperature')
        # formatter = ticker.ScalarFormatter(useMathText=True)
        # formatter.set_scientific(True)
        # formatter.set_powerlimits((-1, 1))
        # ax.yaxis.set_major_formatter(formatter)
        ax.legend()
        plt.savefig(os.path.join(filepath, 'analysis', 'temperature.svg'))

    # pressure
    pressure_file = os.path.join(filepath, 'analysis', 'pressure.xvg')
    with open(pressure_file, 'r') as f:
        time = []
        pressure = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(int(float(cols[0])))
                    pressure.append(float(cols[1]))
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.set_title("Pressure")
        ax.set_xlabel('Time$(ps)$')
        ax.set_ylabel('Pressure$(bar)$')
        ax.plot(time, pressure, c='k', label='Pressure')
        # formatter = ticker.ScalarFormatter(useMathText=True)
        # formatter.set_scientific(True)
        # formatter.set_powerlimits((-1, 1))
        # ax.yaxis.set_major_formatter(formatter)
        ax.legend()
        plt.savefig(os.path.join(filepath, 'analysis', 'pressure.svg'))


    # density
    density_file = os.path.join(filepath, 'analysis', 'density.xvg')
    with open(density_file, 'r') as f:
        time = []
        density = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(int(float(cols[0])))
                    density.append(float(cols[1]))
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.set_title("Density")
        ax.set_xlabel('Time$(ps)$')
        ax.set_ylabel('Density$(kg·m^{-3})$')
        ax.plot(time, density, c='k', label='Density')
        # formatter = ticker.ScalarFormatter(useMathText=True)
        # formatter.set_scientific(True)
        # formatter.set_powerlimits((-1, 1))
        # ax.yaxis.set_major_formatter(formatter)
        ax.legend()
        plt.savefig(os.path.join(filepath, 'analysis', 'density.svg'))

    # RMSD
    rmsd_file = os.path.join(filepath, 'analysis', 'rmsd.xvg')
    with open(rmsd_file, 'r') as f:
        time = []
        rmsd = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(float(cols[0]))
                    rmsd.append(float(cols[1]))
    rmsd_xtal_file = os.path.join(filepath, 'analysis', 'rmsd_xtal.xvg')
    with open(rmsd_xtal_file, 'r') as f:
        time = []
        rmsd_xtal = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(float(cols[0]))
                    rmsd_xtal.append(float(cols[1]))
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.set_title("RMSD")
    ax.set_xlabel('Time$(ns)$')
    ax.set_ylabel('RMSD$(nm)$')
    ax.plot(time, rmsd, c='k', label='Ref:Equilibrated')
    ax.plot(time, rmsd_xtal, c='r', label='Ref:Crystal')
    # formatter = ticker.ScalarFormatter(useMathText=True)
    # formatter.set_scientific(True)
    # formatter.set_powerlimits((-1, 1))
    # ax.yaxis.set_major_formatter(formatter)
    ax.legend()
    plt.savefig(os.path.join(filepath, 'analysis', 'rmsd.svg'))

    # # gyrate
    # gyrate_file = os.path.join(filepath, 'analysis', 'gyrate.xvg')
    # with open(gyrate_file, 'r') as f:
    #     time = []
    #     gyrate = []
    #     for line in f.readlines():
    #         if line.startswith('#') or line.startswith('@'):
    #             continue
    #         else:
    #             cols = line.split()
    #             if len(cols) == 2:
    #                 time.append(int(float(cols[0])))
    #                 gyrate.append(float(cols[1]))
    #     fig = plt.figure()
    #     ax = fig.add_subplot(111)
    #     ax.set_title("Radius of gyration")
    #     ax.set_xlabel('Time$(ns)$')
    #     ax.set_ylabel('$R_{g}(nm)$')
    #     ax.plot(time, gyrate, c='k', label='')
    #     # formatter = ticker.ScalarFormatter(useMathText=True)
    #     # formatter.set_scientific(True)
    #     # formatter.set_powerlimits((-1, 1))
    #     # ax.yaxis.set_major_formatter(formatter)
    #     ax.legend()
    #     plt.savefig(os.path.join(filepath, 'analysis', 'gyrate.svg'))

    # RMSF
    rmsf_file = os.path.join(filepath, 'analysis', 'rmsf.xvg')
    with open(rmsf_file, 'r') as f:
        time = []
        rmsf = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(float(cols[0]))
                    rmsf.append(float(cols[1]))
    rmsf_xtal_file = os.path.join(filepath, 'analysis', 'rmsf_xtal.xvg')
    with open(rmsf_xtal_file, 'r') as f:
        time = []
        rmsf_xtal = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 2:
                    time.append(float(cols[0]))
                    rmsf_xtal.append(float(cols[1]))
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.set_title("RMSF")
    ax.set_xlabel('Atom')
    ax.set_ylabel('$RMSF(nm)$')
    ax.plot(time, rmsf, c='k', label='Ref:Equilibrated')
    ax.plot(time, rmsf_xtal, c='r', label='Ref:Crystal')
    # formatter = ticker.ScalarFormatter(useMathText=True)
    # formatter.set_scientific(True)
    # formatter.set_powerlimits((-1, 1))
    # ax.yaxis.set_major_formatter(formatter)
    ax.legend()
    plt.savefig(os.path.join(filepath, 'analysis', 'rmsf.svg'))

    # hbnum
    hbnum_file = os.path.join(filepath, 'analysis', 'hbnum.xvg')
    with open(hbnum_file, 'r') as f:
        time = []
        hbnum = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 3:
                    time.append(int(float(cols[0])))
                    hbnum.append(int(float(cols[1])))
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.set_title("Hydrogen Bond Number")
        ax.set_xlabel('Time$(ps)$')
        ax.set_ylabel('Hydrogen bonds')
        ax.scatter(time, hbnum, c='k', label='')
        # formatter = ticker.ScalarFormatter(useMathText=True)
        # formatter.set_scientific(True)
        # formatter.set_powerlimits((-1, 1))
        # ax.yaxis.set_major_formatter(formatter)
        # ax.legend()
        plt.savefig(os.path.join(filepath, 'analysis', 'hbnum.svg'))

    # full_energy
    full_energy_file = os.path.join(filepath, 'analysis', 'full_energy.dat')
    with open(full_energy_file, 'r') as f:
        time = []
        E_VdW = []
        E_Elec = []
        E_Pol = []
        E_Apol = []
        E_Binding = []
        for line in f.readlines():
            if line.startswith('#') or line.startswith('@'):
                continue
            else:
                cols = line.split()
                if len(cols) == 17:
                    time.append(int(float(cols[0])))
                    E_VdW.append(float(cols[9])-float(cols[1])-float(cols[5]))
                    E_Elec.append(float(cols[10])-float(cols[2])-float(cols[6]))
                    E_Pol.append(float(cols[11]) - float(cols[3]) - float(cols[7]))
                    E_Apol.append(float(cols[12])-float(cols[4])-float(cols[8]))
                    E_Binding.append(E_VdW[-1]+ E_Elec[-1]+E_Pol[-1]+E_Apol[-1])
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.set_title("Energy")
        ax.set_xlabel('Time$(ps)$')
        ax.set_ylabel('Energy$(kJ·mol^{-1})$')
        ax.plot(time, E_VdW, c='b', label='VdW')
        ax.plot(time, E_Elec, c='g', label='Elec')
        ax.plot(time, E_Pol, c='y', label='Pol')
        ax.plot(time, E_Apol, c='k', label='Apol')
        ax.plot(time, E_Binding, c='r', label='Binding')
        # formatter = ticker.ScalarFormatter(useMathText=True)
        # formatter.set_scientific(True)
        # formatter.set_powerlimits((-1, 1))
        # ax.yaxis.set_major_formatter(formatter)
        ax.legend()
        plt.savefig(os.path.join(filepath, 'analysis', 'full_energy.svg'))

if __name__ == "__main__":
    main()