#cilium
sudo apt install helm

helm repo add cilium https://helm.cilium.io/

export API_SERVER_IP=$(kubectl get nodes -o wide -o jsonpath='{.items[0].status.addresses[0].address}')
export API_SERVER_PORT=6443

helm install cilium cilium/cilium --namespace kube-system --set k8sServiceHost=${API_Server_IP} --set k8sServicePort=${API_Server_PORT}