CREATE DATABASE livraria 
GO
USE livraria
GO
CREATE TABLE livro (
codigo          INT            NOT NULL        IDENTITY(100001,100),
nome            VARCHAR(200)   NOT NULL,
lingua          VARCHAR(10)    NOT NULL        DEFAULT('PT-BR'),
ano             INT            NOT NULL        CHECK(ano >= '1990-12-31')
PRIMARY KEY(codigo)
)
GO
CREATE TABLE autor(
id_autor         INT           NOT NULL        IDENTITY(2351,1),
nome             VARCHAR(100)  NOT NULL        UNIQUE,
data_nasc        DATE          NOT NULL,
pais_nasc        VARCHAR(50)   NOT NULL        CHECK(pais_nasc = 'Brasil' OR pais_nasc = 'Estados Unidos' 
                   OR pais_nasc = 'Inglaterra' OR pais_nasc = 'Alemanha'),
biografia        VARCHAR(255)  NOT NULL
PRIMARY KEY(id_autor)
)
GO
CREATE TABLE editora (
id_editora        INT           NOT NULL       IDENTITY(491,16),
nome              VARCHAR(70)   NOT NULL       UNIQUE,
telefone          VARCHAR(11)   NOT NULL       CHECK(LEN(telefone) = 10),
logradouro        VARCHAR(200)  NOT NULL,
numero            INT           NOT NULL       CHECK(numero > 0),
cep               CHAR(8)       NOT NULL       CHECK(LEN(cep) = 8),
complemento       VARCHAR(255)  NOT NULL
PRIMARY KEY(id_editora)
)
GO
CREATE TABLE edicao (
isbn             CHAR(13)       NOT NULL        CHECK(LEN(isbn) = 13),
preco            DECIMAL(4,2)   NOT NULL        CHECK(preco > 0.00),
ano              INT            NOT NULL        CHECK(ano >= '1993-12-31'),
numero_paginas   INT            NOT NULL        CHECK(numero_paginas >= 15),
qtd_estoque      INT            NOT NULL
PRIMARY KEY(isbn)
)
GO
CREATE TABLE livro_autor (
livroCodigo      INT            NOT NULL,
autorid_autor    INT            NOT NULL
PRIMARY KEY(livroCodigo, autorid_autor)
FOREIGN KEY(livroCodigo) REFERENCES livro (codigo),
FOREIGN KEY(autorid_autor) REFERENCES autor (id_autor)
)
GO
CREATE TABLE editora_edicao_livro (
editoraid_editora      INT         NOT NULL,
edicaoISBN             CHAR(13)    NOT NULL,
livroCodigo            INT         NOT NULL
PRIMARY KEY(editoraid_editora, edicaoISBN, livroCodigo)
FOREIGN KEY(editoraid_editora) REFERENCES editora (id_editora),
FOREIGN KEY(edicaoISBN) REFERENCES edicao (ISBN),
FOREIGN KEY(livroCodigo) REFERENCES livro (codigo)
)

EXEC sp_help livro
EXEC sp_help autor
EXEC sp_help editora
EXEC sp_help edicao
EXEC sp_help livro_autor
EXEC sp_help editora_edicao_livro