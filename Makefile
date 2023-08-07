createdb:
	docker exec -it simple-postgres createdb --username=root simple_bank

dropdb:
	docker exec -it simple-postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:30003/simple_bank?sslmode=disable" -verbose down

sqlc:
	docker run --rm -v "${PWD}:/src" -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb migrateup dropdb sqlc test 