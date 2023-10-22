CREATE DATABASE mecanica
GO
USE mecanica
GO
CREATE TABLE cliente (
ID             INT            NOT NULL       IDENTITY(3401,15),
nome           VARCHAR(100)   NOT NULL,
logradouro     VARCHAR(200)   NOT NULL,
numero         INT            NOT NULL       CHECK(numero > 0),
cep            CHAR(8)        NOT NULL       CHECK(LEN(cep) = 8),
complemento    VARCHAR(255)   NOT NULL
PRIMARY KEY(ID)
)
GO
CREATE TABLE peca (
ID             INT            NOT NULL         IDENTITY(3411,7),
nome           VARCHAR(30)    NOT NULL         UNIQUE,
preco          DECIMAL(4,2)   NOT NULL         CHECK(preco > 0.00),
estoque        INT            NOT NULL         CHECK(estoque >= 10)
PRIMARY KEY(ID)
)
GO 
CREATE TABLE categoria (
ID             INT            NOT NULL         IDENTITY(1,1),
categoria      VARCHAR(10)    NOT NULL         CHECK(categoria = 'Estagiario' OR categoria = 'Nivel 1' 
                                                             OR categoria = 'Nivel 2' OR categoria = 'Nivel 3'),
valor_hora     DECIMAL(4,2)   NOT NULL         CHECK(valor_hora > 0.00)
PRIMARY KEY(ID)
CONSTRAINT chk_categoria_valor_hora    CHECK(categoria = 'Estagiario' AND valor_hora > 15.00) 
     OR (categoria = 'Nivel 1' AND valor_hora > 25.00) OR (categoria = 'Nivel 2' AND valor_hora > 35.00)
      OR (categoria = 'Nivel 3' AND valor_hora > 50.00)
)
GO
CREATE TABLE telefone_cliente (
clienteID       INT           NOT NULL,
telefone        VARCHAR(11)   NOT NULL         CHECK(LEN(telefone) = 10  OR (telefone) = 11)
PRIMARY KEY(clienteID)
FOREIGN KEY(clienteID) REFERENCES cliente (ID)
)
GO
CREATE TABLE veiculo (
placa                CHAR(7)        NOT NULL        CHECK(LEN(placa) = 7),
marca                VARCHAR(30)    NOT NULL,
modelo               VARCHAR(30)    NOT NULL,
cor                  VARCHAR(15)    NOT NULL,
ano_fabricacao       INT            NOT NULL        CHECK(ano_fabricacao > '1997-12-31'),
ano_modelo           INT            NOT NULL        CHECK(ano_modelo > '1997-12-31'),
data_aquisicao       DATE           NOT NULL,
clienteID            INT            NOT NULL
PRIMARY KEY(placa)
FOREIGN KEY(clienteID) REFERENCES cliente (ID)
)
GO
CREATE TABLE funcionario (
ID                    INT           NOT NULL        IDENTITY(101,1),
nome                  VARCHAR(100)  NOT NULL,
logradouro            VARCHAR(200)  NOT NULL,
numero                INT           NOT NULL        CHECK(numero > 0),
telefone              CHAR(11)      NOT NULL        CHECK(LEN(telefone) = 10  OR (telefone) = 11),
categoria_habilitacao VARCHAR(2)    NOT NULL        CHECK(categoria_habilitacao = 'A' OR categoria_habilitacao = 'B' 
                        OR categoria_habilitacao = 'C' OR categoria_habilitacao = 'D' OR categoria_habilitacao = 'E'),
categoriaID           INT           NOT NULL
PRIMARY KEY(ID)
FOREIGN KEY(categoriaID) REFERENCES categoria (ID)
)
GO
CREATE TABLE reparo (
veiculoPlaca           CHAR(7)       NOT NULL,
funcionarioID          INT           NOT NULL,
pecaID                 INT           NOT NULL,
data_reparo            DATE          NOT NULL,
custo_total            DECIMAL(4,2)  NOT NULL        CHECK(custo_total > 0.00),
tempo                  INT           NOT NULL        CHECK(tempo > 0)
PRIMARY KEY(veiculoPlaca, funcionarioID, pecaID, data_reparo)
FOREIGN KEY(veiculoPlaca) REFERENCES veiculo (placa),
FOREIGN KEY(funcionarioID) REFERENCES funcionario (ID),
FOREIGN KEY(pecaID) REFERENCES peca (ID)
)

EXEC sp_help cliente
EXEC sp_help peca
EXEC sp_help categoria
EXEC sp_help telefone_cliente
EXEC sp_help veiculo
EXEC sp_help funcionario
EXEC sp_help reparo
