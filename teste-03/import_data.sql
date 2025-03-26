-- Importação dos arquivos trimestrais
\copy despesas_trimestrais FROM 'arquivos/1T2023.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/2t2023.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/3T2023.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/4T2023.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/1T2024.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/2T2024.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/3T2024.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
\copy despesas_trimestrais FROM 'arquivos/4T2024.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';

-- Importação do Relatório Cadop
\copy relatorio_cadop FROM 'arquivos/Relatorio_cadop.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';
