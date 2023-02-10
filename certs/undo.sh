cd /mnt/c/Users/ivan_/projetos/admission-webhook/certs
rm -rf caBundle.pem
rm -rf validate-hc.crt
openssl x509 -req -extfile <(printf "$SSL_ALTNAME") -days 365 -in $CERTIFICATE_NAME.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $CERTIFICATE_NAME.crt
cat rootCA.crt > caBundle.pem
cat $CERTIFICATE_NAME.crt >> caBundle.pem
k delete secret webhook-certs -n admission-webhook
k delete ValidatingWebhookConfiguration/validate-hc.svc.cluster.local
k delete deploy admission-webhook -n admission-webhook