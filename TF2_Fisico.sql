/* --------              Trabalho Final Tema 2          ------------ --
--                                                                   --
--                    SCRIPT DE CRIAÇÃO (DDL)                      --
--                                                                   --
-- Data Criacao ..........: 04/12/2018                               --
-- Autor(es) .............: Victor Rodrigues e Youssef Muhamad       --
-- Banco de Dados ........: MySQL                                    --
-- Base de Dados(nome) ...: TF2                                      --
--                                                                   --
-- Data Ultima Alteracao ..: 05/12/2018                              --
--                                                                   --
-- PROJETO => 23 tabelas                                             --
--                                                                   --
-- ----------------------------------------------------------------- */



CREATE DATABASE IF NOT EXISTS TF2;

USE TF2;

CREATE TABLE MEDICAMENTO (
    idMedicamento VARCHAR(20) NOT NULL,
    nomeMedicamento VARCHAR(50) NOT NULL,
    dosagem VARCHAR(10) NOT NULL,

	CONSTRAINT MEDICAMENTO_PK PRIMARY KEY(idMedicamento)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE INSUMO (
    idInsumo VARCHAR(20) NOT NULL,
    nomeInsumo VARCHAR(50) NOT NULL,
    descInsumo VARCHAR(100) NOT NULL,

	CONSTRAINT INSUMO_PK PRIMARY KEY(idInsumo)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE FUNCIONARIO (
    cpfFuncionario VARCHAR(11) NOT NULL,
    nomeFuncionario VARCHAR(50) NOT NULL,
    sexo ENUM('M', 'F'),

	CONSTRAINT FUNCIONARIO_PK PRIMARY KEY(cpfFuncionario)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE FARMACEUTICA (
    crf VARCHAR(10),
    cpfFuncionario VARCHAR(11),

	CONSTRAINT FARMACEUTICA_PK PRIMARY KEY(crf),
	CONSTRAINT FARMACEUTICA_FUNCIONARIO_FK FOREIGN KEY(cpfFuncionario) REFERENCES FUNCIONARIO(cpfFuncionario)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE BALCONISTA (
    idBalconista VARCHAR(20) NOT NULL,
    cpfFuncionario VARCHAR(11) NOT NULL,

	CONSTRAINT BALCONISTA_PK PRIMARY KEY(idBalconista),
	CONSTRAINT BALCONISTA_FUNCIONARIO_FK FOREIGN KEY (cpfFuncionario) REFERENCES FUNCIONARIO(cpfFuncionario)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE ENFERMEIRA (
    cofen VARCHAR(7) NOT NULL,
    cpfFuncionario VARCHAR(11) NOT NULL,

	CONSTRAINT ENFERMEIRA_PK PRIMARY KEY(cofen),
	CONSTRAINT ENFERMEIRA_FUNCIONARIO_FK FOREIGN KEY (cpfFuncionario) REFERENCES FUNCIONARIO(cpfFuncionario)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;


CREATE TABLE ESTADO (
    idEstado VARCHAR(20),
    nomeEstado VARCHAR(50),
    siglaEstado CHAR(2),

	CONSTRAINT ESTADO_PK PRIMARY KEY(idEstado)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;


CREATE TABLE ENDERECO (
    idEndereco VARCHAR(20),
    cep VARCHAR(8),
    numero INTEGER,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    logradouro VARCHAR(100),
    idEstado VARCHAR(20),

	CONSTRAINT ENDERECO_PK PRIMARY KEY(idEndereco),
	CONSTRAINT ENDERECO_ESTADO_FK FOREIGN KEY (idEstado) REFERENCES ESTADO(idEstado)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE PACIENTE (
    cpfPaciente VARCHAR(11) NOT NULL,
    cartaoSus VARCHAR(15) NOT NULL,
    nomePaciente VARCHAR(50) NOT NULL,
    dtNascimento DATE NOT NULL,
    sexo ENUM('M', 'F'),
    idEndereco VARCHAR(20),
    rg VARCHAR(15),

	CONSTRAINT PACIENTE_PK PRIMARY KEY(cpfPaciente),
	CONSTRAINT PACIENTE_ENDERECO_FK FOREIGN KEY (idEndereco) REFERENCES ENDERECO(idEndereco)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE RECEITA (
    idReceita VARCHAR(20) NOT NULL,
    dataEmissao DATE NOT NULL,
    crm VARCHAR(7) NOT NULL,
    cpfPaciente VARCHAR(11) NOT NULL,

	CONSTRAINT RECEITA_PK PRIMARY KEY(idReceita),
	CONSTRAINT RECEITA_PACIENTE_FK FOREIGN KEY (cpfPaciente) REFERENCES PACIENTE(cpfPaciente)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE SIMPLES (
    idReceitaSimples VARCHAR(20) NOT NULL,
    idReceita VARCHAR(20) NOT NULL,

	CONSTRAINT SIMPLES_PK PRIMARY KEY(idReceitaSimples),
	CONSTRAINT SIMPLES_RECEITA_FK FOREIGN KEY(idReceita) REFERENCES RECEITA(idReceita)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE ESPECIAL (
    numReceitaEspecial VARCHAR(20),
    idReceita VARCHAR(20),
    tipoListagem ENUM('A1', 'A2', 'A3', 'B1', 'B2', 'C1', 'C2', 'C3', 'C4', 'C5'),

	CONSTRAINT ESPECIAL_PK PRIMARY KEY(numReceitaEspecial),
	CONSTRAINT ESPECIAL_RECEITA_FK FOREIGN KEY(idReceita) REFERENCES RECEITA(idReceita)

)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;


CREATE TABLE PRESCRICAO (
    idPrescricao VARCHAR(20) NOT NULL,
    qtdMedicamento INT NOT NULL,
    posologia VARCHAR(20) NOT NULL,
    idMedicamento VARCHAR(20) NOT NULL,

	CONSTRAINT PRESCRICAO_PK PRIMARY KEY(idPrescricao),
	CONSTRAINT PRESCRICAO_MEDICAMENTO_FK FOREIGN KEY(idMedicamento) REFERENCES MEDICAMENTO(idMedicamento)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE ESTOQUE (
    idEstoque VARCHAR(20) NOT NULL,
	CONSTRAINT ESTOQUE_PK PRIMARY KEY(idEstoque)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE EXTERNO (
	idEstoqueExterno VARCHAR(20) NOT NULL,
    qtdMedicamento INTEGER NOT NULL,
    idEstoque VARCHAR(20) NOT NULL,
    idMedicamento VARCHAR(20) NOT NULL,

	CONSTRAINT EXTERNO_PK PRIMARY KEY(idEstoqueExterno),
	CONSTRAINT EXTERNO_ESTOQUE_FK FOREIGN KEY(idEstoque) REFERENCES ESTOQUE(idEstoque),
	CONSTRAINT EXTERNO_MEDICAMENTO_FK FOREIGN KEY(idMedicamento) REFERENCES MEDICAMENTO(idMedicamento)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE INTERNO (
	idEstoqueInterno VARCHAR(20) NOT NULL,
    qtdInsumo INTEGER,
    idEstoque VARCHAR(20),
    idInsumo VARCHAR(20),

	CONSTRAINT INTERNO_PK PRIMARY KEY(idEstoqueInterno),
	CONSTRAINT INTERNO_ESTOQUE_FK FOREIGN KEY(idEstoque) REFERENCES ESTOQUE(idEstoque),
	CONSTRAINT INTERNO_INSUMO_FK FOREIGN KEY(idInsumo) REFERENCES INSUMO(idInsumo)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE CONSULTA (
    idConsulta VARCHAR(20),
    dtConsulta DATE,
    cpfPaciente VARCHAR(11),
    cofenEnfermeira VARCHAR(7),

	CONSTRAINT CONSULTA_PK PRIMARY KEY(idConsulta),
	CONSTRAINT CONSULTA_PACIENTE_FK FOREIGN KEY(cpfPaciente) REFERENCES PACIENTE(cpfPaciente),
	CONSTRAINT CONSULTA_ENFERMEIRA_FK FOREIGN KEY(cofenEnfermeira) REFERENCES ENFERMEIRA(cofen)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE PEDIDO (
    idPedido VARCHAR(20),
    qtdMedicamento INTEGER,
    qtdInsumo INTEGER,
    dataEmissao DATE,
    idMedicamento VARCHAR(20),
    idInsumo VARCHAR(20),

	CONSTRAINT PEDIDO_PK PRIMARY KEY(idPedido),
	CONSTRAINT PEDIDO_MEDICAMENTO_FK FOREIGN KEY(idMedicamento) REFERENCES MEDICAMENTO(idMedicamento),
	CONSTRAINT PEDIDO_INSUMO_FK FOREIGN KEY(idInsumo) REFERENCES INSUMO(idInsumo)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE FORNECEDOR (
    idFornecedor VARCHAR(20),
    nomeFornecedor VARCHAR(50),

	CONSTRAINT FORNECEDOR_PK PRIMARY KEY(idFornecedor)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE ATENDIMENTO (
    idAtendimento VARCHAR(20),
    dtAtendimento DATE,
    idBalconista VARCHAR(20),
    cpfPaciente VARCHAR(11),

	CONSTRAINT ATENDIMENTO_PK PRIMARY KEY(idAtendimento),
	CONSTRAINT ATENDIMENTO_BALCONISTA_FK FOREIGN KEY(idBalconista) REFERENCES BALCONISTA(idBalconista),
	CONSTRAINT ATENDIMENTO_PACIENTE_FK FOREIGN KEY(cpfPaciente) REFERENCES PACIENTE(cpfPaciente)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;



CREATE TABLE pega_ATENDIMENTO_MEDICAMENTO (
    idAtendimento VARCHAR(20),
    idMedicamento VARCHAR(20),

	CONSTRAINT pega_ATENDIMENTO_FK FOREIGN KEY(idAtendimento) REFERENCES  ATENDIMENTO(idAtendimento),
	CONSTRAINT pega_MEDICAMENTO_FK FOREIGN KEY(idMedicamento) REFERENCES  MEDICAMENTO(idMedicamento)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE pega_ATENDIMENTO_INSUMO (
    idAtendimento VARCHAR(20),
    idInsumo VARCHAR(20),

	CONSTRAINT pega_ATENDIMENTO2_FK FOREIGN KEY(idAtendimento) REFERENCES  ATENDIMENTO(idAtendimento),
	CONSTRAINT pega_INSUMO_FK FOREIGN KEY(idInsumo) REFERENCES  INSUMO(idInsumo)

)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE pega_CONSULTA_INSUMO (
    idConsulta VARCHAR(20),
    idInsumo VARCHAR(20),

	CONSTRAINT pega_CONSULTA_FK FOREIGN KEY(idConsulta) REFERENCES CONSULTA(idConsulta),
	CONSTRAINT pega_INSUMO2_FK FOREIGN KEY(idInsumo) REFERENCES  INSUMO(idInsumo)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;