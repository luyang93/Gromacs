#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# @File    : merge.py
# @Date    : 18-10-30
# @Author  : luyang(luyang@novogene.com)
import os
import argparse
import glob


def parse_input():
    parser = argparse.ArgumentParser(description='merge apolar energy_MM polar contrib_apol contrib_MM contrib_pol files')
    parser.add_argument('-p', '--filepath', dest='filepath', required=True, help='path to protein-ligand pair folder')
    args = parser.parse_args()
    return args


def main():
    args = parse_input()
    filepath = args.filepath
    energies = ['apolar','energy_MM','polar']
    contribs = ['contrib_apol','contrib_MM','contrib_pol']
    data = {}
    header = {}
    for energy in energies:
        tmp = energy + '?*.xvg'
        data[energy] = []
        header[energy] = []
        files = glob.glob(os.path.join(filepath, '*', tmp))
        files.sort()
        for file in files:
            with open(file,'r') as f:
                lines = f.readlines()
                for line in lines:
                    if line.startswith('#') or line.startswith('@'):
                        if len(data[energy]) == 0:
                            header[energy].append(line)
                    else:
                        data[energy].append(line)
        tmp = energy + '.xvg'
        with open(os.path.join(filepath, 'analysis', tmp),'w') as f:
            for line in header[energy]:
                f.write(line)
            for line in data[energy]:
                f.write(line)
    for contrib in contribs:
        tmp = contrib + '?*.dat'
        data[contrib] = []
        header[contrib] = []
        files = glob.glob(os.path.join(filepath, '*', tmp))
        files.sort()
        for file in files:
            with open(file,'r') as f:
                lines = f.readlines()
                for line in lines:
                    if line.startswith('#') or line.startswith('@'):
                        if len(data[contrib]) == 0:
                            header[contrib].append(line)
                    else:
                        data[contrib].append(line)
        tmp = contrib + '.dat'
        with open(os.path.join(filepath, 'analysis', tmp),'w') as f:
            for line in header[contrib]:
                f.write(line)
            for line in data[contrib]:
                f.write(line)


if __name__ == "__main__":
    main()
