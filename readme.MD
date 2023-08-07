# Simple Bank Doc

## pull image

pull postgres image.

```shell
docker pull postgres
```

the command below will pull the postgres image if it is not already present, create the db-data volume, and start the db service in detached mode.

```shell
docker-compose up -d
```

### access postgres CLI

```shell
docker exec -it simple-postgres psql -U root
```

### create migrate schema

```shell
migrate create -ext sql -dir db/migration -seq init_schema
```

create database on docker postgres

```shell
docker exec -it simple-postgres createdb --username=root simple_bank
```

## Generate CRUD Golang code from SQL

using sqlc to interact with sql query to generate golang code.

### Initialize a new Go module named tutorial.sqlc.dev/app

```shell
go mod init tutorial.sqlc.dev/app
```

initialize sqlc yaml file using `sqlc init`

```shell
sqlc init
```

sqlc needs to know your database schema and queries in order to generate code. u can use schema we created before. Next, create a query.sql, go to documentation for more instruction [here](https://docs.sqlc.dev/en/stable/tutorials/getting-started-postgresql.html).

```sql
-- name: CreateAccount :one
INSERT INTO accounts (
  owner, balance, currency
) VALUES (
  $1, $2, $3
)
RETURNING *;
```

now ready to generate code on windows, use software platform that allows you to run applications in isolated containers. This way, you can run sqlc on Windows without installing the PostgreSQL engine directly on your system. You shouldn’t see any errors or output.

```shell
docker run --rm -v "${PWD}:/src" -w /src kjconroy/sqlc generate
```
