# Makefile para comandos Rails no Docker

APP_NAME=my_candidate_api

# Comando padrão
.DEFAULT_GOAL := help

help:
	@echo "Comandos disponíveis:"
	@echo "  make up              # Sobe os containers (build e inicia)"
	@echo "  make down            # Derruba os containers"
	@echo "  make build           # Builda a imagem do container"
	@echo "  make bash            # Acessa o bash do container Rails"
	@echo "  make logs            # Mostra os logs do container Rails"
	@echo "  make db-create       # Cria o banco de dados"
	@echo "  make db-migrate      # Roda as migrations"
	@echo "  make db-reset        # Reseta o banco (drop, create, migrate)"
	@echo "  make rails ARG=...   # Executa um comando Rails no container"
	@echo "  make rspec           # Roda os testes"
	@echo "  make lint            # Roda o RuboCop"

up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build

bash:
	docker compose exec $(APP_NAME) bash

logs:
	docker compose logs -f $(APP_NAME)

db-create:
	docker compose run --rm $(APP_NAME) rails db:create

db-migrate:
	docker compose run --rm $(APP_NAME) rails db:migrate

db-reset:
	docker compose run --rm $(APP_NAME) rails db:drop db:create db:migrate

console:
	docker compose run --rm $(APP_NAME) rails console

rails:
	docker compose run --rm $(APP_NAME) rails $(ARG)

rspec:
	docker compose run --rm $(APP_NAME) bundle exec rspec

lint:
	docker compose run --rm $(APP_NAME) bundle exec rubocop
