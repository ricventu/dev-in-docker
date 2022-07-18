.PHONY: up

up:
	if [ ! -f ./acme.json ]; then touch ./acme.json && chmod 600 ./acme.json; fi
	if [ ! -f ./users_credentials ]; then touch ./users_credentials && chmod 600 ./users_credentials; fi
	docker-compose up -d --build

down:
	docker-compose down
