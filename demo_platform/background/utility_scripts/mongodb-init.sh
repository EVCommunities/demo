mongo --tls $MONGODB_HOST:$MONGODB_PORT/admin --tlsAllowInvalidCertificates mongodb-init-admin.js
mongo --tls $MONGODB_HOST:$MONGODB_PORT/$MONGO_INITDB_DATABASE --tlsAllowInvalidCertificates mongodb-init-user.js
