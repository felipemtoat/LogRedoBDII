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

-- trigger rpa registrar na tabela de log sempre que ocorrer transação na tabela clientes_em_memoria
CREATE OR REPLACE FUNCTION log_trigger_func() RETURNS trigger AS $$
BEGIN
  IF (TG_OP = 'INSERT') THEN
    INSERT INTO log_operacoes (commit_id, operacao, id_cliente, nome, saldo, status)
    VALUES ('TRIGGER', 'INSERT', NEW.id, NEW.nome, NEW.saldo, 'COMMIT');
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO log_operacoes (commit_id, operacao, id_cliente, nome, saldo, status)
    VALUES ('TRIGGER', 'UPDATE', NEW.id, NEW.nome, NEW.saldo, 'COMMIT');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_clientes
AFTER INSERT OR UPDATE ON clientes_em_memoria
FOR EACH ROW EXECUTE FUNCTION log_trigger_func();

-- teste de transação
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 1', 100.00);
UPDATE clientes_em_memoria SET saldo = 150.00 WHERE id = 1;
COMMIT;
