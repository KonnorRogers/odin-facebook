# README

## Setting up POSTGRESQL

```bash
# Installs postgresql
sudo apt update
sudo apt-get install postgresql postgresql-contrib libpq-dev

# Creates the postgres user and adds a user of the name $USER
sudo -u postgres createuser -s $USER

su - postgres # Switches to the postgres user
psql # Open up the psql prompt
\password <your_db_password> # Set your password
\q # exit the prompt

# Export your password for use by POSTGRES
export PGPASSWORD=<your_db_password>
export PGUSER=$USER

# check the it works
createdb db1
psql
```

Edit /etc/postgresql/<post_gres_version>/main/pg_hba.conf

It should look as follow
```bash
local   all             postgres                                peer
```

edit it to look like this

```bash
local   all             postgres                                md5
```

Finally, restart postgres

sudo service postgres restart
