-- Tabela para as despesas trimestrais
CREATE TABLE IF NOT EXISTS despesas_trimestrais (
    data DATE,
    reg_ans INTEGER,
    cd_conta_contabil BIGINT,
    descricao TEXT,
    vl_saldo_inicial TEXT, -- vírgula como separador decimal no CSV
    vl_saldo_final TEXT   -- vírgula como separador decimal no CSV

);


-- Tabela para os dados cadastrais (Relatório Cadop)
CREATE TABLE relatorio_cadop (
    registro_ans INTEGER,
    cnpj VARCHAR(18),
    razao_social TEXT,
    nome_fantasia TEXT,
    modalidade TEXT,
    logradouro TEXT,
    numero TEXT,
    complemento TEXT,
    bairro TEXT,
    cidade TEXT,
    uf CHAR(2),
    cep VARCHAR(9),
    ddd VARCHAR(3),
    telefone TEXT,
    fax TEXT,
    endereco_eletronico TEXT,
    representante TEXT,
    cargo_representante TEXT,
    regiao_de_comercializacao TEXT,
    data_registro_ans DATE
);
