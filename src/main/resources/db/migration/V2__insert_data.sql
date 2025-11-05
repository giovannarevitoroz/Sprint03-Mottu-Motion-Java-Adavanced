-- Drop tables se existirem
DROP TABLE IF EXISTS movimentacao;
DROP TABLE IF EXISTS vaga;
DROP TABLE IF EXISTS setor;
DROP TABLE IF EXISTS gerente;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS moto;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS patio;
DROP TABLE IF EXISTS cargo;
DROP TABLE IF EXISTS usuario;

-- 1. cargo
CREATE TABLE cargo (
    id_cargo BIGSERIAL PRIMARY KEY,
    nome_cargo VARCHAR(50) NOT NULL,
    descricao_cargo VARCHAR(255)
);

-- 2. cliente
CREATE TABLE cliente (
    id_cliente BIGSERIAL PRIMARY KEY,
    telefone_cliente VARCHAR(11) NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    sexo_cliente CHAR(1) NOT NULL,
    email_cliente VARCHAR(100) NOT NULL,
    cpf_cliente VARCHAR(11) NOT NULL UNIQUE
);

-- 3. patio
CREATE TABLE patio (
    id_patio BIGSERIAL PRIMARY KEY,
    localizacao_patio VARCHAR(100) NOT NULL,
    nome_patio VARCHAR(100) NOT NULL,
    descricao_patio VARCHAR(255)
);

-- 4. moto
CREATE TABLE moto (
    id_moto BIGSERIAL PRIMARY KEY,
    placa_moto VARCHAR(7) UNIQUE,
    modelo_moto VARCHAR(70) NOT NULL,
    situacao_moto VARCHAR(50) NOT NULL,
    chassi_moto VARCHAR(17) NOT NULL UNIQUE,
    cliente_id_cliente BIGINT REFERENCES cliente(id_cliente),
    CONSTRAINT chk_modelo_moto CHECK (modelo_moto IN ('Mottu Pop', 'Mottu Sport', 'Mottu-E')),
    CONSTRAINT chk_situacao_moto CHECK (situacao_moto IN ('Inativa', 'Ativa', 'Manutenção', 'Em Trânsito'))
);

-- 5. setor
CREATE TABLE setor (
    id_setor BIGSERIAL PRIMARY KEY,
    tipo_setor VARCHAR(70) NOT NULL,
    patio_id_patio BIGINT NOT NULL REFERENCES patio(id_patio),
    status_setor VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_setor CHECK (tipo_setor IN (
        'Pendência', 'Reparos Simples', 'Danos Estruturais Graves',
        'Motor Defeituoso', 'Agendada Para Manutenção', 'Pronta para Aluguel',
        'Sem Placa', 'Minha Mottu'
    )),
    CONSTRAINT chk_status_setor CHECK (status_setor IN ('Cheia', 'Parcial', 'Livre'))
);

-- 6. vaga
CREATE TABLE vaga (
    id_vaga BIGSERIAL PRIMARY KEY,
    numero_vaga VARCHAR(10) NOT NULL,
    status_ocupada BOOLEAN DEFAULT FALSE NOT NULL,
    setor_id_setor BIGINT NOT NULL REFERENCES setor(id_setor)
);

-- 7. movimentacao
CREATE TABLE movimentacao (
    id_movimentacao BIGSERIAL PRIMARY KEY,
    dt_entrada TIMESTAMP NOT NULL,
    dt_saida TIMESTAMP NULL,
    descricao_movimentacao VARCHAR(255),
    moto_id_moto BIGINT NOT NULL REFERENCES moto(id_moto) ON DELETE CASCADE,
    vaga_id_vaga BIGINT NOT NULL REFERENCES vaga(id_vaga) ON DELETE CASCADE
);

-- 8. funcionario
CREATE TABLE funcionario (
    id_funcionario BIGSERIAL PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    telefone_funcionario VARCHAR(11) NOT NULL,
    cargo_id_cargo BIGINT NOT NULL REFERENCES cargo(id_cargo),
    patio_id_patio BIGINT NOT NULL REFERENCES patio(id_patio)
);

