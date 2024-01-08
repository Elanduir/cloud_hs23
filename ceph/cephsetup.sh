curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
sudo chmod +x cephadm
sudo ./cephadm add-repo --release quincy
sudo ./cephadm install
echo export PATH="/usr/sbin/:$PATH" >> ~/.bashrc
source ~/.bashrc


sudo apt install catatonit lvm2 python3 podman -y 
