# 📊 MyCandidate API

API desenvolvida em **Ruby on Rails 8** com suporte a background jobs via Sidekiq, serialização JSON:API, e estrutura modular com a gem `dry-rb`. O projeto é executado em ambiente Docker, com comandos de automação via Makefile.

## 🚀 Stack Principal

- Ruby `3.4.3`
- Rails `8.0.2`
- PostgreSQL
- Sidekiq
- Kaminari (paginação)
- JSONAPI::Serializer
- Dry-Rb (monads)
- RSpec (testes)
- Docker + Docker Compose

---

## 🐳 Como subir o projeto

### Pré-requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Make](https://www.gnu.org/software/make/) instalado (disponível nativamente no Linux/macOS)

### Subir containers

```bash
make up
