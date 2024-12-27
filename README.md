# Backend Challenge 20241227 Ruby on Rails - Projeto INSS Calculator

Projeto de cadastro de proponentes e cálculo de desconto do INSS

## <u>**Tecnologias e Pré-requisitos**</u>

Estas são as tecnologias e os pré-requisitos para a execução do projeto:
- Ruby 3.3.3
- Rails 8.0.1
- PostgreSQL 15
- Docker
- Sidekiq
- Rubocop
- Haml Format

## <u>**Instalação**</u>

O endereço do repositório é:

https://github.com/claudiojsantos/inss_calculator

Utilizando o Docker, execute os comandos abaixo:

```sh
docker-compose up -d --build (container)
docker-compose -f docker-compose-dev up -d --build (localmente)
```

Caso deseje instalar localmente, considerando que já tenha o Ruby e o MongoDB instalados, execute os comandos abaixo:

```sh
bundle install
rails s
redis-server
bundle exec sidekiq
```  

Para executar os testes automatizados, execute o comando abaixo:

```sh
rspec
```

---
## <u>**Utilização**</u>

Ao subir o container, se banco de dados será criado automaticamente. Para acessar a aplicação, utilize a seguinte credencial:

```sh
email: admin@test.com
password: 12345678
```

---
**Cláudio Santos**  
**claudio@sistnet.com.br**.  
Linkedin: **https://www.linkedin.com/in/claudio-santos-3b071140/**