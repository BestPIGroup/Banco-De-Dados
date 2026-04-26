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
select * from unidade;
INSERT INTO unidade (cod_unidade, cep, cidade, rua, bairro, estado) VALUES
(1, '01001000', 'São Paulo', 'Praça da Sé', 'Sé', 'SP'),
(2, '01311000', 'São Paulo', 'Av. Paulista', 'Bela Vista', 'SP'),
(3, '02020000', 'São Paulo', 'Rua Voluntários da Pátria', 'Santana', 'SP'),
(4, '03045000', 'São Paulo', 'Rua Tuiuti', 'Tatuapé', 'SP'),
(5, '05010000', 'São Paulo', 'Rua Clélia', 'Lapa', 'SP');

CREATE TABLE usuario (
	id_usuario INT NOT NULL AUTO_INCREMENT,
    fk_unidade INT NOT NULL,
    CONSTRAINT fk_unidade_usuario
		FOREIGN KEY (fk_unidade)
			REFERENCES unidade(id_unidade),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    funcao VARCHAR(45) NOT NULL,
    identificador INT NOT NULL UNIQUE,
    fk_responsavel INT,
    CONSTRAINT fk_responsavel_usuario
		FOREIGN KEY (fk_responsavel) 
			REFERENCES usuario(id_usuario),
	PRIMARY KEY (id_usuario, fk_unidade)
);

-- Responsáveis (sem fk_responsavel)
INSERT INTO usuario (id_usuario,fk_unidade, nome, email, senha, telefone, funcao, identificador, fk_responsavel) VALUES
(default, 1,'Carlos Silva', 'carlos.silva@argos.com', 'senha123', '11999990001', 'Administrador', 9001, NULL),
(default,2, 'Fernanda Souza', 'fernanda.souza@argos.com', 'senha123', '11999990002', 'Administrador', 9002, NULL),
(default,3, 'Ricardo Alves', 'ricardo.alves@argos.com', 'senha123', '11999990003', 'Administrador', 9003, NULL);

-- Técnicos subordinados
INSERT INTO usuario (fk_unidade, nome, email, senha, telefone, funcao, identificador, fk_responsavel) VALUES
(1, 'João Pereira', 'joao.pereira@argos.com', 'senha123', '11988880001', 'Técnico', 1, 1),
(1, 'Marcos Lima', 'marcos.lima@argos.com', 'senha123', '11988880002', 'Técnico', 2, 1),
(2, 'Ana Costa', 'ana.costa@argos.com', 'senha123', '11988880003', 'Técnico', 3, 2),
(3, 'Paula Mendes', 'paula.mendes@argos.com', 'senha123', '11988880004', 'Técnico', 4, 3),
(4, 'Lucas Rocha', 'lucas.rocha@argos.com', 'senha123', '11988880005', 'Técnico', 5, 1),
(5, 'Bruno Ferreira', 'bruno.ferreira@argos.com', 'senha123', '11988880006', 'Técnico', 6, 2);

CREATE TABLE servidor (
	id_servidor INT PRIMARY KEY AUTO_INCREMENT,
    alias VARCHAR(45) NOT NULL,
    endereco_mac CHAR(17) NOT NULL UNIQUE,
    status_servidor VARCHAR(45) NOT NULL,
    CONSTRAINT status_servidor 
		CHECK(status_servidor IN ('Manutenção', 'Inativo', 'Ativo')),
    fk_unidade INT,
    CONSTRAINT fk_unidade_servidor
		FOREIGN KEY (fk_unidade) 
			REFERENCES unidade(id_unidade)
);

INSERT INTO servidor (alias,endereco_mac, status_servidor, fk_unidade) VALUES
("a",'bc:cd:99:c2:86:34', 'Ativo', 1),
("a",'FA:28:9D:A9:BC:0B', 'Ativo', 1),
("a",'00:1A:2B:3C:4D:03', 'Manutenção', 2),
("a",'00:1A:2B:3C:4D:04', 'Ativo', 2),
("a",'00:1A:2B:3C:4D:05', 'Inativo', 3),
("a",'00:1A:2B:3C:4D:06', 'Ativo', 3),
("a",'00:1A:2B:3C:4D:07', 'Manutenção', 4),
("a",'00:1A:2B:3C:4D:08', 'Ativo', 4),
("a",'00:1A:2B:3C:4D:09', 'Inativo', 5),
("a",'00:1A:2B:3C:4D:10', 'Ativo', 5);

CREATE TABLE componente (
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (45) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    unidade_medida VARCHAR(45) NOT NULL,
    biblioteca VARCHAR(45) NOT NULL,
    parametro VARCHAR(45) NOT NULL
);

