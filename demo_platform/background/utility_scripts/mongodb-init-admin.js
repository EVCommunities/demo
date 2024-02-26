// JavaScript for adding a root user to MongoDB

const MONGO_INITDB_ROOT_USERNAME = "MONGO_INITDB_ROOT_USERNAME";
const MONGO_INITDB_ROOT_PASSWORD = "MONGO_INITDB_ROOT_PASSWORD";

const MONGO_ADMIN_DATABASE = "admin"
const ROOT_ROLE = "root";

// create admin user
const rootUser = _getEnv(MONGO_INITDB_ROOT_USERNAME);
const rootPassword = _getEnv(MONGO_INITDB_ROOT_PASSWORD);
if (rootUser !== "" && rootPassword !== "") {
    try {
        db.createUser(
            {
                user: rootUser,
                pwd: rootPassword,
                roles: [
                    {
                        role: ROOT_ROLE,
                        db: MONGO_ADMIN_DATABASE
                    }
                ]
            }
        );
    }
    catch(error) {
    }
}
