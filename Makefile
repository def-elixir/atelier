image=atelier:latest
container_name=atelier

setup: build run start
	docker exec -it $(container_name) mix setup

build:
# docker build
	docker build -t $(image) .

run:
# create container and run background with volume.
	docker run -it -d --name $(container_name) -v `pwd`/atelier:/usr/src/app $(image)

start:
# start container.
	docker start $(container_name)

stop:
# stop container.
	docker stop $(container_name)

rm:
# remove container.
	docker rm $(container_name)

bash:
# connect container.
	docker exec -it $(container_name) /bin/bash

iex:
# connect container.
	docker exec -it $(container_name) iex -S mix

sqlite:
# connect database.
	docker exec -it $(container_name) sqlite3 ./data/atelier_repo.db
