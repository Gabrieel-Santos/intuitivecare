import pdfplumber
import csv
import os
import zipfile

# Caminhos dos arquivos
pdf_path = "arquivos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
csv_path = "arquivos/rol_procedimentos.csv"
zip_path = "arquivos/Teste_Gabriel_Santos_Trindade.zip"

# Substitui siglas nas células
def substituir(c):
    if not c:
        return ""
    return c.replace("OD", "Consulta Odontológica").replace("AMB", "Consulta Médica Ambulatorial")

# Extrai e trata as tabelas do PDF (ignora linhas vazias e substitui siglas)
rows = []
with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        for table in page.extract_tables():
            rows.extend([[substituir(c) for c in row] for row in table if row])

# Salva o CSV
with open(csv_path, "w", newline="", encoding="utf-8") as f:
    csv.writer(f).writerows(rows)

# Compacta o CSV em um .zip
with zipfile.ZipFile(zip_path, "w") as zipf:
    zipf.write(csv_path, arcname="rol_procedimentos.csv")

# Confirmação
print(f"{len(rows)} linhas extraídas e CSV compactado em '{zip_path}'")
