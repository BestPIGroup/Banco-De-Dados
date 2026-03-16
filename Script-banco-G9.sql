create database projeto_Argos;

use projeto_Argos;

CREATE TABLE unidade (
	id_unidade INT PRIMARY KEY AUTO_INCREMENT,
    cod_unidade INT NOT NULL UNIQUE,
    cep CHAR(8) NOT NULL UNIQUE,
    cidade VARCHAR(100) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL
);

CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone CHAR(16) NOT NULL UNIQUE,
    funcao VARCHAR(255) NOT NULL,
    matricula INT NOT NULL UNIQUE,
    fk_responsavel INT,
    fk_unidade INT,
    FOREIGN KEY (fk_responsavel) REFERENCES usuario(id_usuario),
    FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade)
);

CREATE TABLE permissoes (
	id_permissoes INT PRIMARY KEY AUTO_INCREMENT,
    nivel_usuario INT NOT NULL,
    fk_usuario INT,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE servidor (
	id_servidor INT,
    id_token int,
    fornecedor VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie INT NOT NULL,
    ultima_manutencao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_servidor VARCHAR(45) NOT NULL,
    fk_unidade INT,
    FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade),
    primary key (id_servidor, id_token)
);

CREATE TABLE token (
	id_token INT,
	fk_servidor INT,
    fk_usuario INT,
    token INT NOT NULL UNIQUE,
    end_check DATETIME NOT NULL,
    PRIMARY KEY(id_token, fk_servidor, fk_usuario),
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor),
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE componentes (
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    unidade_medida VARCHAR(45) NOT NULL,
    biblioteca VARCHAR(100) NOT NULL,
    parametros VARCHAR(100) NOT NULL,
    id_servidorComponente INT,
    fk_servidor int,
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor)
);

CREATE TABLE registro (
	id_info INT PRIMARY KEY AUTO_INCREMENT,
    fk_servidor INT,
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor),
    fk_componente INT,
    valor float,
    FOREIGN KEY (fk_componente) REFERENCES componentes(id_componente)
);

CREATE TABLE Limite_Componente (
	id_servidor INT,
    id_componente INT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    unidade_medida VARCHAR(45),
    biblioteca VARCHAR(45),
    parametros VARCHAR(45),
    PRIMARY KEY (id_servidor, id_componente),
    FOREIGN KEY (id_servidor) REFERENCES servidor(id_servidor),
    FOREIGN KEY (id_componente) REFERENCES componentes(id_componente)
);


