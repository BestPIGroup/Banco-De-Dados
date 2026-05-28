-- ARGOS GRUPO 10
-- drop database projeto_Argos;

CREATE DATABASE IF NOT EXISTS projeto_Argos;
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

INSERT INTO unidade (cod_unidade, cep, cidade, rua, bairro, estado) VALUES
(1, '01001000', 'São Paulo', 'Praça da Sé', 'Sé', 'SP'),
(2, '01311000', 'São Paulo', 'Av. Paulista', 'Bela Vista', 'SP'),
(3, '02020000', 'São Paulo', 'Rua Voluntários da Pátria', 'Santana', 'SP'),
(4, '03045000', 'São Paulo', 'Rua Tuiuti', 'Tatuapé', 'SP'),
(5, '05010000', 'São Paulo', 'Rua Clélia', 'Lapa', 'SP');

CREATE TABLE usuario (
	id_usuario INT UNIQUE NOT NULL AUTO_INCREMENT,
    fk_unidade INT NOT NULL,
    CONSTRAINT fk_unidade_usuario
		FOREIGN KEY (fk_unidade)
			REFERENCES unidade(id_unidade),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    funcao VARCHAR(45) NOT NULL,
    identificador VARCHAR(10) NOT NULL UNIQUE,
    fk_responsavel INT,
    CONSTRAINT fk_responsavel_usuario
		FOREIGN KEY (fk_responsavel)
			REFERENCES usuario(id_usuario),
	PRIMARY KEY (id_usuario, fk_unidade)
);

-- Responsáveis (sem fk_responsavel)
INSERT INTO usuario (id_usuario,fk_unidade, nome, email, senha, telefone, funcao, identificador, fk_responsavel) VALUES
(default, 1,'Julia Sanches', 'julia.sanches@argos.com', 'senha123', '11999990001', 'Gestor', 9001, NULL),
(default, 2, 'Fernanda Souza', 'fernanda.souza@argos.com', 'senha123', '11999990002', 'Gestor', 9002, NULL),
(default, 3, 'Ricardo Alves', 'ricardo.alves@argos.com', 'senha123', '11999990003', 'Gestor', 9003, NULL);

-- Analistas subordinados
INSERT INTO usuario (fk_unidade, nome, email, senha, telefone, funcao, identificador, fk_responsavel) VALUES
(1, 'Marcio Lima', 'marcio.lima@argos.com', 'senha123', '11988880001', 'Analista', 1, 1),
(1, 'Marcos Pereira', 'marcos.pereira@argos.com', 'senha123', '11988880002', 'Analista', 2, 1),
(2, 'Ana Costa', 'ana.costa@argos.com', 'senha123', '11988880003', 'Analista', 3, 2),
(3, 'Paula Mendes', 'paula.mendes@argos.com', 'senha123', '11988880004', 'Analista', 4, 3),
(4, 'Lucas Rocha', 'lucas.rocha@argos.com', 'senha123', '11988880005', 'Analista', 5, 1),
(5, 'Bruno Ferreira', 'bruno.ferreira@argos.com', 'senha123', '11988880006', 'Analista', 6, 2);

CREATE TABLE servidor (
    id_servidor INT PRIMARY KEY AUTO_INCREMENT,
    alias VARCHAR(45) NOT NULL,
    endereco_mac CHAR(17) NOT NULL UNIQUE,
    status_servidor VARCHAR(45) NOT NULL,
    CONSTRAINT status_servidor_check
        CHECK(status_servidor IN ('Manutenção', 'Inativo', 'Ativo')),
    fk_unidade INT,
    CONSTRAINT fk_unidade_servidor
        FOREIGN KEY (fk_unidade)
            REFERENCES unidade(id_unidade)
);

INSERT INTO servidor (alias,endereco_mac, status_servidor, fk_unidade) VALUES
('miyuki','bc:cd:99:c2:86:34', 'Ativo', 1),
('flavia','f4:28:9d:a9:bc:0b', 'Ativo', 1),
('murilo','4c:44:5b:f2:74:61', 'Ativo', 1),
('lua', 'ec:91:61:8b:20:4b', 'Ativo', 1),
('victor', '00:d7:6d:20:c0:88', 'Ativo', 1),
('kaio', 'a0:85:27:18:03:0d', 'Ativo', 1),
('1','00:1A:2B:3C:4D:03', 'Manutenção', 2),
('2','00:1A:2B:3C:4D:04', 'Ativo', 2),
('1','00:1A:2B:3C:4D:05', 'Inativo', 3),
('2','00:1A:2B:3C:4D:06', 'Ativo', 3),
('1','00:1A:2B:3C:4D:07', 'Manutenção', 4),
('2','00:1A:2B:3C:4D:08', 'Ativo', 4),
('1','00:1A:2B:3C:4D:09', 'Inativo', 5),
('2','00:1A:2B:3C:4D:10', 'Ativo', 5);

