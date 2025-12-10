-- ============================================
-- MEDSMART - BANCO DE DADOS COMPLETO
-- Script único para criação do banco
-- Execute no MySQL Workbench, phpMyAdmin ou linha de comando
-- ============================================

-- 1. REMOVER BANCO EXISTENTE E CRIAR NOVO (CUIDADO: APAGA DADOS EXISTENTES!)
DROP DATABASE IF EXISTS medsmart_db;
CREATE DATABASE medsmart_db;
USE medsmart_db;

-- 2. TABELA USUARIO
CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    tipo_usuario CHAR(1) NOT NULL,
    plano VARCHAR(20) NOT NULL DEFAULT 'Free',
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_tipo_usuario (tipo_usuario)
);

-- 3. TABELA PACIENTE
CREATE TABLE PACIENTE (
    id_paciente INT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    tipo_sanguineo VARCHAR(3),
    peso DECIMAL(5,2),
    altura DECIMAL(3,2),
    endereco_cep VARCHAR(9),
    endereco_logradouro VARCHAR(200),
    endereco_numero VARCHAR(10),
    endereco_complemento VARCHAR(100),
    endereco_bairro VARCHAR(100),
    endereco_cidade VARCHAR(100),
    endereco_estado CHAR(2),
    FOREIGN KEY (id_paciente) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    INDEX idx_cpf (cpf)
);

-- 4. TABELA MEDICO
CREATE TABLE MEDICO (
    id_medico INT PRIMARY KEY,
    crm VARCHAR(20) NOT NULL UNIQUE,
    especialidade VARCHAR(50) NOT NULL,
    instituicao VARCHAR(100),
    telefone_consultorio VARCHAR(15),
    FOREIGN KEY (id_medico) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    INDEX idx_crm (crm)
);

-- 5. TABELA ACOMPANHANTE
CREATE TABLE ACOMPANHANTE (
    id_acompanhante INT PRIMARY KEY,
    id_paciente INT NOT NULL,
    parentesco VARCHAR(30) NOT NULL,
    pode_editar BOOLEAN DEFAULT FALSE,
    pode_gerenciar_lembretes BOOLEAN DEFAULT FALSE,
    data_vinculo DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_acompanhante) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente) ON DELETE CASCADE,
    INDEX idx_paciente (id_paciente)
);

-- 6. TABELA ALERGIA
CREATE TABLE ALERGIA (
    id_alergia INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    substancia VARCHAR(100) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    gravidade VARCHAR(20) NOT NULL,
    data_diagnostico DATE,
    observacoes TEXT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario_alergia (id_usuario)
);

-- 7. TABELA MEDICAMENTO
CREATE TABLE MEDICAMENTO (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_comercial VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    laboratorio VARCHAR(100),
    dosagem VARCHAR(50),
    forma_farmaceutica VARCHAR(50),
    bula_resumida TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nome_comercial (nome_comercial)
);

-- 8. TABELA RECEITA
CREATE TABLE RECEITA (
    id_receita INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT,
    data_prescricao DATE DEFAULT (CURRENT_DATE),
    data_validade DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Ativa',
    tipo_receita VARCHAR(30) DEFAULT 'Comum',
    observacoes TEXT,
    caminho_imagem VARCHAR(500),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente) ON DELETE CASCADE,
    FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico) ON DELETE SET NULL,
    INDEX idx_paciente_receita (id_paciente),
    INDEX idx_status (status)
);

-- 9. TABELA ITEM_RECEITA
CREATE TABLE ITEM_RECEITA (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    posologia VARCHAR(100) NOT NULL,
    duracao_dias INT NOT NULL,
    quantidade INT NOT NULL,
    frequencia_diaria INT DEFAULT 1,
    observacoes TEXT,
    FOREIGN KEY (id_receita) REFERENCES RECEITA(id_receita) ON DELETE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES MEDICAMENTO(id_medicamento),
    INDEX idx_receita_item (id_receita)
);

-- 10. TABELA LEMBRETE
CREATE TABLE LEMBRETE (
    id_lembrete INT PRIMARY KEY AUTO_INCREMENT,
    id_receita INT NOT NULL,
    id_item_receita INT,
    horario TIME NOT NULL,
    dias_semana VARCHAR(20) DEFAULT '1,2,3,4,5,6,7',
    ativo BOOLEAN DEFAULT TRUE,
    tipo_alerta VARCHAR(20) DEFAULT 'Notificacao',
    som_alerta VARCHAR(50),
    vibrar BOOLEAN DEFAULT TRUE,
    data_inicio DATE DEFAULT (CURRENT_DATE),
    data_fim DATE,
    FOREIGN KEY (id_receita) REFERENCES RECEITA(id_receita) ON DELETE CASCADE,
    FOREIGN KEY (id_item_receita) REFERENCES ITEM_RECEITA(id_item) ON DELETE CASCADE,
    INDEX idx_ativo (ativo),
    INDEX idx_horario (horario)
);

