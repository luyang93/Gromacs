#!/usr/bin/env python
import os

def main():
    files = os.listdir()
    dir_path = os.getcwd()
    keywords = ['apolar', 'contrib_pol', 'contrib_apol', 'contrib_MM', 'energy_MM', 'polar']
    for keyword in keywords:
        file_paths = []
        for file in files[:]:
            pos = file.find(keyword)
            if pos != -1:
                file_paths.append(os.path.join(dir_path, file))
                files.remove(file)
        file_paths.sort()
        overview = []
        data = []
        for file_path in file_paths:
            with open(file_path) as file:
                lines = file.readlines()
                if not overview:
                    for line in lines:
                        if line.startswith('@') or line.startswith('#'):
                            overview.append(line)
                        else:
                            data.append(line)
                else:
                    for line in lines:
                        if not (line.startswith('@') or line.startswith('#')):
                            data.append(line)
        file_write_path = os.path.join(dir_path, keyword + '.xvg')
        with open(file_write_path, 'w+') as file_write:
            file_write.writelines(overview)
            file_write.writelines(data)

if __name__=="__main__":
        main()