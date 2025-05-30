
# ESPECIFICAÇÃO DE REQUISITOS DE SOFTWARE  
**Projeto:** Ranking de Gastos dos Deputados  
**Desenvolvedor:** João Evangelista Santiago Neto  
**Data:** 30/05/2025

---

## 1. Objetivo Geral

Criar uma aplicação web que permita a análise e visualização dos **gastos dos deputados federais do estado do desenvolvedor**, com base nos dados públicos da Câmara dos Deputados, referentes à CEAP. O sistema deve importar, persistir e disponibilizar essas informações via uma **API RESTful** e uma **interface web**.

---

## 2. Escopo do Sistema

### Funcionalidades principais:
1. Upload do arquivo CSV  
2. Importação dos dados no banco  
3. Listagem de deputados do estado  
4. Exibição do total de gastos por deputado  
5. Listagem detalhada de despesas  
6. Destaque da maior despesa do deputado  

### Funcionalidades bônus:
7. Gráficos de visualização dos gastos  
8. Deploy na AWS ou similar  
9. Documentação técnica e de API  
10. Uso de padrões de projeto  
11. Diagramas de arquitetura  

---

## 3. Requisitos Funcionais (RF)

| Código | Descrição |
|--------|-----------|
| RF01 | O sistema deve permitir o upload de um arquivo CSV contendo os dados da CEAP. |
| RF02 | O sistema deve filtrar e importar apenas os registros com `sgUF` igual ao estado do desenvolvedor. |
| RF03 | O sistema deve armazenar os dados dos deputados e suas despesas em tabelas no banco de dados. |
| RF04 | O sistema deve expor uma API que lista os deputados do estado. |
| RF05 | O sistema deve exibir o total de gastos (`vlrLiquido`) de cada deputado. |
| RF06 | O sistema deve listar todas as despesas de um deputado com: data, estabelecimento, valor, e link da nota fiscal. |
| RF07 | O sistema deve destacar a maior despesa de cada deputado. |
| RF08 | O sistema deve evitar N+1 nas queries da API. |
| RF09 | O sistema deve fornecer cobertura de testes com RSpec. |

---

## 4. Requisitos Não Funcionais (RNF)

| Código | Descrição |
|--------|-----------|
| RNF01 | O sistema deve ser implementado em **Rails** (backend) e usar algum **framework frontend** (React, Vue, etc). |
| RNF02 | O tempo de resposta da API deve ser inferior a 500ms em requisições médias. |
| RNF03 | O sistema deve permitir escalar horizontalmente em ambiente Docker/Kubernetes. |
| RNF04 | O sistema deve usar Redis para processamento assíncrono com Sidekiq (se necessário). |
| RNF05 | O sistema deve conter testes com cobertura mínima de 80%. |
| RNF06 | A visualização deve ser responsiva. |

---

## 5. Requisitos de Domínio (RD)

| Código | Descrição |
|--------|-----------|
| RD01 | A cota parlamentar (CEAP) pode incluir gastos reembolsáveis e não reembolsáveis. |
| RD02 | Apenas o campo `vlrLiquido` deve ser usado para cálculo dos gastos. |
| RD03 | O link da imagem do deputado segue o padrão: `http://www.camara.leg.br/internet/deputado/bandep/{ideCadastro}.jpg`. |

---

## 6. Requisitos de Interface (RI)

| Código | Descrição |
|--------|-----------|
| RI01 | A API REST deve seguir o padrão RESTful, com rotas organizadas por recursos. |
| RI02 | A interface deve apresentar: listagem, totalizadores, e gráficos (opcional). |
| RI03 | A API deve ser documentada com Swagger ou equivalente. |

---

## 7. Requisitos de Implantação (RIp)

| Código | Descrição |
|--------|-----------|
| RIp01 | O sistema deve ser hospedado na AWS (ou similar). |
| RIp02 | O deploy deve ser automatizado via CI/CD com GitHub Actions. |
| RIp03 | O projeto deve estar disponível em um repositório Git público com instruções de uso. |

---

## 8. Critérios de Aceitação

- Upload do CSV funciona corretamente e importa dados válidos.  
- A API retorna deputados apenas do estado definido.  
- Os dados persistidos podem ser acessados, filtrados e ordenados.  
- A aplicação possui cobertura de testes.  
- As queries são otimizadas (sem N+1).  
- O projeto contém README com instruções claras.  

---

## 9. Possíveis Melhorias Futuras

- Filtragem por data e tipo de despesa  
- Comparação entre estados  
- Alertas de gastos acima da média  
- Autenticação e perfis de usuários  

---

## 10. Referências

- [Portal da Transparência da Câmara](https://www.camara.leg.br/transparencia/)  
- [Rails Guides](https://guides.rubyonrails.org/)  
- [Rspec](https://rspec.info/)  
- [Bullet Gem](https://github.com/flyerhzm/bullet)  