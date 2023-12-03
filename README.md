This repository contains xitee-homework playbook. Playbook functionality is tested on:

Ubutnu 22.04.3-live-server-amd64

Ubuntu ISO:
https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso

md5sum: 2072007c1d5b504c9a4858240e28e669

Ansible version:
ansible [core 2.12.1]
python version = 3.9.5

Before run it is necessary to fill variables in inventory.ini:

ansible_user - name of system user created in the installation process

ansible_password and ansible_become_pass - user password

ansible_host - IP address or hostname of destination machine

Example of command to run playbook:

ansible-playbook -i inventory.ini xitee-homework.yml
