# LogRedoBDII

## Créditos
Este projeto foi desenvolvido como parte da disciplina **Banco de Dados II** ministrada pelo Prof. Guilherme Dal Bianco na **Universidade Federal da Fronteira Sul (UFFS)** pela dupla composta por **Felipe Soldatelli Motta e Paula Frison Padilha**.

## Descrição
Este projeto implementa uma tabela de log que utiliza um mecanismo REDO para recuperação de dados em um Sistema de Gerenciamento de Banco de Dados (SGBD). O objetivo é simular e estudar o funcionamento de técnicas de recuperação de transações em bancos de dados.

## Motivação
O projeto foi inspirado no repositório [db-log-redo](https://github.com/Dutraz/db-log-redo), que serviu como base para a estruturação desta implementação.

## Funcionalidades
- Implementação de uma tabela de log para registro de operações.
- Simulação do mecanismo REDO para recuperação de transações.
- Estudo do impacto de operações de recuperação em bancos de dados.

## Como Usar

### Passo 1: Clone este repositório
```bash
git clone https://github.com/seu-usuario/LogRedoBDII.git
```

### Passo 2: Instale as dependências do `redo.py`
Certifique-se de ter o Python instalado. Em seguida, instale as dependências necessárias executando:
```bash
pip install psycopg2
```

### Passo 3: Configure o banco de dados
1. Execute o script SQL para criar a tabela de log e configurar o banco de dados:
   ```bash
   psql -U seu_usuario -d seu_banco -f script.sql
   ```

### Passo 4: Simule uma falha no banco de dados
Para simular uma falha no banco de dados, derrube o processo do PostgreSQL:
```bash
sudo kill -9 $(pgrep postgres)
```

### Passo 5: Execute o mecanismo REDO
Após a falha, execute o script `redo.py` para recuperar os dados perdidos:
```bash
python redo.py
```

O script irá ler os registros da tabela de log e aplicar as operações necessárias para restaurar os dados.

## Licença
Este projeto está licenciado sob a [MIT License](LICENSE).
