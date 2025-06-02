CREATE UNLOGGED TABLE clientes_em_memoria (
  id SERIAL PRIMARY KEY,
  nome TEXT,
  saldo NUMERIC
);

CREATE TABLE log_operacoes (
  id SERIAL PRIMARY KEY,
  commit_id TEXT,
  operacao TEXT,
  id_cliente INT,
  nome TEXT,
  saldo NUMERIC,
  status TEXT  -- pode ser COMMIT ou PENDING
);

-- fazer trigger para inserir na tabela de log aqui!!

-- teste de transação
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 1', 100.00);
UPDATE clientes_em_memoria SET saldo = 150.00 WHERE id = 1;
COMMIT;
