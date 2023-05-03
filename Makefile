build-app:
	docker-compose build app

build-db:
	docker-compose build db

build-nginx:
	docker-compose build nginx

build: build-app build-db build-nginx

run-db:
	docker-compose up -d database

run-app:
	docker-compose up -d app

run-nginx:
	docker-compose up nginx

run:
	docker-compose up -d

stop:
	docker-compose down
