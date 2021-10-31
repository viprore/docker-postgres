#! /bin/bash

sshpass -p 123qwe ssh-copy-id -o StrictHostKeyChecking=no root@icbig-01-01
sshpass -p 123qwe ssh-copy-id -o StrictHostKeyChecking=no root@icbig-01-02
sshpass -p 123qwe ssh-copy-id -o StrictHostKeyChecking=no root@icbig-01-03

rm -rf /etc/ansible/hosts

ln -fsn /srv/thadoop-cm/ansible/inventories/icbig/hosts /etc/ansible/hosts
ln -fsn /srv/thadoop-cm/ansible/inventories/icbig/group_vars /etc/ansible/group_vars