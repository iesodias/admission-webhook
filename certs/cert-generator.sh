export CN=validate-hc.svc.cluster.local
export O=teste
export CITY=SP
export STATE=SP
export CERTIFICATE_NAME=validate-hc
export SSL_ALTNAME="subjectAltName=DNS:validate-hc.svc.cluster.local,DNS:validate-hc.svc,DNS:validate-hc.admission-webhook.svc"

# Gera a PK da rootCA
openssl genrsa -out rootCA.key 4096
# Gera o certificado auto assinado 
openssl req -x509 -new -nodes -key rootCA.key -days 1024 -subj "/C=$CITY/ST=$STATE/O=$O, Inc./CN=$CN" -out rootCA.crt
# Gera a pk
openssl genrsa -out $CERTIFICATE_NAME.key 2048

#Gera um certificado Request
openssl req -new -sha256 -key $CERTIFICATE_NAME.key -subj "/C=$CITY/ST=$STATE/O=$O, Inc./CN=$CN" -out $CERTIFICATE_NAME.csr

#Assina o certificado com a chave da CA
# openssl x509 -req -in $CERTIFICATE_NAME.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $CERTIFICATE_NAME.crt -days 500
openssl x509 -req -extfile <(printf "$SSL_ALTNAME") -days 365 -in $CERTIFICATE_NAME.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $CERTIFICATE_NAME.crt


#concatena o certificado

cat rootCA.crt > caBundle.pem
cat $CERTIFICATE_NAME.crt >> caBundle.pem

#openssl x509 -in caBundle.pem -text -noout
openssl x509 -req -extfile <(printf "$SSL_ALTNAME") -days 365 -in $CERTIFICATE_NAME.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $CERTIFICATE_NAME.crt
