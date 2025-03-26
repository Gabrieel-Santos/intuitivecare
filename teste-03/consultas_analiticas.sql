-- 3.5.1 – Top 10 operadoras com maiores despesas no último trimestre (4T2024)
SELECT 
    reg_ans,
    descricao,
    SUM(REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC) AS total_despesa
FROM despesas_trimestrais
WHERE TRIM(descricao) ILIKE '%SINISTROS CONHECIDOS OU AVISADOS%'
  AND TRIM(descricao) ILIKE '%MEDICO HOSPITALAR%'
  AND data >= '2024-10-01'
GROUP BY reg_ans, descricao
ORDER BY total_despesa DESC
LIMIT 10;

-- 3.5.2 – Top 10 operadoras com maiores despesas nessa categoria no último ano (2024)
SELECT 
    reg_ans,
    descricao,
    SUM(REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC) AS total_despesa
FROM despesas_trimestrais
WHERE TRIM(descricao) ILIKE '%SINISTROS CONHECIDOS OU AVISADOS%'
  AND TRIM(descricao) ILIKE '%MEDICO HOSPITALAR%'
  AND data >= '2024-01-01'
GROUP BY reg_ans, descricao
ORDER BY total_despesa DESC
LIMIT 10;
