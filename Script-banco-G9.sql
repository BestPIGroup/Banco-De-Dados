


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
    fk_usuario INT NOT NULL,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE servidor (
	id_servidor INT PRIMARY KEY AUTO_INCREMENT,
    fornecedor VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(10) NOT NULL UNIQUE,
    status_servidor VARCHAR(45) NOT NULL,
    fk_unidade INT,
    FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade)
);

CREATE TABLE token (
	id_token INT PRIMARY KEY AUTO_INCREMENT,
	fk_servidor INT NOT NULL UNIQUE,
    token INT NOT NULL UNIQUE,
    end_check DATETIME NOT NULL,
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor)
);

CREATE TABLE componentes (
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    unidade_medida VARCHAR(45) NOT NULL,
    biblioteca VARCHAR(100) NOT NULL,
    parametros VARCHAR(100) NOT NULL,
    fk_servidor int,
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor)
);

CREATE TABLE registro (
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
    fk_componentes INT NOT NULL,
    FOREIGN KEY (fk_componentes) REFERENCES componentes(id_componente),
    valor FLOAT NOT NULL,
    Data_Hora DATETIME NOT NULL
);

CREATE TABLE Limite_Componente (
	id_limite INT PRIMARY KEY AUTO_INCREMENT,
    fk_componente INT NOT NULL UNIQUE,
    FOREIGN KEY (fk_componente) REFERENCES componentes (id_componente),
    limite_componente INT NOT NULL
);