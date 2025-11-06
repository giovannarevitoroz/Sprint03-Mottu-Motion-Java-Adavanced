# Vídeo demonstracao do projeto 
## [VIDEO YOUTUBE](https://youtu.be/lbROYuvLvZY)


![Logo](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/th5xamgrr6se0x5ro4g6.png)

# Mottu Mottion

O **Mottu Mottion** é um sistema desenvolvido em **Java com Spring Boot**, criado para apoiar a **Mottu**, empresa especializada no aluguel de motos para entregadores.
O projeto tem como objetivo aprimorar a **gestão e o monitoramento da frota**, oferecendo uma plataforma **web moderna, segura e escalável**.

---

## Etiquetas

[![Java](https://img.shields.io/badge/Java-17-orange)]()
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3-brightgreen)]()
[![Flyway](https://img.shields.io/badge/Flyway-Migrations-red)]()
[![JWT](https://img.shields.io/badge/Security-JWT-blue)]()
[![MySQL](https://img.shields.io/badge/Database-MySQL%208-lightblue)]()
[![PostgreSQL](https://img.shields.io/badge/Cloud-Render%20PostgreSQL-purple)]()

---

## Demonstração

Acesse a versão hospedada do projeto:

🔗 [https://sprint03-mottu-motion-java-adavanced-1.onrender.com](https://sprint03-mottu-motion-java-adavanced-1.onrender.com)

---

## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=Mottu+Mottion+-+Spring+Boot+API)

---

## Funcionalidades

* Cadastro e gerenciamento de motos, pátios, setores e vagas
* Registro de movimentações de entrada e saída de veículos
* Autenticação JWT com perfis de usuário

  * **ROLE_FUNCIONARIO**
  * **ROLE_GERENTE**
* Migração automática de banco de dados com Flyway
* API RESTful seguindo boas práticas e arquitetura em camadas
* Deploy automatizado em nuvem (Render)

---

## Documentação

A documentação técnica e diagramas estão disponíveis em `/docs`.

---

## Deploy

O deploy é feito automaticamente via **Render**, utilizando **PostgreSQL Cloud**.

```bash
# Branch de deploy
git checkout sprint-4-render-migration

# Build do projeto
mvn clean install

# Deploy automático via Render
```

---

## Instalação

Clone o repositório e instale as dependências Maven.

```bash
git clone https://github.com/giovannarevitoroz/Sprint01-Mottu-Motion-Java-Adavanced.git
cd Sprint01-Mottu-Motion-Java-Adavanced
mvn install
```

---

## Rodando localmente

```bash
mvn spring-boot:run
```

Acesse: [http://localhost:8080/login](http://localhost:8080/login)

---

## Rodando os testes

Execute os testes automatizados com:

```bash
mvn test
```

Os testes validam endpoints, autenticação e persistência no banco via **JUnit**.

---

## Aprendizados

Durante o desenvolvimento do projeto, foram aplicados e consolidados diversos conceitos:

* Estruturação de API RESTful com **Spring Boot 3**
* Implementação de segurança com **Spring Security + JWT**
* Controle de versão e migração de banco via **Flyway**
* Integração contínua e deploy automatizado com **Render Cloud**
* Modelagem relacional com **Spring Data JPA** e diagramas ER
* Boas práticas de arquitetura em camadas (Controller, Service, Repository)

---

## Documentação da API

#### Retorna todas as motos

```http
  GET /api/motos
```

| Parâmetro       | Tipo     | Descrição                             |
| :-------------- | :------- | :------------------------------------ |
| `Authorization` | `string` | **Obrigatório**. Token JWT do usuário |

#### Retorna uma moto por ID

```http
  GET /api/motos/{id}
```

| Parâmetro | Tipo   | Descrição                                     |
| :-------- | :----- | :-------------------------------------------- |
| `id`      | `long` | **Obrigatório**. ID da moto que deseja buscar |

#### Cadastra uma nova moto

```http
  POST /api/motos
```

| Campo                | Tipo     | Descrição            |
| -------------------- | -------- | -------------------- |
| `placa_moto`         | `string` | Placa da moto        |
| `modelo_moto`        | `string` | Modelo da moto       |
| `cliente_id_cliente` | `long`   | Cliente proprietário |

---

## Roadmap

* [ ] Adicionar painel de dashboard com gráficos de movimentação
* [ ] Implementar upload de documentos e comprovantes
* [ ] Expandir autenticação para integração mobile
* [ ] Adicionar logs detalhados com Spring Actuator

---

## Autores

| Nome                                     | RM       | Função                                       |
| ---------------------------------------- | -------- | -------------------------------------------- |
| **Giovanna Revito Roz**                  | RM558981 | Desenvolvimento Backend e Modelagem de Banco |
| **Kaian Gustavo de Oliveira Nascimento** | RM558986 | API REST e Segurança JWT                     |
| **Lucas Kenji Kikuchi**                  | RM554424 | Documentação, Flyway e Deploy Render         |

---

## Estrutura do Projeto

```
mottu-mottion/
│
├── src/main/java/com/mottu/mottion/
│   ├── controller/        # Endpoints REST
│   ├── service/           # Regras de negócio
│   ├── repository/        # Persistência JPA
│   ├── model/             # Entidades
│   ├── dto/               # Transporte de dados
│   ├── security/          # Configuração JWT
│   ├── exception/         # Tratamento de erros
│   └── MottuMottion.java  # Classe principal
│
├── src/main/resources/
│   ├── db/migration/      # Scripts Flyway
│   ├── templates/         # Páginas Thymeleaf
│   └── application.properties
│
└── pom.xml                # Dependências Maven
```

---

## Modelo Relacional (Mermaid)

```mermaid
erDiagram
    CLIENTE ||--o{ MOTO : possui
    PÁTIO ||--o{ SETOR : contém
    SETOR ||--o{ VAGA : tem
    VAGA ||--o{ MOVIMENTACAO : registra
    MOTO ||--o{ MOVIMENTACAO : movimenta
    FUNCIONARIO }o--|| CARGO : ocupa
    FUNCIONARIO }o--|| PÁTIO : atua_em
    GERENTE }o--|| PÁTIO : administra
```

---

## Fluxo da Aplicação

```mermaid
flowchart TD
    A[Usuário (Gerente/Funcionário)] -->|Login| B[Spring Security + JWT]
    B -->|Token válido| C[Controller REST]
    C --> D[Service Layer]
    D --> E[Repository JPA]
    E --> F[(Banco de Dados MySQL / PostgreSQL)]
    F -->|Retorna dados| C
    C --> G[Thymeleaf / API JSON]
```

---

## Tecnologias Utilizadas

| Categoria      | Tecnologia            |
| -------------- | --------------------- |
| Linguagem      | Java 17               |
| Framework      | Spring Boot 3         |
| ORM            | Spring Data JPA       |
| Segurança      | Spring Security + JWT |
| Migração       | Flyway                |
| Banco Local    | MySQL 8               |
| Banco Produção | PostgreSQL (Render)   |
| View           | Thymeleaf             |
| Testes         | JUnit                 |
| Deploy         | Render Cloud          |

---

## Referências

* [Spring Boot Documentation](https://spring.io/projects/spring-boot)
* [Flyway Documentation](https://flywaydb.org/documentation/)
* [Spring Security JWT](https://spring.io/guides/tutorials/spring-boot-oauth2/)
* [Render Deploy Docs](https://render.com/docs)

## Authors

* Giovanna Revito Roz – RM558981
* Kaian Gustavo de Oliveira Nascimento – RM558986
* Lucas Kenji Kikuchi – RM554424