-- 11. TABELA DOCUMENTO
CREATE TABLE DOCUMENTO (
    id_documento INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    data_documento DATE NOT NULL,
    caminho_arquivo VARCHAR(500) NOT NULL,
    tamanho_mb FLOAT,
    formato VARCHAR(10),
    data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario_documento (id_usuario)
);

-- 12. TABELA HISTORICO_MEDICO
CREATE TABLE HISTORICO_MEDICO (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    data_ocorrencia DATE NOT NULL,
    data_registro DATE DEFAULT (CURRENT_DATE),
    gravidade VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Ativo',
    observacoes TEXT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario_historico (id_usuario)
);

-- 13. TABELA CONSULTA
CREATE TABLE CONSULTA (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_consulta DATE NOT NULL,
    hora_consulta TIME NOT NULL,
    tipo_consulta VARCHAR(30) DEFAULT 'Rotina',
    status VARCHAR(20) DEFAULT 'Agendada',
    motivo TEXT,
    local_consulta VARCHAR(200),
    data_agendamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente) ON DELETE CASCADE,
    FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico) ON DELETE CASCADE,
    INDEX idx_paciente_consulta (id_paciente),
    INDEX idx_data_consulta (data_consulta)
);

-- 14. TABELA LOG_ATIVIDADE
CREATE TABLE LOG_ATIVIDADE (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    tipo_acao VARCHAR(50) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    tabela_afetada VARCHAR(50),
    id_registro_afetado INT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE SET NULL,
    INDEX idx_data_hora (data_hora)
);

-- 15. TABELA CONFIGURACAO
CREATE TABLE CONFIGURACAO (
    id_config INT PRIMARY KEY AUTO_INCREMENT,
    chave VARCHAR(50) NOT NULL UNIQUE,
    valor TEXT,
    descricao VARCHAR(200),
    categoria VARCHAR(50),
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_chave (chave)
);

-- ============================================
-- INSERIR DADOS DE EXEMPLO
-- ============================================

-- INSERIR USUÁRIOS
INSERT INTO USUARIO (nome, email, senha_hash, data_nascimento, tipo_usuario, plano) VALUES
('João Silva', 'joao@email.com', '123', '1985-03-15', 'P', 'Premium_Paciente'),
('Maria Santos', 'maria@email.com', '123', '1990-07-22', 'P', 'Free'),
('Dra. Ana Costa', 'ana@medico.com', '123', '1975-04-18', 'M', 'Premium_Medico');

-- INSERIR PACIENTES
INSERT INTO PACIENTE (id_paciente, cpf, telefone, tipo_sanguineo) VALUES
(1, '123.456.789-00', '(11) 9999-9999', 'O+'),
(2, '987.654.321-00', '(11) 8888-8888', 'A+');

-- INSERIR MÉDICO
INSERT INTO MEDICO (id_medico, crm, especialidade) VALUES
(3, 'CRM-SP 123456', 'Cardiologia');

-- INSERIR MEDICAMENTOS
INSERT INTO MEDICAMENTO (nome_comercial, principio_ativo, dosagem) VALUES
('Losartana', 'Losartana', '50mg'),
('Metformina', 'Metformina', '850mg'),
('Amoxicilina', 'Amoxicilina', '500mg');

-- INSERIR ALERGIA
INSERT INTO ALERGIA (id_usuario, substancia, tipo, gravidade) VALUES
(1, 'Penicilina', 'Medicamento', 'Grave');

-- INSERIR RECEITA
INSERT INTO RECEITA (id_paciente, id_medico, data_validade, status) VALUES
(1, 3, '2024-06-01', 'Ativa');

-- INSERIR ITEM RECEITA
INSERT INTO ITEM_RECEITA (id_receita, id_medicamento, posologia, duracao_dias, quantidade) VALUES
(1, 1, '1 comprimido ao dia', 30, 30);

-- INSERIR LEMBRETE
INSERT INTO LEMBRETE (id_receita, id_item_receita, horario, dias_semana) VALUES
(1, 1, '08:00:00', '2,3,4,5,6');

-- ============================================
-- CONSULTAS DE TESTE
-- ============================================

SELECT '✅ BANCO CRIADO COM SUCESSO!' as Mensagem;
SELECT ' ' as ' ';
SELECT 'TABELAS CRIADAS:' as ' ';
SHOW TABLES;
SELECT ' ' as ' ';
SELECT 'TESTE - PACIENTES E SEUS DADOS:' as ' ';
SELECT u.nome, u.email, p.cpf, p.telefone FROM USUARIO u JOIN PACIENTE p ON u.id_usuario = p.id_paciente;
SELECT ' ' as ' ';
SELECT 'TESTE - MEDICAMENTOS CADASTRADOS:' as ' ';
SELECT nome_comercial, principio_ativo, dosagem FROM MEDICAMENTO;
SELECT ' ' as ' ';
SELECT 'TESTE - LEMBRETES ATIVOS:' as ' ';
SELECT l.horario, m.nome_comercial, ir.posologia FROM LEMBRETE l 
JOIN ITEM_RECEITA ir ON l.id_item_receita = ir.id_item 
JOIN MEDICAMENTO m ON ir.id_medicamento = m.id_medicamento 
WHERE l.ativo = TRUE;