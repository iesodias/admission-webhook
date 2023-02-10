cd /mnt/c/Users/ivan_/projetos/admission-webhook/admission-webhook
kubectl delete deploy admission-webhook -n admission-webhook
docker build . --tag herrmann89/admission-webhook:latest
docker push herrmann89/admission-webhook:latest
kubectl apply -f deployment.yaml -n admission-webhook
sleep 15
cd /mnt/c/Users/ivan_/projetos/admission-webhook/api-test
kubectl apply -f deployment.yaml -n api
cd /mnt/c/Users/ivan_/projetos/admission-webhook/admission-webhook