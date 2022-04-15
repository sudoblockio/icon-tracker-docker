.PHONY: test help

up-deps:  ## Bring up the Dependencies
	docker-compose -f docker-compose.deps.yml up -d

down-deps:  ## Take down the Dependencies
	docker-compose -f docker-compose.deps.yml down

pull:
	docker-compose -f docker-compose.deps.yml -f docker-compose.yml pull

up:  ## Bring everything up as containers
	docker-compose -f docker-compose.deps.yml -f docker-compose.yml up -d

down:  ## Take down all the containers
	docker-compose -f docker-compose.deps.yml -f docker-compose.yml down -v

clean:
	docker volume rm $(docker volume ls -q)

ps:  ## List all containers and running status
	docker-compose -f docker-compose.deps.yml -f docker-compose.yml ps

postgres-console:  ## Start postgres terminal
	docker-compose -f docker-compose.deps.yml -f docker-compose.yml exec postgres psql -U postgres

redis-console:  ## Start redis terminal
	docker-compose -f docker-compose.deps.yml -f docker-compose.yml exec redis redis-cli

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
