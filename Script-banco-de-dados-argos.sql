-- ARGOS GRUPO 10
-- drop database projeto_Argos;

CREATE DATABASE projeto_Argos;
USE projeto_Argos;

CREATE TABLE unidade (
	id_unidade INT PRIMARY KEY AUTO_INCREMENT,
    cod_unidade INT NOT NULL UNIQUE,
    cep CHAR(8) NOT NULL UNIQUE,
    cidade VARCHAR(45) NOT NULL,
    rua VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL
);

CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    telefone CHAR(12) NOT NULL UNIQUE,
    funcao VARCHAR(45) NOT NULL,
    matricula INT NOT NULL UNIQUE,
    permissoes VARCHAR (45),
    fk_responsavel INT,
    CONSTRAINT fk_responsavel_usuario
		FOREIGN KEY (fk_responsavel) 
			REFERENCES usuario(id_usuario)
);

CREATE TABLE servidor (
	id_servidor INT PRIMARY KEY AUTO_INCREMENT,
    fornecedor VARCHAR(45) NOT NULL,
    modelo VARCHAR(45) NOT NULL,
    numero_serie VARCHAR(45) NOT NULL UNIQUE,
    status_servidor VARCHAR(45) NOT NULL,
    fk_unidade INT,
    CONSTRAINT fk_unidade_servidor
		FOREIGN KEY (fk_unidade) 
			REFERENCES unidade(id_unidade)
);

CREATE TABLE token (
	id_token INT,
    token INT NOT NULL UNIQUE,
    end_check DATETIME NOT NULL,
    fk_usuario INT,
    CONSTRAINT fk_usuario_token
		FOREIGN KEY (fk_usuario) 
			REFERENCES usuario(id_usuario),
    fk_unidade INT NOT NULL UNIQUE,
    CONSTRAINT fk_unidade_usuario
		FOREIGN KEY (fk_unidade) 
			REFERENCES unidade(id_unidade),
	PRIMARY KEY (id_token, fk_usuario, fk_unidade)
);

CREATE TABLE componentes (
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (45) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    unidade_medida VARCHAR(45) NOT NULL,
    biblioteca VARCHAR(45) NOT NULL,
    parametros VARCHAR(45) NOT NULL
);

CREATE TABLE componente_servidor (
	id_servidor INT NOT NULL UNIQUE,
    CONSTRAINT id_servidor
		FOREIGN KEY (id_servidor) 
			REFERENCES servidor(id_servidor),
    id_componente INT NOT NULL UNIQUE,
    CONSTRAINT id_componente
		FOREIGN KEY (id_componente) 
			REFERENCES componentes(id_componente),
    limite_componente INT NOT NULL,
    PRIMARY KEY (id_servidor, id_componente)
);

CREATE TABLE registro (
	id_registro INT,
    valor FLOAT NOT NULL,
    data_Hora DATETIME NOT NULL,
    id_componente INT NOT NULL,
    CONSTRAINT id_componente_servidor
		FOREIGN KEY (id_componente) 
			REFERENCES componente_servidor(id_componente),
	id_servidor INT NOT NULL,
    CONSTRAINT id_servidor_componente
		FOREIGN KEY (id_servidor) 
			REFERENCES componente_servidor(id_servidor),
	PRIMARY KEY (id_registro, id_componente, id_servidor)
);