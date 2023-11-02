CONTAINER_EXISTS = $(shell docker ps -a | grep 'ark-ascended-server-test')

build:
	docker build --file Dockerfile --tag ark-ascended-server-test .

run: 
ifneq ($(CONTAINER_EXISTS),)
	docker rm -f ark-ascended-server-test
endif
	rm -rf local-test 
	mkdir local-test 
	docker run \
	--detach \
	--name ark-ascended-server-test \
	--mount type=bind,source=$(shell pwd)/local-test,target=/home/steam/ark/ShooterGame/Saved \
	--publish 7777:7777/udp \
	--env=SERVER_MAP=TheIsland_WP \
	--env=SESSION_NAME=Ascended-Docker \
	--env=SERVER_PASSWORD=foo \
	--env=SERVER_ADMIN_PASSWORD=foo \
	--env=GAME_PORT=7777 \
	ark-ascended-server-test:latest
