import os
import requests
from bs4 import BeautifulSoup
from zipfile import ZipFile

# URL
url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
pasta_destino = "arquivos"
zip_path = os.path.join(pasta_destino, "anexos.zip")

# Cria a pasta se não existir
os.makedirs(pasta_destino, exist_ok=True)

# Faz a requisição da página
response = requests.get(url)
response.raise_for_status()
soup = BeautifulSoup(response.text, "html.parser")

# Procura os links dos anexos I e II
anexos = {}
for link in soup.find_all("a", href=True):
    texto = link.get_text(strip=True).lower()
    if ("anexo i" in texto or "anexo ii" in texto) and link["href"].endswith(".pdf"):
        href = link["href"]
        if not href.startswith("http"):
            href = "https://www.gov.br" + href
        nome_arquivo = os.path.basename(href)
        anexos[nome_arquivo] = href

# Baixa os PDFs e adiciona ao arquivo ZIP
with ZipFile(zip_path, "w") as zipf:
    for nome_arquivo, link_pdf in anexos.items():
        print(f"Baixando: {nome_arquivo}")
        r = requests.get(link_pdf)
        r.raise_for_status()
        zipf.writestr(nome_arquivo, r.content)

print(f"{len(anexos)} anexos baixados e compactados em '{zip_path}'.")
