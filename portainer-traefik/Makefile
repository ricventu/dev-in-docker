.DEFAULT_GOAL := up

config:
	if [ ! -f ./acme.json ]; then touch ./acme.json && chmod 600 ./acme.json; fi
	if [ ! -f ./users_credentials ]; then \
		touch ./users_credentials && chmod 600 ./users_credentials && \
		htdigest users_credentials traefik admin; \
	fi

up: config
	docker-compose up -d 

down:
	docker-compose down

traefik: config
	docker-compose up -d traefik
