# run_sql.sh

DATABASE="../woori_church.db"
SCHEMA_PATH="./schema"

sqlite3 $DATABASE < "$SCHEMA_PATH/database_tables.sql"
sqlite3 $DATABASE < "./initial_data/seed_data.sql"