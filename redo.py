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

    #Esqueleto da redo: implementar lógica de processamento de logs aqui

    cur.close()
    conn.close()

if _name_ == '_main_':
    redo()
