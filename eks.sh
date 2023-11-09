eksctl create cluster --name thecloudshepherd --region us-east-1 --node-type t3.large --nodes 2 --nodes-min 2 --nodes-max 2


aws eks update-kubeconfig --name thecloudshepherd --region us-east-1


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# e a way to organize clusters into virtual sub-clusters

helm install stable prometheus-community/kube-prometheus-stack -n prometheus

kubectl get pods -n prometheus


kubectl get svc -n prometheus

kubectl port-forward deploy/stable-grafana  -n prometheus 3000:3000


15760


#uninstall charts
NAMESPACE=prometheus
for release in $(helm list -n $NAMESPACE -o json | jq -r '.[].name'); do
  helm uninstall $release -n $NAMESPACE
done

#uninstall repo
for repo in $(helm repo list -o json | jq -r '.[].name'); do
  helm repo remove $repo
done