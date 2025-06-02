import psycopg2
from dotenv import load_dotenv
import os

load_dotenv() ## carrega as variáveis de ambiente do arquivo .env

def conectar():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT")
    )
    
def redo():
    conn = conectar()
    cur = conn.cursor()

    cur.execute("SELECT * FROM log_operacoes WHERE status = 'COMMIT' ORDER BY commit_id, id")
    logs = cur.fetchall()

    print("Aplicando REDO nas transações com COMMIT:\n")
    for log in logs:
        _, commit_id, operacao, id_cliente, nome, saldo, _ = log
        print(f"{commit_id} | {operacao} | ID: {id_cliente} | Nome: {nome} | Saldo: {saldo}")

        if operacao == 'INSERT':
            cur.execute("INSERT INTO clientes_em_memoria (id, nome, saldo) VALUES (%s, %s, %s) ON CONFLICT (id) DO NOTHING",
                        (id_cliente, nome, saldo))
        elif operacao == 'UPDATE':
            cur.execute("UPDATE clientes_em_memoria SET nome = %s, saldo = %s WHERE id = %s",
                        (nome, saldo, id_cliente))
    conn.commit()

    print("\nEstado final da tabela clientes_em_memoria:")
    cur.execute("SELECT * FROM clientes_em_memoria ORDER BY id")
    for row in cur.fetchall():
        print(f"ID: {row[0]} | Nome: {row[1]} | Saldo: {row[2]}")

    cur.close()
    conn.close()

if _name_ == '_main_':
    redo()
