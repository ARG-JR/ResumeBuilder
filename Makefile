SHELL := /bin/bash

include .env

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

%:
    @:

.DEFAULT: ;: @\do nothing

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(word 1,$(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
runserver: ## Run the app on the port specified in .env
	@echo Running server on port $(APP_PORT)
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "python manage.py runserver 0.0.0.0:$(APP_PORT)"

.PHONY: test
test: ## Run unit tests using the dev $(COMPOSE_FILE)
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "pytest --cov"

.PHONY: makemigrations
makemigrations: ## Make migrations using docker-compose
	@echo Creating Migration files
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "python manage.py makemigrations"

.PHONY: migrate
migrate: ## Perform database model migrations using docker-compose
	@echo Migrating Database
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "python manage.py migrate"

.PHONY: startapp
startapp: ## Create a new app for the project with the specified name. IE. make startapp newapp
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "python manage.py startapp $(call args,defaultapp)"

.PHONY: createsuperuser
createsuperuser: ## Create a new superuser account in the database
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "python manage.py createsuperuser"

.PHONY: collectstatic
collectstatic: ## Run collectstatic in the docker container
	@echo Collecting Static Files
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "python manage.py collectstatic --noinput"

.PHONY: dev-build
dev-build: ## Build the app's docker image
	@echo Building Image
	@docker-compose -f $(COMPOSE_FILE) build --no-cache

.PHONY: prod-build
prod-build: ## Build the app's production docker image
	@echo Building Image
	@docker-compose -f docker-compose.prod.yml build --no-cache

.PHONY: dev-up
dev-up: ## Launch the app using docker-compose, without the database or proxy
	@docker-compose -f $(COMPOSE_FILE) up -d

.PHONY: dev-down
dev-down: ## Shutdown all running containers using docker-compose
	@docker-compose -f $(COMPOSE_FILE) down

.PHONY: proxy-db-up
proxy-db-up: ## Start the development proxy and database using docker-compose
	@docker-compose -f docker-compose.proxy.db.yml up -d

.PHONY: proxy-db-down
proxy-db-down: ## Stop the development proxy and database using docker-compose
	@docker-compose -f docker-compose.proxy.db.yml down

.PHONY: prod-up
prod-up: ## Start the app using the production docker-compose file
	@docker-compose -f docker-compose.prod.yml up

.PHONY: prod-down
prod-down: ## Stop the app using the production docker-compose file
	@docker-compose -f docker-compose.prod.yml down

.PHONY: down
down: ## Stop all possible running docker containers via docker-compose
	@docker-compose -f docker-compose.proxy.db.yml down
	@docker-compose -f docker-compose.prod.yml down
	@docker-compose -f $(COMPOSE_FILE) down

.PHONY: ls
ls: ## List all files in the docker container
	@docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) sh -c "ls -la"

.PHONY: list
list: ## View all running docker containers for this project
	@echo Production Containers
	@echo  
	@docker-compose -f docker-compose.prod.yml ps
	@echo  
	@echo Proxy/Database Containers
	@echo  
	@docker-compose -f docker-compose.proxy.db.yml ps
	@echo  
	@echo App Container
	@echo  
	@docker-compose -f $(COMPOSE_FILE) ps
	@echo  


.PHONY: abcd
abcd: ## This is abcd function
	@echo abcd