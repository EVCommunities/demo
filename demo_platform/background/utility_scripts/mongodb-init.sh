mongo --tls $MONGODB_HOST:$MONGODB_PORT/admin --sslAllowInvalidCertificates mongodb-init-admin.js
mongo --tls $MONGODB_HOST:$MONGODB_PORT/$MONGO_INITDB_DATABASE --sslAllowInvalidCertificates mongodb-init-user.js
