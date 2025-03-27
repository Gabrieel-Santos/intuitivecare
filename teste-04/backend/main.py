from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd

app = FastAPI()

# Libera o CORS para acesso pelo frontend (Vue)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Carrega o CSV uma única vez ao iniciar a aplicação
df = pd.read_csv("Relatorio_cadop.csv", sep=";", encoding="utf-8", dtype=str).fillna("")

@app.get("/buscar")
def buscar_operadora(q: str = Query(..., min_length=2)):
    resultado = df[df["Razao_Social"].str.contains(q, case=False) | df["Nome_Fantasia"].str.contains(q, case=False)]
    return resultado.head(10).to_dict(orient="records")

@app.get("/")
def read_root():
    return {"status": "API online"}