# admission-webhook
Valida se o livenessProbe e readnessProbe estão habilitados durante o deployment.



# Como utilizar

1 - Edite o arquivo /certs/cert-generator.sh com as variáveis do seu ambiente, na variável SSL_ALTNAME voce precisa preencher o dns local do seu admission-webhook para que o certificado seja aceito pelo cluster em seguida execute o script para gerar a cadeia de certificado.
2 - Execute o comando cat caBundle.pem | base64 -w 0 para transformar o certificado em base64 e adicione o resultado no campo caBundle do arquivo /admission-webhook/admission-webhook.yaml.
3 - Execute o comando cat validate-hc.crt | base64 -w 0 para transformar o certificado em base64 e adicione no campo tls.crt do arquivo /admission-webhook/tlssecret.yaml
4 - Execute o comando cat validate-hc.key | base64 -w 0 para transformar o certificado em base64 e adicione no campo tls.key do arquivo /admission-webhook/tlssecret.yaml
5 - Crie uma imagem docker e faça o push para seu register utilizando o dockerfile do diretório /admission-webhook/dockerfile
6 - Crie um namespace para usa aplicação de admission-webhook kubectl create namespace <NAME>
7 - Faça o deploy da secret que criamos anteriormente no novo namespace utilizando o arquivo /admission-webhook/tlssecret.yaml kubectl apply -f tlssecret.yaml -n <NAMESPACE>
8 - Crie um novo deployment no namespace criado anteriormente utilizando o arquivo yaml do diretório /admission-webhook/ kubectl apply -f deployment.yaml -n <NAMESPACE>
9 - Crie um novo service da mesma forma com o arquivo /admission-webhook/service.yaml kubectl apply -f service.yaml -n <NAMESPACE>
10 - Faça o deploy do admission webhook configuration utilizando o arquivo /admission-webhook/admission-webhook.yml kubectl apply -f admission-webhook.yaml


Para testar o webhook utilize os deployments do diretorio /api-test



# admission-webhook
Check if livenessProbe and readnessProbe are enabled during deployment

# Usage
Edit the file /certs/cert-generator.sh with your environment variables. In the SSL_ALTNAME variable, you need to fill in the local DNS of your admission-webhook so that the certificate is accepted by the cluster, then run the script to generate the certificate chain.
Run the command cat caBundle.pem | base64 -w 0 to convert the certificate to base64 and add the result in the caBundle field of the file /admission-webhook/admission-webhook.yaml.
Run the command cat validate-hc.crt | base64 -w 0 to convert the certificate to base64 and add it to the tls.crt field of the file /admission-webhook/tlssecret.yaml.
Run the command cat validate-hc.key | base64 -w 0 to convert the certificate to base64 and add it to the tls.key field of the file /admission-webhook/tlssecret.yaml.
Create a Docker image and push it to your registry using the /admission-webhook/dockerfile directory.
Create a namespace for the admission-webhook application using kubectl create namespace <NAME>.
Deploy the secret that we created earlier in the new namespace using the file /admission-webhook/tlssecret.yaml with kubectl apply -f tlssecret.yaml -n <NAMESPACE>.
Create a new deployment in the namespace created earlier using the yaml file in the /admission-webhook/ directory with kubectl apply -f deployment.yaml -n <NAMESPACE>.
Create a new service in the same way using the file /admission-webhook/service.yaml with kubectl apply -f service.yaml -n <NAMESPACE>.
Deploy the admission webhook configuration using the file /admission-webhook/admission-webhook.yml with kubectl apply -f admission-webhook.yaml.
To test the webhook, use the deployments in the /api-test directory.