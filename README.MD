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

Dentro da pasta `teste-01`, execute o script com:

```bash
python main.py
```

## O arquivo `anexos.zip` será criado na pasta `arquivos/`.

---

## Teste 2 – Transformação de Dados

_(Em desenvolvimento)_

## Teste 3 – Banco de Dados

_(Em desenvolvimento)_

## Teste 4 – API

_(Em desenvolvimento)_
