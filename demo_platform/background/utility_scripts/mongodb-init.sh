mongo --tls $MONGODB_HOST:$MONGODB_PORT/admin mongodb-init-admin.js
mongo --tls $MONGODB_HOST:$MONGODB_PORT/$MONGO_INITDB_DATABASE mongodb-init-user.js
