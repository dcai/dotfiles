# Create user in MySQL/MariaDB.
# https://stackoverflow.com/a/36190905/69938
MYSQLUSER=admin
MYSQLPASS=admin

mysql-create-user() {
  [ -z "$2" ] && {
    echo "Usage: mysql-create-user (user) (password)"
    return
  }
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "CREATE USER '$1'@'localhost' IDENTIFIED BY '$2'"
}

# Delete user from MySQL/MariaDB
mysql-drop-user() {
  [ -z "$1" ] && {
    echo "Usage: mysql-drop-user (user)"
    return
  }
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "DROP USER '$1'@'localhost';"
}

# Create new database in MySQL/MariaDB.
mysql-create-db() {
  [ -z "$1" ] && {
    echo "Usage: mysql-create-db (db_name)"
    return
  }
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "CREATE DATABASE IF NOT EXISTS $1 default CHARACTER set utf8 default COLLATE utf8_general_ci;"
}

# Drop database in MySQL/MariaDB.
mysql-drop-db() {
  [ -z "$1" ] && {
    echo "Usage: mysql-drop-db (db_name)"
    return
  }
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "DROP DATABASE IF EXISTS $1"
}

# Grant all permissions for user for given database.
mysql-grant-db() {
  [ -z "$2" ] && {
    echo "Usage: mysql-grand-db (user) (database)"
    return
  }
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "GRANT ALL ON $2.* TO '$1'@'localhost'"
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "FLUSH PRIVILEGES"
}

# Show current user permissions.
mysql-show-grants() {
  [ -z "$1" ] && {
    echo "Usage: mysql-show-grants (user)"
    return
  }
  mysql --user=$MYSQLUSER --password=$MYSQLPASS -ve "SHOW GRANTS FOR '$1'@'localhost'"
}
