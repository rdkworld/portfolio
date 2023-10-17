## Commands

1. sudo systemctl status apache2 #check status of server
2. sudo systemctl restart apache2 #restart apache server
3. sudo netstat -nlp #To find which processes are listening on which ports, we'll be using the netstat command, which returns network-related information. Here, we'll be using a combination of flags along with the netstat command to check which process is using a particular port
4. ps -ax | grep python3 #Let's find out which python3 program this is by using the following command:
5. cat /usr/local/bin/jimmytest.py
6. sudo kill [process-id] #kill a process
7. sudo systemctl --type=service | grep jimmy #let's check for the availability of any service with the keywords "python" or "jimmy".
8. sudo systemctl stop jimmytest && sudo systemctl disable jimmytest #stop and disable a service






## Basics

1. HTTP Status Codes

    Informational responses (100–199)
    Successful responses (200–299)
    Redirects (300–399)
    Client errors (400–499)
    Server errors (500–599)

2. systemctl utility
systemctl is a utility for controlling the systemd system and service manager. It comes with a long list of options for different functionality, including starting, stopping, restarting, or reloading a daemon.
Introduction

You're an IT administrator in a small-sized startup that runs a web server named ws01 in the cloud. One day, when you try to access the website served by ws01, you get an HTTP Error 500. Since your deployment is still in an early stage, you suspect a developer might have used this server to do some testing or run some experiments. Now you need to troubleshoot ws01, find out what's going on, and get the service back to a healthy state.
Error detection

Open the website served by ws01 by typing the external IP address of ws01 in a web browser. The external IP address of ws01 can be found in the Connection Details Panel on the left-hand side.

7c06c682fbd7a744.png

You should now find 500 Internal Server Error! on the webpage. Later, during this lab, you'll troubleshoot this issue.
What you'll do

    Understand what http status code means
    Learn how to check port status with the netstat command
    Learn how to manage services with the systemctl command
    Know how to monitor system resources and identify the root cause of an issue

You'll have 90 minutes to complete this lab.
Start the lab

You'll need to start the lab before you can access the materials in the virtual machine OS. To do this, click the green “Start Lab” button at the top of the screen.
Note: For this lab you are going to access the Linux VM through your local SSH Client, and not use the Google Console (Open GCP Console button is not available for this lab).

Start Lab

After you click the “Start Lab” button, you will see all the SSH connection details on the left-hand side of your screen. You should have a screen that looks like this:

Connection details
Accessing the virtual machine

Please find one of the three relevant options below based on your device's operating system.
Note: Working with Qwiklabs may be similar to the work you'd perform as an IT Support Specialist; you'll be interfacing with a cutting-edge technology that requires multiple steps to access, and perhaps healthy doses of patience and persistence(!). You'll also be using SSH to enter the labs -- a critical skill in IT Support that you’ll be able to practice through the labs.
Option 1: Windows Users: Connecting to your VM

In this section, you will use the PuTTY Secure Shell (SSH) client and your VM’s External IP address to connect.

Download your PPK key file

You can download the VM’s private key file in the PuTTY-compatible PPK format from the Qwiklabs Start Lab page. Click on Download PPK.

PPK

Connect to your VM using SSH and PuTTY

    You can download Putty from here

    In the Host Name (or IP address) box, enter username@external_ip_address.

Note: Replace username and external_ip_address with values provided in the lab.

Putty_1

    In the Category list, expand SSH.

    Click Auth (don’t expand it).

    In the Private key file for authentication box, browse to the PPK file that you downloaded and double-click it.

    Click on the Open button.

Note: PPK file is to be imported into PuTTY tool using the Browse option available in it. It should not be opened directly but only to be used in PuTTY.

Putty_2

    Click Yes when prompted to allow a first connection to this remote SSH server. Because you are using a key pair for authentication, you will not be prompted for a password.

Common issues

If PuTTY fails to connect to your Linux VM, verify that:

    You entered <username>@<external ip address> in PuTTY.

    You downloaded the fresh new PPK file for this lab from Qwiklabs.

    You are using the downloaded PPK file in PuTTY.

Option 2: OSX and Linux users: Connecting to your VM via SSH

Download your VM’s private key file.

You can download the private key file in PEM format from the Qwiklabs Start Lab page. Click on Download PEM.

PEM

Connect to the VM using the local Terminal application

A terminal is a program which provides a text-based interface for typing commands. Here you will use your terminal as an SSH client to connect with lab provided Linux VM.

    Open the Terminal application.

        To open the terminal in Linux use the shortcut key Ctrl+Alt+t.

        To open terminal in Mac (OSX) enter cmd + space and search for terminal.

    Enter the following commands.

Note: Substitute the path/filename for the PEM file you downloaded, username and External IP Address.

You will most likely find the PEM file in Downloads. If you have not changed the download settings of your system, then the path of the PEM key will be ~/Downloads/qwikLABS-XXXXX.pem