-- 9. gerente
CREATE TABLE gerente (
    id_gerente BIGSERIAL PRIMARY KEY,
    nome_gerente VARCHAR(100) NOT NULL,
    telefone_gerente VARCHAR(11) NOT NULL,
    cpf_gerente VARCHAR(11) NOT NULL UNIQUE,
    patio_id_patio BIGINT NOT NULL UNIQUE REFERENCES patio(id_patio)
);

-- 10. usuario
CREATE TABLE usuario (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- ===========================
-- Inserção de dados
-- ===========================

-- cargo
INSERT INTO cargo (nome_cargo, descricao_cargo) VALUES
('Auxiliar', 'Responsável por auxiliar nas tarefas gerais da empresa'),
('Mecânico', 'Responsável por realizar reparos e manutenções em motos'),
('Limpador', 'Responsável pela limpeza de áreas veículos'),
('Atendente', 'Atendimento ao cliente e suporte nas atividades da empresa'),
('Supervisor', 'Responsável por supervisionar as atividades operacionais'),
('Zelador', 'Responsável pela conservação e manutenção das instalações');

-- cliente
INSERT INTO cliente (telefone_cliente, nome_cliente, sexo_cliente, email_cliente, cpf_cliente) VALUES
('11912345678', 'Carlos Silva', 'M', 'carlos@email.com', '12345678900'),
('11987654321', 'Maria Souza', 'F', 'maria@email.com', '23456789011'),
('1188887777', 'João Mendes', 'M', 'joao@email.com', '34567890122'),
('1177776666', 'Ana Paula', 'F', 'ana@email.com', '45678901233'),
('1166665555', 'Bruno Rocha', 'M', 'bruno@email.com', '56789012344'),
('1155554444', 'Juliana Lima', 'F', 'juliana@email.com', '67890123455');

-- patio
INSERT INTO patio (localizacao_patio, nome_patio, descricao_patio) VALUES
('Zona Norte', 'Pátio Norte', 'Área ampla e coberta'),
('Zona Sul', 'Pátio Sul', 'Coberto parcialmente'),
('Zona Leste', 'Pátio Leste', 'Perto da oficina'),
('Zona Oeste', 'Pátio Oeste', 'Com iluminação noturna');

-- moto
INSERT INTO moto (placa_moto, modelo_moto, situacao_moto, chassi_moto, cliente_id_cliente) VALUES
('ABC1234', 'Mottu Pop', 'Em Trânsito', 'CHS12345678901234', 1),
('DEF5678', 'Mottu Sport', 'Em Trânsito', 'CHS22345678901234', 2);

-- setor
INSERT INTO setor (tipo_setor, patio_id_patio, status_setor) VALUES
('Pendência', 1, 'Parcial'),
('Reparos Simples', 1, 'Parcial');

-- vaga
INSERT INTO vaga (numero_vaga, status_ocupada, setor_id_setor) VALUES
('A1-V1', FALSE, 1),
('A1-V2', TRUE, 1);

-- movimentacao
INSERT INTO movimentacao (dt_entrada, dt_saida, descricao_movimentacao, moto_id_moto, vaga_id_vaga) VALUES
('2025-01-02 00:00:00', '2025-01-03 00:00:00', 'Aguardando liberação', 1, 1),
('2025-01-04 00:00:00', '2025-01-05 00:00:00', 'Em análise documental', 2, 2);

-- funcionario
INSERT INTO funcionario (nome_funcionario, telefone_funcionario, cargo_id_cargo, patio_id_patio) VALUES
('Ricardo Ramos', '11911112222', 1, 1),
('Tatiane Luz', '11922223333', 2, 2);

-- gerente
INSERT INTO gerente (nome_gerente, telefone_gerente, cpf_gerente, patio_id_patio) VALUES
('Rodrigo Neves', '11900001111', '99999999900', 1),
('Carla Pires', '11900002222', '88888888801', 2);

-- usuario
INSERT INTO usuario (username, password, role) VALUES
('admin', 'senha123', 'ADMIN'),
('user1', 'senha456', 'USER');

-- teste de consulta
SELECT * FROM cliente;
