#!/usr/bin/env python
import subprocess
import os
from multiprocessing import Pool
import multiprocessing

home_path = os.path.expanduser('~')
src = home_path + "/data/prod/"
dest = home_path + "/data/prod_backup/"

if __name__ == "__main__":
        pool=Pool(multiprocessing.cpu_count())
        pool.apply(subprocess.call,args=(["rsync", "-arq", src, dest],))

#tasks=[]
#for root, dir, files in os.walk("/home/student-01-c497ef066349/data/prod/","to$
#       print(files)

#print("Tasks are : ")
