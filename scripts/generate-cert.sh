openssl genrsa -des3 -passout pass:$SSL_PASS -out $TMPBASEDIR/$SSL_CA_KEY $SSL_LENGTH
openssl req -x509 -new -nodes -key $TMPBASEDIR/$SSL_CA_KEY  -passin pass:$SSL_PASS -sha256 -days 3650 -out $TMPBASEDIR/$SSL_CA_CERT -subj $SSL_SUBJECT
openssl genrsa -out $TMPBASEDIR/$SSL_DEVICE_KEY $SSL_LENGTH
openssl req -new -key $TMPBASEDIR/$SSL_DEVICE_KEY -out $TMPBASEDIR/$SSL_REQUEST_KEY -subj $SSL_SUBJECT
openssl x509 -req -in $TMPBASEDIR/$SSL_REQUEST_KEY -CA $TMPBASEDIR/$SSL_CA_CERT -CAkey $TMPBASEDIR/$SSL_CA_KEY -CAcreateserial -out $TMPBASEDIR/$SSL_DEVICE_CERT -days 3650 -extfile <(printf "$SSL_ALTNAME")


/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=xpi.com.br/OU=Devops/CN=validate-hc.svc.cluster.local
'"