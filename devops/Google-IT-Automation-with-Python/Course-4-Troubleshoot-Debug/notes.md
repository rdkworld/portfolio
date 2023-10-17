### Commands

* ltrace ./program.py # trace library calls
* strace ./program.py # trace system calls
* less
* strace -o # less will go end of file, shift G will take to end and then scroll up
* Some tools to use for troubleshooting and debugging : top, strace, tcpdump, ltrace, wireshark
* tcpdump, wireshark #analyze network traffic

* head -<no of records> filename | ./import.py --server test #display first records, feed as input to program running on test server
  
## Lab

Imagine one of your colleagues has written a Python script that's failing to run correctly. They're asking for your help to debug it. In this lab, you'll look into why the script is crashing and apply the problem-solving steps that we've already learned to get information, find the root cause, and remediate the problem.

### Commands again

* cd ~/<folder name> #change to this folder from home
* ls #list files
* cat <filename> #view contents of the file
* sudo chmod 777 <filename> #update permissions
