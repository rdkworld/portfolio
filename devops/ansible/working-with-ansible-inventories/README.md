# Working with Ansible Inventories

Introduction
Your company decided that their backup software license was frivolous and unnecessary. Because of this, the license was not renewed. As a stopgap measure, your supervisor has created a simple script and an Ansible playbook to create an archive of select files, depending on pre-defined Ansible host groups. You will create the inventory file to complete the backup strategy.

Solution
Log in to the server using the provided lab credentials:

ssh ansible@<PUBLIC_IP_ADDRESS>
If you are logged in as cloud_user, switch to ansible using the same password provided for cloud_user:

su - ansible
Configure the media Host Group to Contain media1 and media2
Create the inventory file:

touch /home/ansible/inventory
Edit the inventory file:

vim /home/ansible/inventory
Paste in the following:

[media]
media1
media2
To save and exit the file, press ESC, type :wq, and press Enter.

Define Variables for media with Their Accompanying Values
Create a group_vars directory:

mkdir group_vars
Move into the group_vars directory:

cd group_vars/
Create a media file:

touch media
Edit the media file:

vim media
Paste in the following:

media_content: /tmp/var/media/content/
media_index: /tmp/opt/media/mediaIndex
To save and exit the file, press ESC, type :wq, and press Enter.

Configure the webservers Host Group to Contain the Hosts web1 and web2
Move into the home directory:

cd ~
Edit the inventory file:

vim inventory
Beneath media2, paste in the following:

[webservers]
web1
web2
To save and exit the file, press ESC, type :wq, and press Enter.

Define Variables for webservers with Their Accompanying Values
Move into the group_vars directory:

cd group_vars/
Create a webservers file:

touch webservers
Edit the file:

vim webservers
Paste in the following:

httpd_webroot: /var/www/
httpd_config: /etc/httpd/
To save and exit the file, press ESC, type :wq, and press Enter.

Define the script_files Variable for web1 and Set Its Value to /usr/local/scripts
Move into the home directory:

cd ~
Create a host_vars directory:

mkdir host_vars
Move into the host_vars directory:

cd host_vars/
Create a web1 file:

touch web1
Edit the file:

vim web1
Paste in the following:

script_files: /tmp/usr/local/scripts
To save and exit the file, press ESC, type :wq, and press Enter.

Testing
Return to the home directory:

cd ~
Run the backup script:

/home/ansible/scripts/backup.sh
If you have correctly configured the inventory, it should not error.

Conclusion
Congratulations — You've completed this hands-on lab!