CREATE TABLE componente (
	id_componente INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
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
('Memoria Total', 'Memoria', 'Bytes', 'psutil', 'virtual_memory_total'),
('Memoria Disponivel', 'Memoria', 'Bytes', 'psutil', 'virtual_memory_available'),
('Memoria Usada (%)', 'Memoria', 'Percentual', 'psutil', 'virtual_memory_used_percent'),
('Leitura de Disco (MB/s)', 'Disco', 'Megabytes', 'psutil', 'disk_read_bytes'),
('Escrita de Disco (MB/s)', 'Disco', 'Megabytes', 'psutil', 'disk_write_bytes'),
('Uso de Disco (%)', 'Disco', 'Percentual', 'psutil', 'disk_percent'),
('Bytes Enviados', 'Rede', 'Bytes', 'psutil', 'net_bytes_sent'),
('Bytes Recebidos', 'Rede', 'Bytes', 'psutil', 'net_bytes_recv'),
('Pacotes Enviados', 'Rede', 'Quantidade', 'psutil', 'net_packets_sent'),
('Pacotes Recebidos', 'Rede', 'Quantidade', 'psutil', 'net_packets_recv'),
('Erros de Entrada', 'Rede', 'Quantidade', 'psutil', 'net_errin'),
('Erros de Saida', 'Rede', 'Quantidade', 'psutil', 'net_errout'),
('Pacotes Perdidos Entrada', 'Rede', 'Quantidade', 'psutil', 'net_dropin'),
('Pacotes Perdidos Saida', 'Rede', 'Quantidade', 'psutil', 'net_dropout'),
('Total de Processos', 'Processo', 'Quantidade', 'psutil', 'total_processos'),
('PID com maior uso de CPU', 'Processo', 'ID', 'psutil', 'processo_pid_max_cpu'),
('Nome do processo (maior CPU)', 'Processo', 'Texto', 'psutil', 'processo_nome_max_cpu'),
('Uso CPU processo (%)', 'Processo', 'Percentual', 'psutil', 'processo_cpu_percent_max_cpu'),
('Usuarios Logados', 'Sistema', 'Quantidade', 'psutil', 'usuarios_logados'),
('Arquivos Abertos', 'Arquivos', 'Quantidade', 'psutil', 'arquivos_abertos');


CREATE TABLE componente_servidor (
    id_servidor INT NOT NULL,
    id_componente INT NOT NULL,
    limite_componente INT NOT NULL,
    exibir BOOLEAN,
    PRIMARY KEY (id_servidor, id_componente),
    CONSTRAINT fk_comp_servidor_servidor
        FOREIGN KEY (id_servidor)
            REFERENCES servidor(id_servidor),
    CONSTRAINT fk_comp_servidor_componente
        FOREIGN KEY (id_componente)
            REFERENCES componente(id_componente)
);

INSERT INTO componente_servidor (id_servidor, id_componente, limite_componente, exibir) VALUES
(1, 1, 80, TRUE),
(1, 6, 80, TRUE),
(1, 7, 100, TRUE),
(1, 8, 100, TRUE),
(1, 9, 85, TRUE),
(1, 23, 3000, TRUE),
(2, 1, 80, TRUE),
(2, 6, 80, TRUE),
(2, 9, 85, TRUE),
(3, 1, 80, TRUE),
(3, 6, 80, TRUE),
(3, 9, 85, TRUE),
(4, 1, 80, TRUE),
(4, 6, 80, TRUE),
(4, 9, 85, TRUE),
(5, 1, 80, TRUE),
(5, 6, 80, TRUE),
(5, 9, 85, TRUE),
(6, 1, 80, TRUE),
(6, 6, 80, TRUE),
(6, 9, 85, TRUE);

show tables;

select * from componente;
select * from componente_servidor;
select * from servidor;
select * from unidade;
select * from usuario;