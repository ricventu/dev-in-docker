.PHONY: up

up:
	[ ! -f ./acme.json ] && touch ./acme.json
	docker-compose up -d --build

down:
	docker-compose down
