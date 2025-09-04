<template>
  <q-page class="flex flex-center bg-gradient-primary">
    <div class="text-center">
      <!-- Ícone principal -->
      <div class="q-mb-xl">
        <q-icon name="people" size="8rem" color="white" class="drop-shadow" />
      </div>

      <!-- Mensagem de boas-vindas -->
      <div class="welcome-container q-mb-xl">
        <h1 class="welcome-text text-white text-weight-light q-mb-md">
          Bem-vinda,
          <span class="naty-name">Naty</span>
        </h1>
        <p class="subtitle text-white-8 text-h6 q-mb-lg">Sistema de Controle de Clientes</p>
      </div>

      <!-- Botões de ação -->
      <div class="action-buttons q-gutter-md">
        <q-btn
          push
          size="lg"
          color="white"
          text-color="primary"
          icon="add_circle"
          label="Gerenciar Clientes"
          class="q-px-xl q-py-md"
          @click="navegarParaClientes"
        />

        <q-btn
          flat
          size="lg"
          color="white"
          icon="analytics"
          label="Ver Estatísticas"
          class="q-px-xl q-py-md"
          @click="mostrarEstatisticas"
        />
      </div>

      <!-- Cards informativos -->
      <div class="row justify-center q-mt-xl q-gutter-md">
        <div class="col-auto">
          <q-card flat class="info-card bg-white-3 text-white" style="min-width: 200px">
            <q-card-section class="text-center">
              <q-icon name="people_outline" size="2rem" class="q-mb-sm" />
              <div class="text-h6">{{ totalClientes }}</div>
              <div class="text-caption">Clientes Cadastrados</div>
            </q-card-section>
          </q-card>
        </div>

        <div class="col-auto">
          <q-card flat class="info-card bg-white-3 text-white" style="min-width: 200px">
            <q-card-section class="text-center">
              <q-icon name="check_circle" size="2rem" class="q-mb-sm" color="green" />
              <div class="text-h6">{{ clientesConcluidos }}</div>
              <div class="text-caption">Concluídos</div>
            </q-card-section>
          </q-card>
        </div>

        <div class="col-auto">
          <q-card flat class="info-card bg-white-3 text-white" style="min-width: 200px">
            <q-card-section class="text-center">
              <q-icon name="schedule" size="2rem" class="q-mb-sm" color="orange" />
              <div class="text-h6">{{ clientesPendentes }}</div>
              <div class="text-caption">Pendentes</div>
            </q-card-section>
          </q-card>
        </div>
      </div>

      <!-- Data atual -->
      <div class="q-mt-xl">
        <p class="text-white-7 text-body2">
          <q-icon name="today" class="q-mr-sm" />
          {{ dataAtual }}
        </p>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useQuasar } from 'quasar'

const router = useRouter()
const $q = useQuasar()

// Estados reativos para estatísticas
const totalClientes = ref(0)
const clientesConcluidos = ref(0)
const clientesPendentes = ref(0)

// Data atual formatada
const dataAtual = computed(() => {
  return new Date().toLocaleDateString('pt-BR', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
})

// Navegação
const navegarParaClientes = () => {
  router.push('/clientes')
}

const mostrarEstatisticas = () => {
  $q.notify({
    type: 'info',
    message: 'Funcionalidade de estatísticas em desenvolvimento',
    position: 'top',
  })
}

// Simular carregamento de dados
onMounted(() => {
  // Aqui você pode carregar dados reais do localStorage ou API
  totalClientes.value = 0
  clientesConcluidos.value = 0
  clientesPendentes.value = 0
})
</script>

<style scoped>
.bg-gradient-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}

.welcome-text {
  font-size: 3.5rem;
  line-height: 1.2;
}

.naty-name {
  background: linear-gradient(45deg, #ffd700, #ffa500, #ff69b4);
  background-size: 200% 200%;
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: bold;
  font-family: 'Pacifico', cursive;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
  animation: gradientShift 3s ease-in-out infinite alternate;
  display: inline-block;
  transform: scale(1.1);
}

@keyframes gradientShift {
  0% {
    background-position: 0% 50%;
  }
  100% {
    background-position: 100% 50%;
  }
}

.drop-shadow {
  filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
}

.info-card {
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 15px;
}

.action-buttons .q-btn {
  border-radius: 25px;
  transition: all 0.3s ease;
}

.action-buttons .q-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}

.subtitle {
  opacity: 0.9;
}

@media (max-width: 768px) {
  .welcome-text {
    font-size: 2.5rem;
  }

  .naty-name {
    display: block;
    margin-top: 0.5rem;
  }
}
</style>
