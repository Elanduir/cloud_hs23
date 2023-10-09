#!/bin/bash

SSHKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKMf2NalRNgiv1bPjzF+4R4bak81D4SP7vvb0F7KeE7D sebastiangraf@laptop"

sudo useradd -m -d /home/eval -s /bin/bash eval
sudo mkdir /home/eval/.ssh
sudo touch /home/eval/.ssh/authorized_keys
echo $SSHKEY | sudo tee -a /home/eval/.ssh/authorized_keys

sudo chown -R eval:eval /home/eval/.ssh
sudo chmod 700 /home/eval/.ssh
sudo chmod 600 /home/eval/.ssh/authorized_keys

sudo usermod -aG sudo eval

echo "eval ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
