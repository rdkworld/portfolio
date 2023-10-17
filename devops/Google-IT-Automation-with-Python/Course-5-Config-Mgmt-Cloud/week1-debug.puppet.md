### Commands

1. echo $PATH
2. ls /
3. export PATH=/bin:/usr/bin #manually add directories to path
4. cd /etc/puppet/code/environments/production/modules/profile/manifests #manifests directory
5. cat init.pp
6. sudo nano init.pp
7. sudo puppet agent -v --test

### Debugging Puppet Installation

## Introduction

You're a member of the IT team at your company. One of your coworkers has recently set up a Puppet installation, but it doesn't seem to be doing its job. So, you're asked to debug the profile class, which is supposed to append a path to the environment variable $PATH. But it's somehow misbehaving and causing the $PATH variable to be broken. You'll need to locate the issue and fix it with the knowledge that you learned in this module.

Puppet rules

The Puppet rules are present in the init file. The purpose of this script is to append /java/bin to the environment variable $PATH, so that scripts in that directory can be executed without writing the full path.

The purpose of this rule is to append /java/bin to the environment variable $PATH so that scripts in that directory can be executed without writing the full path.

 Fix issue in init.pp
Congratulations!

Woohoo! You have used Puppet to automate the configurations on the machines and fixed the broken PATH variable. A great first step towards getting comfortable using Puppet.
End your lab

