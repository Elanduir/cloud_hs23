#Kubernetes-Repo Install
#Install according to https://learning.oreilly.com/library/view/certified-kubernetes-administrator/9781803238265/B18201_02 xhtml#_idParaDest-46
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#init/ eval
sudo apt update -y && sudo apt upgrade -y && sudo apt install git vim -y && git clone https://github.com/elanduir/cloud_hs23.git && ./cloud_hs23/eval/init.sh

#install containerd
apt install containerd.io

#kubeadm install
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

#This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt update
sudo apt install kubeadm kubectl -y


# kubeconfig
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
# (SystemCgroup = true)
sudo systemctl restart containerd


#modules enable
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

sudo kubeadm init --pod-network-cidr=192.168.0.0/16