# Testes de Nivelamento - IntuitiveCare

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

_(Em desenvolvimento)_

## Teste 4 – API

_(Em desenvolvimento)_