chmod 600 ~/Downloads/qwikLABS-XXXXX.pem

ssh -i ~/Downloads/qwikLABS-XXXXX.pem username@External Ip Address

SSH
Option 3: Chrome OS users: Connecting to your VM via SSH
Note: Make sure you are not in Incognito/Private mode while launching the application.

Download your VM’s private key file.

You can download the private key file in PEM format from the Qwiklabs Start Lab page. Click on Download PEM.

PEM

Connect to your VM

    Add Secure Shell from here to your Chrome browser.

    Open the Secure Shell app and click on [New Connection].

    new-connection-button

    In the username section, enter the username given in the Connection Details Panel of the lab. And for the hostname section, enter the external IP of your VM instance that is mentioned in the Connection Details Panel of the lab.

    username-hostname-fields

    In the Identity section, import the downloaded PEM key by clicking on the Import… button beside the field. Choose your PEM key and click on the OPEN button.

Note: If the key is still not available after importing it, refresh the application, and select it from the Identity drop-down menu.

    Once your key is uploaded, click on the [ENTER] Connect button below.

    import-button

    For any prompts, type yes to continue.

    You have now successfully connected to your Linux VM.

You're now ready to continue with the lab!
Debug the issue

HTTP response status codes indicate whether a specific HTTP request has been successfully completed. Responses are grouped into five classes:

    Informational responses (100–199)
    Successful responses (200–299)
    Redirects (300–399)
    Client errors (400–499)
    Server errors (500–599)

The HyperText Transfer Protocol (HTTP) 500 Internal Server Error response code indicates that the server encountered an unexpected condition that prevented it from fulfilling the request. Before troubleshooting the error, you'll need to understand more about systemctl.

systemctl is a utility for controlling the systemd system and service manager. It comes with a long list of options for different functionality, including starting, stopping, restarting, or reloading a daemon.

Let's now troubleshoot the issue. Since the webpage returns an HTTP error status code, let's check the status of the web server i.e apache2.

sudo systemctl status apache2

The command outputs the status of the service.

Output:

76bfa8d2ef7267c6.png

The outputs say "Failed to start The Apache HTTP Server." This might be the reason for the HTTP error status code displayed on the webpage. Let's try to restart the service using the following command:

sudo systemctl restart apache2

Output:

7cf73074f22869df.png

Hmm this command also fails. Let's check the status of the service again and try to find the root cause of the issue.

sudo systemctl status apache2

Output:

e626c7b09e432c.png

Take a close look at the output. There's a line stating "Address already in use: AH00072: make_sock: could not bind to address [::]:80." The Apache webserver listens for incoming connection and binds on port 80. But according to the message displayed, port 80 is being used by the other process, so the Apache web server isn't able to bind to port 80.

To find which processes are listening on which ports, we'll be using the netstat command, which returns network-related information. Here, we'll be using a combination of flags along with the netstat command to check which process is using a particular port:

sudo netstat -nlp

Output:

54ea7071245dab5a.png

You can see a process ID (PID) and an associated program name that's using port 80. A python3 program is using the port.

Note: Jot down the PID of the python3 program in your local text editor, which will be used later in the lab.

Let's find out which python3 program this is by using the following command:

ps -ax | grep python3

Output:

baaba68e0f7de572.png

There is a list of python3 processes displayed here. Now, look out for the PID of the process we're looking for and match it with the one that's using port 80 (output from netstat command).

You can now obtain the script /usr/local/bin/jimmytest.py by its PID, which is actually using port 80.

Have a look at the code using the following command:

cat /usr/local/bin/jimmytest.py

This is indeed a test written by developers, and shouldn't be taking the default port.

Let's kill the process created by /usr/local/bin/jimmytest.py by using the following command:

sudo kill [process-id]

Replace [process-id] with the PID of the python3 program that you jotted down earlier in the lab.

List the processes again to find out if the process we just killed was actually terminated.

ps -ax | grep python3

This time you'll notice that similar process running again with a new PID.

This kind of behavior should be caused by service. Since this is a python script created by Jimmy, let's check for the availability of any service with the keywords "python" or "jimmy".

sudo systemctl --type=service | grep jimmy

Output:

c711e79f3c7659f4.png

There is a service available named jimmytest.service. We should now stop and disable this service using the following command:

sudo systemctl stop jimmytest && sudo systemctl disable jimmytest

Output:

434c12adbfcd13c8.png

The service is now removed.

To confirm that no processes are listening on 80, using the following command:

sudo netstat -nlp

Output:

46025a35569159e5.png

Since there are no processes listening on port 80, we can now start apache2 again.

sudo systemctl start apache2

Refresh the browser tab that showed 500 Internal Server Error! Or you can open the webpage by typing the external IP address of ws01 in a new tab of the web browser. The external IP address of ws01 can be found in the Connection Details Panel on the left-hand side.
anel on the left-hand side.

2b6a6713657ce18f.png

You should now be able to see the Apache2 Ubuntu Default Page
