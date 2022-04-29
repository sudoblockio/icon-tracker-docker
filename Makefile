.PHONY: test help

up-deps:  ## Bring up the Dependencies
	docker-compose -f docker-compose.deps.yml up -d

down-deps:  ## Take down the Dependencies
	docker-compose -f docker-compose.deps.yml down

pull:
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml -f docker-compose.sejong.yml pull

up-mainnet:  ## Bring up mainnet
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml up -d

up-sejong:  ## Bring up sejong
	docker-compose -f docker-compose.deps.yml -f docker-compose.sejong.yml up -d

up-mainnet-ssl:  ## Bring up mainnet with traefik
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml -f docker-compose.traefik.yml up -d

up-sejong-ssl:  ## Bring up sejong with traefik
	docker-compose -f docker-compose.deps.yml -f docker-compose.sejong.yml -f docker-compose.traefik.yml up -d

down:  ## Take down all the containers
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml -f docker-compose.sejong.yml down -v

clean:
	docker volume rm $(docker volume ls -q)

ps:  ## List all containers and running status
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml -f docker-compose.sejong.yml ps

postgres-console:  ## Start postgres terminal
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml -f docker-compose.sejong.yml exec postgres psql -U postgres

redis-console:  ## Start redis terminal
	docker-compose -f docker-compose.deps.yml -f docker-compose.mainnet.yml -f docker-compose.sejong.yml exec redis redis-cli

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
