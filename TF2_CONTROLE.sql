/* --------              Trabalho Final Tema 2          ------------ --
--                                                                   --
--                    SCRIPT DE CONTROLE (DDL)                       --
--                                                                   --
-- Data Criacao ..........: 05/12/2018                               --
-- Autor(es) .............: Victor Rodrigues e Youssef Muhamad       --
-- Banco de Dados ........: MySQL                                    --
-- Base de Dados(nome) ...: TF2                                      --
--                                                                   --
-- Data Ultima Alteracao ..: 05/12/2018                              --
--                                                                   --
-- PROJETO => CRIAÇÃO DE USUÁRIO COM PRIVILÉGIOS                     --
--                                                                   --
-- ----------------------------------------------------------------- */

CREATE USER admin2
  IDENTIFIED BY 'senha';
  GRANT ALL PRIVILEGES ON TF2.* TO admin2;