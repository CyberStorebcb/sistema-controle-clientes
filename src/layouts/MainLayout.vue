<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated :class="headerClass">
      <q-toolbar>
        <q-btn flat dense round icon="menu" aria-label="Menu" @click="toggleLeftDrawer" />

        <q-toolbar-title class="text-weight-bold">
          <q-icon name="people" class="q-mr-sm" />
          Sistema de Controle de Clientes
        </q-toolbar-title>

        <div class="q-gutter-sm row items-center">
          <!-- Calendário melhorado -->
          <q-btn
            flat
            icon="event"
            :label="formatDateFull"
            class="calendar-btn"
            @click="showCalendar = true"
          >
            <q-tooltip>Ver calendário completo</q-tooltip>
          </q-btn>

          <q-separator vertical inset />

          <!-- Controles de navegação -->
          <q-btn
            flat
            icon="home"
            label="Home"
            @click="navigateToHome"
            :class="{ 'text-accent': route.path === '/' }"
          >
            <q-tooltip>Ir para página inicial</q-tooltip>
          </q-btn>

          <q-btn
            flat
            icon="people"
            label="Clientes"
            @click="navigateToClientes"
            :class="{ 'text-accent': route.path === '/clientes' }"
          >
            <q-tooltip>Gerenciar clientes</q-tooltip>
          </q-btn>

          <q-separator vertical inset />

          <!-- Toggle Dark/Light Mode -->
          <q-btn
            flat
            round
            :icon="$q.dark.isActive ? 'light_mode' : 'dark_mode'"
            @click="toggleDarkMode"
            class="dark-toggle"
          >
            <q-tooltip>
              {{ $q.dark.isActive ? 'Modo Claro' : 'Modo Escuro' }}
            </q-tooltip>
          </q-btn>

          <!-- Horário atual -->
          <div class="time-display text-center">
            <div class="text-caption">{{ currentTime }}</div>
            <div class="text-body2 text-weight-bold">{{ currentDate }}</div>
          </div>
        </div>
      </q-toolbar>
    </q-header>

    <!-- Dialog do Calendário -->
    <q-dialog v-model="showCalendar">
      <q-card style="min-width: 350px">
        <q-card-section>
          <div class="text-h6 text-center">
            <q-icon name="event" class="q-mr-sm" />
            Calendário
          </div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-date v-model="selectedDate" :options="dateOptions" today-btn class="full-width" />
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Fechar" color="primary" @click="showCalendar = false" />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered :class="drawerClass" :width="280">
      <q-list>
        <q-item-label header class="text-grey-8 text-weight-bold">
          <q-icon name="dashboard" class="q-mr-sm" />
          Menu Principal
        </q-item-label>

        <q-item clickable v-ripple @click="navigateToHome" class="q-mb-sm">
          <q-item-section avatar>
            <q-icon name="home" color="green" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Página Inicial</q-item-label>
            <q-item-label caption>Bem-vinda, Naty</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable v-ripple @click="navigateTo('clientes')" class="q-mb-sm">
          <q-item-section avatar>
            <q-icon name="people" color="primary" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Controle de Clientes</q-item-label>
            <q-item-label caption>Gerenciar clientes do sistema</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable v-ripple @click="navigateTo('estatisticas')" class="q-mb-sm">
          <q-item-section avatar>
            <q-icon name="analytics" color="green" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Estatísticas</q-item-label>
            <q-item-label caption>Relatórios e métricas</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable v-ripple @click="navigateTo('configuracoes')" class="q-mb-sm">
          <q-item-section avatar>
            <q-icon name="settings" color="orange" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Configurações</q-item-label>
            <q-item-label caption>Preferências do sistema</q-item-label>
          </q-item-section>
        </q-item>

        <q-separator class="q-my-md" />

        <q-item-label header class="text-grey-8 text-weight-bold">
          <q-icon name="info" class="q-mr-sm" />
          Informações
        </q-item-label>

        <q-item clickable v-ripple @click="showAbout">
          <q-item-section avatar>
            <q-icon name="help" color="blue" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Sobre</q-item-label>
            <q-item-label caption>Versão e informações</q-item-label>
          </q-item-section>
        </q-item>
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useQuasar } from 'quasar'
import { useRouter, useRoute } from 'vue-router'

const $q = useQuasar()
const router = useRouter()
const route = useRoute()

