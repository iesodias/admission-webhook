cd /mnt/c/Users/ivan_/projetos/admission-webhook/admission-webhook
kubectl apply -f admission-webhook.yaml
sleep 1

kubectl apply -f tlssecret.yaml -n admission-webhook
sleep 1
kubectl apply -f deployment.yaml -n admission-webhook