INSERT INTO componente (nome, tipo, unidade_medida, biblioteca, parametro) VALUES
('Uso de CPU (%)', 'CPU', 'Percentual', 'psutil', 'cpu_percent'),
('Tempo de CPU (user)', 'CPU', 'Segundos', 'psutil', 'cpu_times_user'),
('Trocas de contexto', 'CPU', 'Quantidade', 'psutil', 'cpu_ctx_switches'),
('Memória Total', 'Memoria', 'Bytes', 'psutil', 'virtual_memory_total'),
('Memória Disponível', 'Memoria', 'Bytes', 'psutil', 'virtual_memory_available'),
('Memória Usada (%)', 'Memoria', 'Percentual', 'psutil', 'virtual_memory_used_percent'),
('Leitura de Disco', 'Disco', 'Bytes', 'psutil', 'disk_read_bytes'),
('Escrita de Disco', 'Disco', 'Bytes', 'psutil', 'disk_write_bytes'),
('Uso de Disco (%)', 'Disco', 'Percentual', 'psutil', 'disk_percent'),
('Bytes Enviados', 'Rede', 'Bytes', 'psutil', 'net_bytes_sent'),
('Bytes Recebidos', 'Rede', 'Bytes', 'psutil', 'net_bytes_recv'),
('Pacotes Enviados', 'Rede', 'Quantidade', 'psutil', 'net_packets_sent'),
('Pacotes Recebidos', 'Rede', 'Quantidade', 'psutil', 'net_packets_recv'),
('Erros de Entrada', 'Rede', 'Quantidade', 'psutil', 'net_errin'),
('Erros de Saída', 'Rede', 'Quantidade', 'psutil', 'net_errout'),
('Pacotes Perdidos Entrada', 'Rede', 'Quantidade', 'psutil', 'net_dropin'),
('Pacotes Perdidos Saída', 'Rede', 'Quantidade', 'psutil', 'net_dropout'),
('Total de Processos', 'Processo', 'Quantidade', 'psutil', 'total_processos'),
('PID com maior uso de CPU', 'Processo', 'ID', 'psutil', 'processo_pid_max_cpu'),
('Nome do processo (maior CPU)', 'Processo', 'Texto', 'psutil', 'processo_nome_max_cpu'),
('Uso CPU processo (%)', 'Processo', 'Percentual', 'psutil', 'processo_cpu_percent_max_cpu'),
('Usuários Logados', 'Sistema', 'Quantidade', 'psutil', 'usuarios_logados');

CREATE TABLE componente_servidor (
	id_servidor INT NOT NULL,
    CONSTRAINT id_servidor
		FOREIGN KEY (id_servidor) 
			REFERENCES servidor(id_servidor),
    id_componente INT NOT NULL,
    CONSTRAINT id_componente
		FOREIGN KEY (id_componente) 
			REFERENCES componente(id_componente),
    limite_componente INT NOT NULL,
    exibir BOOLEAN,
    PRIMARY KEY (id_servidor, id_componente)
);

INSERT INTO componente_servidor (id_servidor, id_componente, limite_componente, exibir) VALUES
(1, 1, 80, TRUE),
(1, 6, 80, TRUE),
(1, 9, 85, TRUE);

CREATE TABLE registro (
	id_registro INT,
    id_componente INT NOT NULL,
    CONSTRAINT id_componente_servidor
		FOREIGN KEY (id_componente) 
			REFERENCES componente_servidor(id_componente),
	id_servidor INT NOT NULL,
    CONSTRAINT id_servidor_componente
		FOREIGN KEY (id_servidor) 
			REFERENCES componente_servidor(id_servidor),
    valor FLOAT NOT NULL,
    data_Hora DATETIME NOT NULL,
	PRIMARY KEY (id_registro, id_componente, id_servidor)
);

INSERT INTO registro (id_registro, id_componente, id_servidor, valor, data_Hora) VALUES
(1, 1, 1, 45.5, '2026-04-01 10:00:00'),
(2, 1, 1, 67.2, '2026-04-01 10:05:00'),
(3, 1, 1, 82.1, '2026-04-01 10:10:00'),
(4, 6, 1, 32, '2026-04-01 10:00:00'),
(5, 6, 1, 28.4, '2026-04-01 10:05:00'),
(6, 6, 1, 25.7, '2026-04-01 10:10:00'),
(7, 9, 1, 60.3, '2026-04-01 10:00:00'),
(8, 9, 1, 75.8, '2026-04-01 10:05:00'),
(9, 9, 1, 88.4, '2026-04-01 10:10:00');

show tables;

select * from componente;
select * from componente_servidor;
select * from registro;
select * from servidor;
select * from unidade;
select * from usuario;
