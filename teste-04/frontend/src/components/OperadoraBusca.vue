<template>
    <div class="min-h-screen bg-gray-100 p-6">
      <div class="max-w-2xl mx-auto bg-white rounded-2xl shadow-md p-6">
        <h1 class="text-2xl font-bold mb-4 text-center">Buscar Operadora</h1>
        <input
          v-model="busca"
          @input="buscar"
          type="text"
          placeholder="Digite o nome da operadora..."
          class="w-full p-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 mb-4"
        />
  
        <div v-if="resultados.length > 0">
          <h2 class="text-lg font-semibold mb-2">Resultados:</h2>
          <ul class="divide-y divide-gray-200">
            <li
              v-for="(item, index) in resultados"
              :key="index"
              class="py-2 px-3 hover:bg-gray-50 rounded-md transition"
            >
              <p><strong>Razão Social:</strong> {{ item.Razao_Social }}</p>
              <p><strong>Nome Fantasia:</strong> {{ item.Nome_Fantasia }}</p>
              <p><strong>UF:</strong> {{ item.UF }}</p>
              <p><strong>Registro ANS:</strong> {{ item.Registro_ANS }}</p>
            </li>
          </ul>
        </div>
  
        <p v-else-if="busca.length >= 2 && !carregando" class="text-gray-500">
          Nenhum resultado encontrado.
        </p>
  
        <p v-if="carregando" class="text-blue-500">Buscando...</p>
      </div>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  
  export default {
    data() {
      return {
        busca: "",
        resultados: [],
        carregando: false,
      };
    },
    methods: {
      async buscar() {
        if (this.busca.length < 2) {
          this.resultados = [];
          return;
        }
  
        this.carregando = true;
  
        try {
          const response = await axios.get(
            `https://fastapi-intuitivecare.onrender.com/buscar?q=${this.busca}`
          );
          this.resultados = response.data;
        } catch (error) {
          console.error("Erro na busca:", error);
          this.resultados = [];
        }
  
        this.carregando = false;
      },
    },
  };
  </script>
  