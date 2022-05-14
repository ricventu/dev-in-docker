.PHONY: up

up:
	if [ ! -f ./acme.json ]; then touch ./acme.json && chmod 600 ./acme.json; fi
	# docker-compose up -d --build

down:
	docker-compose down