const leftDrawerOpen = ref(false)
const showCalendar = ref(false)
const selectedDate = ref(new Date().toISOString().split('T')[0])
const currentTime = ref('')

// Timer para atualizar o horário
let timeInterval = null

// Classes computadas para modo dark/light
const headerClass = computed(() => {
  return $q.dark.isActive ? 'bg-dark text-white' : 'bg-primary text-white'
})

const drawerClass = computed(() => {
  return $q.dark.isActive ? 'bg-dark text-white' : 'bg-grey-1'
})

// Data atual formatada (curta)
const currentDate = computed(() => {
  return new Date().toLocaleDateString('pt-BR', {
    weekday: 'short',
    day: '2-digit',
    month: '2-digit',
  })
})

// Data completa para o botão do calendário
const formatDateFull = computed(() => {
  return new Date().toLocaleDateString('pt-BR', {
    weekday: 'long',
    day: '2-digit',
    month: 'long',
    year: 'numeric',
  })
})

// Função para atualizar o horário
const updateTime = () => {
  const now = new Date()
  currentTime.value = now.toLocaleTimeString('pt-BR', {
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
  })
}

// Toggle do modo dark/light
const toggleDarkMode = () => {
  $q.dark.toggle()

  // Salvar preferência no localStorage
  localStorage.setItem('darkMode', $q.dark.isActive)

  $q.notify({
    type: 'positive',
    message: `Modo ${$q.dark.isActive ? 'escuro' : 'claro'} ativado`,
    position: 'top-right',
    timeout: 1500,
  })
}

function toggleLeftDrawer() {
  leftDrawerOpen.value = !leftDrawerOpen.value
}

// Opções para o calendário
const dateOptions = (date) => {
  // Permitir apenas datas futuras e atuais
  return date >= new Date().toISOString().split('T')[0]
}

// Navegação entre seções
function navigateTo(section) {
  switch (section) {
    case 'clientes':
      router.push('/clientes')
      break
    case 'estatisticas':
      $q.notify({
        type: 'info',
        message: 'Página de estatísticas em desenvolvimento',
        position: 'top',
      })
      break
    case 'configuracoes':
      $q.notify({
        type: 'info',
        message: 'Página de configurações em desenvolvimento',
        position: 'top',
      })
      break
  }
  // Fechar drawer em mobile
  if ($q.screen.lt.md) {
    leftDrawerOpen.value = false
  }
}

// Navegação para Home
function navigateToHome() {
  router.push('/')
}

// Navegação para Clientes
function navigateToClientes() {
  router.push('/clientes')
}

// Mostrar informações sobre o app
function showAbout() {
  $q.dialog({
    title: 'Sistema de Controle de Clientes',
    message: `
      <div class="text-center q-pa-md">
        <q-icon name="people" size="3rem" color="primary" class="q-mb-md" />
        <div class="text-h6 q-mb-sm">Sistema de Controle de Clientes</div>
        <div class="text-body2 text-grey-6 q-mb-md">
          Versão 1.0.0<br>
          Desenvolvido com Quasar Framework
        </div>
        <div class="text-caption text-grey-5">
          © 2025 - Sistema de Gerenciamento
        </div>
      </div>
    `,
    html: true,
    ok: {
      label: 'Fechar',
      color: 'primary',
      unelevated: true,
    },
  })
}

// Lifecycle hooks
onMounted(() => {
  // Inicializar horário
  updateTime()

  // Atualizar horário a cada segundo
  timeInterval = setInterval(updateTime, 1000)

  // Verificar preferência do modo dark no localStorage
  const darkMode = localStorage.getItem('darkMode')
  if (darkMode === 'true') {
    $q.dark.set(true)
  } else if (darkMode === 'false') {
    $q.dark.set(false)
  }
})

onUnmounted(() => {
  // Limpar timer
  if (timeInterval) {
    clearInterval(timeInterval)
  }
})
</script>

<style scoped>
.calendar-btn {
  transition: all 0.3s ease;
}

.calendar-btn:hover {
  transform: translateY(-2px);
}

.dark-toggle {
  transition: all 0.3s ease;
}

.dark-toggle:hover {
  transform: scale(1.1);
}

.time-display {
  min-width: 80px;
  opacity: 0.9;
}

@media (max-width: 768px) {
  .time-display {
    display: none;
  }
}
</style>
