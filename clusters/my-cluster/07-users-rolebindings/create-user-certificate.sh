set -e
# Generate a private key
openssl genrsa -out bob.key 2048

# Create a certificate signing request (CSR)
openssl req -new -key bob.key -out bob.csr -subj "/CN=bob/O=mygroup"

# Copy the CA cert and key out of the kind control-plane container
docker cp kind-control-plane:/etc/kubernetes/pki/ca.crt .
docker cp kind-control-plane:/etc/kubernetes/pki/ca.key .

# Sign the CSR
openssl x509 -req -in bob.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out bob.crt -days 365

kubectl config set-credentials bob --client-certificate=bob.crt --client-key=bob.key

kubectl config set-context bob-context --cluster=kind-kind --user=bob
