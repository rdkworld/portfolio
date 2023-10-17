## Objective

You're an IT professional who's in charge of the deployment and maintenance of software in your company's fleet. A piece of software that's deployed on all machines in your fleet is throwing an error on a number of these machines. You haven't written the software and don't have access to the source code. You'll need to examine the environment where the software is running in and try to work out what's going on.
What you'll do

    Understand the error messages
    Track down the root cause and work to fix it
    Understand what to do when you can't modify the program that's throwing errors
    
 # Commands
 
 - cd / #change to root directory
 - cd ~ #change to working directory
 - python <filename> #run python program
 - sudo apt install python3-pip #install pip
 - pip3 install matplotlib #install matplotlib
 - mv <old file> <new file> #rename file
 - sudo chmod 777 ~/data.csv #give write persmissions to file
    
### Problem Statement
In order to fix this issue, open the start_date_report.py script using nano editor. Now, modify the get_same_or_newer() function to preprocess the file, so that the output generated can be used for various dates instead of just one.
This is a pretty challenging task that you have to complete by modifying the get_same_or_newer() function.

Here are few hints to fix this issue:

    Download the file only once from the URL.

    Pre-process it so that the same calculation doesn't need to be done over and over again. This can be done in two ways. You can choose any one of them:

    To create a dictionary with the start dates and then use the data in the dictionary instead of the complicated calculation.
    To sort the data by start_date and then go date by date.

Choose any one of the above preprocessing options and modify the script accordingly
