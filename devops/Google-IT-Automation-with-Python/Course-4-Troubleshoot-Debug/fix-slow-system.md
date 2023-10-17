### Fix a slow system with Python

Introduction

You're an IT administrator for a media production company that uses Network-Attached Storage (NAS) to store all data generated daily (e.g., videos, photos). One of your daily tasks is to back up the data in the production NAS (mounted at /data/prod on the server) to the backup NAS (mounted at /data/prod_backup on the server). A former member of the team developed a Python script (full path /scripts/dailysync.py) that backs up data daily. But recently, there's been a lot of data generated and the script isn't catching up to the speed. As a result, the backup process now takes more than 20 hours to finish, which isn't efficient at all for a daily backup.
What you'll do

    Identify what limits the system performance: I/O, Network, CPU, or Memory
    Use rsync command instead of cp to transfer data
    Get system standard output and manipulate the output
    Find differences between threading and multiprocessing

- CPU bound or I/O Bound
- sudo apt install python3-pip #install pip3 python installer
- psutil #(process and system utilities) is a cross-platform library for retrieving information on running processes and system utilization (CPU, memory, disks, network, sensors) in Python
- pip3 install psutil
- python3
- use psutil to check CPU usage as well as I/O and network bandwidth
- import psutil
- psutil.cpu_percent()
- psutil.disk_io_counters() #check disk i/o
- psutil.net_io_counters() #check network i/o bandwidth. So, you noticed the amount of byte read and byte write for disk I/O and byte received and byte sent for the network I/O bandwidth.
- exit() #exit from python
- rsync(remote sync) is a utility for efficiently transferring and synchronizing files between a computer and an external hard drive and across networked computers by comparing the modification time and size of files
  rsync [Options] [Source-Files-Dir] [Destination]
 -v Verbose output
-q Suppress message output
-a Archive files and directory while synchronizing
-r Sync files and directories recursively
-b Take the backup during synchronization
-z Compress file data during the transfer

- rsync -zvh [Source-Files-Dir] [Destination] #copy or sync files locally
- rsync -zavh [Source-Files-Dir] [Destination] #copy or sync directories locally
- rsync -zrvh [Source-Files-Dir] [Destination] #Copy files and directories recursively locally:

#Subprocess - In order to use the rsync command in Python, use the subprocess module by calling call methods and passing a list as an argument
# import the subprocess module and call the call method and pass the arguments:

import subprocess
src = "<source-path>" # replace <source-path> with the source directory
dest = "<destination-path>" # replace <destination-path> with the destination directory

subprocess.call(["rsync", "-arq", src, dest])

- ls ~/scripts


