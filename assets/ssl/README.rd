# Creating a self signed certificate

*NOTE: the keys provided are NOT secure as it is the same for all released versions of dStack.*

1) Run the following command replacing [mydomain] for that fully qualified domain
   name of the site you wish to create a new certificate for. This will create a key
   and a cert(certificate) file.

```
openssl req -nodes -new -x509  -keyout [mydomain].key -out [mydomain].cert
```
