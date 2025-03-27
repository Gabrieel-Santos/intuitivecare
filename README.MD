# Testes de Nivelamento – IntuitiveCare

## Índice

- [Teste 1 – Web Scraping](#teste-1--web-scraping)
- [Teste 2 – Transformação de Dados](#teste-2--transformação-de-dados)
- [Teste 3 – Banco de Dados](#teste-3--banco-de-dados)
- [Teste 4 – API](#teste-4--api)

---

## Estrutura do Repositório

- `teste-01/` → Web Scraping e compactação de anexos (ANS)
- `teste-02/` → Transformação de dados do PDF para CSV
- `teste-03/` → Banco de Dados (MySQL/PostgreSQL)
- `teste-04/` → API com Python e Vue.js

---

## Testes

## Teste 1 – Web Scraping

O script acessa a página da ANS, analisa o HTML e identifica os links que contenham "anexo i" ou "anexo ii" com final `.pdf`. A partir disso, ele realiza o download dos arquivos e os compacta em um único `.zip`.

### O que o script faz:

- Acessa a página oficial da ANS com `requests`
- Analisa o HTML usando `BeautifulSoup`
- Procura por links com texto relacionado a "anexo i" e "anexo ii" e que terminem com `.pdf`
- Trata URLs relativas, tornando-as completas
- Baixa os PDFs diretamente da web
- Cria a pasta `arquivos/` caso não exista
- Compacta os arquivos no formato `.zip` usando `ZipFile.writestr`, sem salvar os PDFs no disco
- Exibe no terminal a quantidade de anexos baixados e o caminho final do `.zip`

### Como executar

1. Instale as dependências necessárias:

```bash
pip install requests beautifulsoup4
```

2. Dentro da pasta `teste-01`, execute o script com:

```bash
python scraper.py
```

## O arquivo `anexos.zip` será criado na pasta `arquivos/`.

---

## Teste 2 – Transformação de Dados

O script lê o Anexo I em PDF, extrai a tabela de procedimentos e gera um CSV com os dados tratados. Em seguida, o CSV é compactado em um arquivo `.zip`.

### O que o script faz:

- Abre o PDF do Anexo I e percorre todas as páginas com `pdfplumber`
- Extrai as tabelas visuais detectadas no documento usando `extract_tables`
- Substitui automaticamente as siglas "OD" e "AMB" por descrições completas usando a função `substituir(c)`
- Organiza os dados extraídos em uma lista de listas
- Salva o conteúdo em um arquivo `.csv` com `csv.writer`
- Compacta o `.csv` em um `.zip` com `zipfile.ZipFile`
- Exibe no terminal a quantidade total de linhas extraídas e o caminho final do `.zip`

### Como executar

1. Instale a dependência necessária:

```bash
pip install pdfplumber
```

2. Dentro da pasta `teste-02`, execute o script com:

```bash
python transformador.py
```

## O arquivo `Teste_Gabriel_Santos_Trindade.zip` será criado na pasta `arquivos/`.

---

## Teste 3 – Banco de Dados

Foram utilizadas bases de dados da ANS em formato `.csv`, referentes às despesas trimestrais de operadoras de saúde e aos dados cadastrais das operadoras. Com base nesses dados, foi realizada a estruturação do banco em PostgreSQL, importação dos dados e execução de duas consultas analíticas.

### O que os scripts fazem:

- `create_tables.sql`:  
  Cria a estrutura do banco de dados com duas tabelas:

  - `despesas_trimestrais`, contendo os dados trimestrais de despesas por operadora
  - `relatorio_cadop`, contendo os dados cadastrais das operadoras com base no CSV original

- `import_data.sql`:  
  Realiza a importação dos arquivos `.csv` para as tabelas criadas, usando `\copy` com `DELIMITER ';'` e `ENCODING 'UTF8'`.  
  Todos os arquivos trimestrais de 2023 e 2024 são carregados em `despesas_trimestrais`, enquanto o `Relatorio_cadop.csv` é carregado em `relatorio_cadop`.

- `consultas_analiticas.sql`:  
  Contém duas queries SQL analíticas que somam as despesas médicas da categoria `"EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"`, ordenando as 10 operadoras com maiores valores:
  - A primeira considera apenas o 4º trimestre de 2024 (`data >= '2024-10-01'`)
  - A segunda considera todo o ano de 2024 (`data >= '2024-01-01'`)
    Ambas utilizam `REPLACE(..., ',', '.')::NUMERIC` para tratar corretamente os valores numéricos com vírgula.

### Como executar

1. Instale as dependências necessárias:

```bash
sudo apt install postgresql postgresql-contrib
```

2. Crie o banco de dados no PostgreSQL:

```sql
CREATE DATABASE intuitivecare;
```

3. Rode os arquivos SQL:

```bash
sudo -u postgres psql -d intuitivecare -f create_tables.sql
sudo -u postgres psql -d intuitivecare -f import_data.sql
sudo -u postgres psql -d intuitivecare -f consultas_analiticas.sql
```

### Resultado da análise

Consulta referente ao último trimestre (4T2024), filtrando por "SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR":

```
 reg_ans | total_despesa
---------+---------------------
    5711 | 23516487489.97
    6246 | 15698180049.08
  326305 | 15400708697.86
  359017 |  7209059967.55
  368253 |  5902558128.55
  346659 |  5542848031.98
  339679 |  5192114791.45
  302147 |  4434353000.89
  343889 |  3915933905.41
     701 |  3548029528.89
```

## Teste 4 – API

Foi desenvolvida uma aplicação completa com **frontend em Vue.js** e **backend em FastAPI**, que realiza buscas textuais no cadastro de operadoras (baseado no `Relatorio_cadop.csv` do teste 3.2).

### Backend

- O backend está localizado em `teste-04/backend/` e utiliza **FastAPI** com **pandas** para leitura e filtragem dos dados.
- O arquivo `main.py` carrega o CSV na inicialização usando `pd.read_csv()` com `sep=";"`, `encoding="utf-8"` e `dtype=str`, garantindo compatibilidade com os dados e evitando erros de parsing.
- A API define uma rota `/buscar` via `@app.get`, com o parâmetro `q` usando validação do `fastapi.Query(min_length=2)`.
- A busca textual é feita com `str.contains()` (case-insensitive), comparando o termo com os campos `Razao_Social` e `Nome_Fantasia`.
- Os **registros mais relevantes** são considerados como os **primeiros resultados encontrados na base**, com correspondência parcial no nome ou razão social — o critério de ordenação neste caso é a ordem natural do dataset, retornando até 10 registros via `.head(10)`.
- O retorno é formatado como uma lista de dicionários com `.to_dict(orient="records")`, compatível com JSON.
- A aplicação habilita o CORS com `CORSMiddleware` para permitir acesso entre o frontend (Vercel) e o backend (Render).
- Também foi criada uma **coleção Postman** com uma requisição `GET` de exemplo (`/buscar?q=amil`) para validar a API visualmente.

### Frontend

- O frontend está localizado em `teste-04/frontend/` e foi desenvolvido com **Vue 3 + Vite**.
- O componente principal realiza a busca conforme o usuário digita (`@input="buscar"`) e atualiza os resultados em tempo real.
- A biblioteca **Axios** é usada para comunicação HTTP com a API.
- A interface foi construída com **Tailwind CSS**, utilizando classes como `rounded-xl`, `shadow-md`, `divide-y` e `transition`, garantindo estilo moderno, leve e responsivo.
- Os resultados são exibidos dinamicamente com `v-for`, com controle de carregamento (`v-if="carregando"`) e mensagem de erro amigável quando não há correspondência.
- O componente adapta-se bem a diferentes tamanhos de tela, seguindo o padrão **mobile first**.

### Como executar localmente

Para testar a aplicação localmente:

1. No backend (`teste-04/backend`), instale as dependências:

```bash
pip install fastapi uvicorn pandas
```

2. Inicie a API:

```bash
uvicorn main:app --reload
```

A API estará disponível em `http://127.0.0.1:8000`.

3. No frontend (`teste-04/frontend`), instale as dependências e rode o servidor de desenvolvimento:

```bash
npm install
npm run dev
```

> **Importante:** Para testes locais, altere a URL da API no componente Vue (arquivo `OperadoraBusca.vue`) de:

```js
https://fastapi-intuitivecare.onrender.com/buscar
```

para:

```js
http://127.0.0.1:8000/buscar
```

### Deploy

A aplicação está publicada online, utilizando:

- **Frontend (Vercel)**  
  [https://intuitivecare-gabriel.vercel.app](https://intuitivecare-gabriel.vercel.app)

- **API (Render)**  
  [https://fastapi-intuitivecare.onrender.com](https://fastapi-intuitivecare.onrender.com)
