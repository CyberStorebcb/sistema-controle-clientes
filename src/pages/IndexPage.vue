<template>
  <q-page :class="pageClass">
    <!-- Header Section com informações principais -->
    <div class="main-container">
      <!-- Seção de Perfil e Boas-vindas -->
      <div class="header-section q-pa-lg">
        <div class="row items-center justify-between">
          <!-- Perfil e Boas-vindas -->
          <div class="col-12 col-md-6 profile-welcome-section">
            <div class="profile-container q-mb-md" @click="mostrarDialogFoto">
              <q-avatar v-if="fotoPerfil" size="120px" class="profile-avatar cursor-pointer shadow-10">
                <img :src="fotoPerfil" alt="Foto de perfil" class="profile-image" />
                <div class="avatar-overlay">
                  <q-icon name="edit" size="1.5rem" color="white" />
                </div>
              </q-avatar>

              <q-avatar
                v-else
                size="120px"
                :color="avatarColor"
                :text-color="avatarTextColor"
                class="profile-avatar cursor-pointer shadow-10"
              >
                <q-icon name="person" size="3rem" />
                <div class="avatar-overlay">
                  <q-icon name="add_a_photo" size="1.5rem" color="white" />
                </div>
              </q-avatar>
            </div>

            <div class="welcome-text-container">
              <h1 :class="welcomeTextClass">
                Bem-vinda, <span class="naty-name">Naty</span>
              </h1>
              <p :class="subtitleClass">
                <q-icon name="business" class="q-mr-sm" />
                Sistema de Controle de Clientes
              </p>
            </div>
          </div>

          <!-- Status e Informações do Sistema -->
          <div class="col-12 col-md-6 system-info-section">
            <div class="system-status-card">
              <div class="status-header">
                <q-chip color="green" text-color="white" icon="check_circle" class="status-chip">
                  Sistema Online
                </q-chip>
                <div class="time-info">
                  <p :class="timeTextClass">
                    <q-icon name="schedule" class="q-mr-xs" />
                    {{ horaAtual }}
                  </p>
                  <p :class="dateTextClass">
                    <q-icon name="today" class="q-mr-xs" />
                    {{ dataAtual }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Seção de Estatísticas Principais -->
      <div class="stats-section q-pa-lg">
        <div class="section-title q-mb-lg">
          <h3 :class="sectionTitleClass">
            <q-icon name="analytics" class="q-mr-sm" />
            Resumo do Sistema
          </h3>
        </div>

        <div class="row q-gutter-lg justify-center">
          <div class="col-12 col-sm-6 col-md-3">
            <q-card flat :class="statsCardClass" class="stat-card">
              <q-card-section class="text-center">
                <div class="stat-icon-container q-mb-sm">
                  <q-icon name="people_outline" size="2.5rem" class="stat-icon" />
                </div>
                <div :class="statNumberClass">{{ totalClientes }}</div>
                <div :class="statLabelClass">Total de Clientes</div>
                <q-linear-progress
                  :value="totalClientes / 100"
                  color="blue-5"
                  class="q-mt-sm"
                  size="4px"
                  rounded
                />
              </q-card-section>
            </q-card>
          </div>

          <div class="col-12 col-sm-6 col-md-3">
            <q-card flat :class="statsCardClass" class="stat-card">
              <q-card-section class="text-center">
                <div class="stat-icon-container q-mb-sm">
                  <q-icon name="check_circle" size="2.5rem" class="stat-icon green" />
                </div>
                <div :class="statNumberClass">{{ clientesConcluidos }}</div>
                <div :class="statLabelClass">Concluídos</div>
                <q-linear-progress
                  :value="clientesConcluidos / Math.max(totalClientes, 1)"
                  color="green-5"
                  class="q-mt-sm"
                  size="4px"
                  rounded
                />
              </q-card-section>
            </q-card>
          </div>

          <div class="col-12 col-sm-6 col-md-3">
            <q-card flat :class="statsCardClass" class="stat-card">
              <q-card-section class="text-center">
                <div class="stat-icon-container q-mb-sm">
                  <q-icon name="schedule" size="2.5rem" class="stat-icon orange" />
                </div>
                <div :class="statNumberClass">{{ clientesPendentes }}</div>
                <div :class="statLabelClass">Pendentes</div>
                <q-linear-progress
                  :value="clientesPendentes / Math.max(totalClientes, 1)"
                  color="orange-5"
                  class="q-mt-sm"
                  size="4px"
                  rounded
                />
              </q-card-section>
            </q-card>
          </div>

          <div class="col-12 col-sm-6 col-md-3">
            <q-card flat :class="statsCardClass" class="stat-card">
              <q-card-section class="text-center">
                <div class="stat-icon-container q-mb-sm">
                  <q-icon name="trending_up" size="2.5rem" class="stat-icon purple" />
                </div>
                <div :class="statNumberClass">{{ percentualConclusao }}%</div>
                <div :class="statLabelClass">Taxa de Conclusão</div>
                <q-linear-progress
                  :value="percentualConclusao / 100"
                  color="purple-5"
                  class="q-mt-sm"
                  size="4px"
                  rounded
                />
              </q-card-section>
            </q-card>
          </div>
        </div>
      </div>

      <!-- Seção de Ações Principais -->
      <div class="actions-section q-pa-lg">
        <div class="section-title q-mb-lg">
          <h3 :class="sectionTitleClass">
            <q-icon name="dashboard" class="q-mr-sm" />
            Ações Rápidas
          </h3>
        </div>

        <div class="row q-gutter-md justify-center">
          <div class="col-auto">
            <q-btn
              push
              size="xl"
              color="primary"
              text-color="white"
              icon="people"
              label="Gerenciar Clientes"
              class="action-btn primary-action"
              @click="navegarParaClientes"
            />
          </div>

          <div class="col-auto">
            <q-btn
              push
              size="xl"
              color="secondary"
              text-color="white"
              icon="analytics"
              label="Ver Estatísticas"
              class="action-btn secondary-action"
              @click="mostrarEstatisticas"
            />
          </div>

          <div class="col-auto">
            <q-btn
              push
              size="xl"
              color="positive"
              text-color="white"
              icon="add_circle"
              label="Novo Cliente"
              class="action-btn positive-action"
              @click="novoCliente"
            />
          </div>
        </div>
      </div>

      <!-- Seção de Atividade Recente -->
      <div class="activity-section q-pa-lg">
        <div class="section-title q-mb-lg">
          <h3 :class="sectionTitleClass">
            <q-icon name="history" class="q-mr-sm" />
            Atividade Recente
          </h3>
        </div>

        <q-card flat :class="activityCardClass" class="activity-card">
          <q-card-section>
            <div v-if="atividadesRecentes.length === 0" class="text-center q-py-xl">
              <q-icon name="inbox" size="4rem" :color="$q.dark.isActive ? 'grey-6' : 'grey-4'" />
              <p :class="emptyStateClass" class="q-mt-md">
                Nenhuma atividade recente encontrada
              </p>
              <p :class="emptySubtitleClass">
                As ações realizadas no sistema aparecerão aqui
              </p>
            </div>

            <q-list v-else separator>
              <q-item v-for="(atividade, index) in atividadesRecentes" :key="index" class="activity-item">
                <q-item-section avatar>
                  <q-avatar :color="atividade.cor" text-color="white" size="40px">
                    <q-icon :name="atividade.icone" />
                  </q-avatar>
                </q-item-section>

                <q-item-section>
                  <q-item-label :class="activityTitleClass">{{ atividade.titulo }}</q-item-label>
                  <q-item-label caption :class="activitySubtitleClass">
                    {{ atividade.descricao }}
                  </q-item-label>
                </q-item-section>

                <q-item-section side>
                  <q-item-label caption :class="activityTimeClass">
                    {{ atividade.tempo }}
                  </q-item-label>
                </q-item-section>
              </q-item>
            </q-list>
          </q-card-section>
        </q-card>
      </div>
    </div>

    <!-- Dialog para upload de foto -->
    <q-dialog v-model="dialogFoto" persistent class="photo-dialog">
      <q-card style="min-width: 500px; max-width: 600px">
        <q-card-section class="bg-primary text-white">
          <div class="text-h6 text-center">
            <q-icon name="photo_camera" size="1.5rem" class="q-mr-sm" />
            Foto de Perfil
          </div>
        </q-card-section>

        <q-card-section class="q-pt-lg">
          <div class="text-center q-mb-lg">
            <div class="preview-container">
              <q-avatar size="180px" v-if="previewFoto" class="shadow-8">
                <img :src="previewFoto" alt="Preview" class="preview-image" />
              </q-avatar>
              <q-avatar v-else size="180px" color="grey-3" text-color="grey-7" class="shadow-4">
                <q-icon name="person" size="4rem" />
              </q-avatar>
            </div>
          </div>

          <q-file
            v-model="arquivoFoto"
            label="Selecionar nova foto"
            outlined
            accept="image/*"
            @update:model-value="onFileSelected"
            class="q-mb-md"
            :color="previewFoto ? 'positive' : 'primary'"
          >
            <template v-slot:prepend>
              <q-icon name="attach_file" />
            </template>
            <template v-slot:append>
              <q-icon name="photo_library" />
            </template>
          </q-file>

          <div class="text-center">
            <q-chip color="blue-1" text-color="blue-8" icon="info" class="q-px-md">
              Formatos aceitos: JPG, PNG, GIF (máx. 5MB)
            </q-chip>
          </div>
        </q-card-section>

        <q-card-actions align="right" class="q-pa-lg">
          <q-btn
            flat
            label="Cancelar"
            color="grey-7"
            @click="cancelarFoto"
            icon="close"
            class="q-mr-sm"
          />
          <q-btn
            flat
            label="Remover Foto"
            color="red"
            @click="removerFoto"
            v-if="fotoPerfil"
            icon="delete"
            class="q-mr-sm"
          />
          <q-btn
            unelevated
            label="Salvar Foto"
            color="primary"
            @click="salvarFoto"
            :disable="!arquivoFoto"
            icon="save"
            :loading="salvandoFoto"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
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
const atividadesRecentes = ref([])

// Estados para foto de perfil
const fotoPerfil = ref(null)
const dialogFoto = ref(false)
const arquivoFoto = ref(null)
const previewFoto = ref(null)
const salvandoFoto = ref(false)

// Computed para porcentagem de conclusão
const percentualConclusao = computed(() => {
  if (totalClientes.value === 0) return 0
  return Math.round((clientesConcluidos.value / totalClientes.value) * 100)
})

// Classes computadas para modo dark/light
const pageClass = computed(() => {
  return $q.dark.isActive
    ? 'dashboard-page bg-dark'
    : 'dashboard-page bg-light'
})

const welcomeTextClass = computed(() => {
  return $q.dark.isActive
    ? 'welcome-text text-white'
    : 'welcome-text text-grey-8'
})

const subtitleClass = computed(() => {
  return $q.dark.isActive
    ? 'subtitle-text text-grey-3'
    : 'subtitle-text text-grey-6'
})

const sectionTitleClass = computed(() => {
  return $q.dark.isActive
    ? 'section-title text-white'
    : 'section-title text-grey-8'
})

const avatarColor = computed(() => {
  return $q.dark.isActive ? 'grey-8' : 'white'
})

const avatarTextColor = computed(() => {
  return $q.dark.isActive ? 'white' : 'primary'
})

// Classes para os cards de estatísticas
const statsCardClass = computed(() => {
  return $q.dark.isActive
    ? 'stats-card bg-grey-8 text-white'
    : 'stats-card bg-white text-grey-8'
})

const activityCardClass = computed(() => {
  return $q.dark.isActive
    ? 'activity-card bg-grey-8 text-white'
    : 'activity-card bg-white text-grey-8'
})

const statNumberClass = computed(() => {
  return $q.dark.isActive
    ? 'stat-number text-white'
    : 'stat-number text-grey-8'
})

const statLabelClass = computed(() => {
  return $q.dark.isActive ? 'stat-label text-grey-3' : 'stat-label text-grey-6'
})

const emptyStateClass = computed(() => {
  return $q.dark.isActive ? 'text-grey-4 text-h6' : 'text-grey-6 text-h6'
})

const emptySubtitleClass = computed(() => {
  return $q.dark.isActive ? 'text-grey-5 text-body2' : 'text-grey-5 text-body2'
})

const activityTitleClass = computed(() => {
  return $q.dark.isActive ? 'text-white' : 'text-grey-8'
})

const activitySubtitleClass = computed(() => {
  return $q.dark.isActive ? 'text-grey-3' : 'text-grey-6'
})

const activityTimeClass = computed(() => {
  return $q.dark.isActive ? 'text-grey-4' : 'text-grey-5'
})

// Data e hora atuais formatadas
const dataAtual = computed(() => {
  return new Date().toLocaleDateString('pt-BR', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
})

const horaAtual = computed(() => {
  return new Date().toLocaleTimeString('pt-BR', {
    hour: '2-digit',
    minute: '2-digit',
  })
})

// Navegação e ações
const navegarParaClientes = () => {
  router.push('/clientes')
}

const mostrarEstatisticas = () => {
  $q.notify({
    type: 'info',
    message: 'Funcionalidade de estatísticas em desenvolvimento',
    icon: 'analytics',
    position: 'top',
  })
}

const novoCliente = () => {
  router.push('/clientes')
  $q.notify({
    type: 'positive',
    message: 'Redirecionando para adicionar novo cliente',
    icon: 'person_add',
    position: 'top',
  })
}

// Funções para foto de perfil
const mostrarDialogFoto = () => {
  dialogFoto.value = true
  previewFoto.value = fotoPerfil.value
}

const onFileSelected = (file) => {
  if (file) {
    // Verificar tamanho do arquivo
    if (file.size > 5 * 1024 * 1024) {
      $q.notify({
        type: 'negative',
        message: 'Arquivo muito grande. Máximo 5MB.',
        position: 'top',
      })
      arquivoFoto.value = null
      return
    }

    // Verificar tipo de arquivo
    if (!file.type.startsWith('image/')) {
      $q.notify({
        type: 'negative',
        message: 'Por favor, selecione apenas arquivos de imagem.',
        position: 'top',
      })
      arquivoFoto.value = null
      return
    }

    const reader = new FileReader()
    reader.onload = (e) => {
      // Criar uma imagem para redimensionar se necessário
      const img = new Image()
      img.onload = () => {
        const canvas = document.createElement('canvas')
        const ctx = canvas.getContext('2d')

        // Redimensionar para máximo 400x400 mantendo aspecto
        let { width, height } = img
        const maxSize = 400

        if (width > maxSize || height > maxSize) {
          if (width > height) {
            height = (height * maxSize) / width
            width = maxSize
          } else {
            width = (width * maxSize) / height
            height = maxSize
          }
        }

        canvas.width = width
        canvas.height = height

        ctx.drawImage(img, 0, 0, width, height)

        // Converter para base64 com qualidade otimizada
        const resizedImage = canvas.toDataURL('image/jpeg', 0.8)
        previewFoto.value = resizedImage
      }
      img.src = e.target.result
    }
    reader.onerror = () => {
      $q.notify({
        type: 'negative',
        message: 'Erro ao ler o arquivo de imagem.',
        position: 'top',
      })
    }
    reader.readAsDataURL(file)
  }
}

const salvarFoto = async () => {
  if (!previewFoto.value) {
    $q.notify({
      type: 'negative',
      message: 'Nenhuma foto selecionada',
      position: 'top',
    })
    return
  }

  salvandoFoto.value = true

  try {
    // Simular um pequeno delay para mostrar o loading
    await new Promise((resolve) => setTimeout(resolve, 500))

    fotoPerfil.value = previewFoto.value

    // Salvar no localStorage com tratamento de erro
    try {
      localStorage.setItem('fotoPerfil', previewFoto.value)
    } catch (error) {
      console.error('Erro ao salvar no localStorage:', error)
      $q.notify({
        type: 'negative',
        message: 'Erro ao salvar foto. Tente uma imagem menor.',
        position: 'top',
      })
      return
    }

    $q.notify({
      type: 'positive',
      message: 'Foto de perfil atualizada com sucesso!',
      position: 'top',
      icon: 'check_circle',
    })

    cancelarFoto()
  } catch (error) {
    console.error('Erro ao salvar foto:', error)
    $q.notify({
      type: 'negative',
      message: 'Erro inesperado ao salvar foto',
      position: 'top',
    })
  } finally {
    salvandoFoto.value = false
  }
}

const removerFoto = () => {
  fotoPerfil.value = null
  localStorage.removeItem('fotoPerfil')
  $q.notify({
    type: 'positive',
    message: 'Foto de perfil removida',
  })
  cancelarFoto()
}

const cancelarFoto = () => {
  dialogFoto.value = false
  arquivoFoto.value = null
  previewFoto.value = null
}

// Carregar dados simulados
const carregarDadosSimulados = () => {
  // Dados de exemplo para demonstração
  totalClientes.value = 25
  clientesConcluidos.value = 18
  clientesPendentes.value = 7

  // Atividades recentes de exemplo
  atividadesRecentes.value = [
    {
      titulo: 'Novo cliente cadastrado',
      descricao: 'Maria Silva foi adicionada ao sistema',
      tempo: 'há 2 horas',
      icone: 'person_add',
      cor: 'green'
    },
    {
      titulo: 'Status atualizado',
      descricao: 'Cliente João Santos marcado como concluído',
      tempo: 'há 4 horas',
      icone: 'check_circle',
      cor: 'blue'
    },
    {
      titulo: 'Sistema atualizado',
      descricao: 'Nova versão do sistema instalada',
      tempo: 'ontem',
      icone: 'system_update',
      cor: 'purple'
    }
  ]
}

// Carregar dados ao montar o componente
onMounted(() => {
  // Carregar foto de perfil do localStorage
  const fotoSalva = localStorage.getItem('fotoPerfil')
  if (fotoSalva) {
    fotoPerfil.value = fotoSalva
  }

  // Carregar dados simulados ou do localStorage
  const clientesSalvos = localStorage.getItem('clientes')
  if (clientesSalvos) {
    try {
      const clientes = JSON.parse(clientesSalvos)
      totalClientes.value = clientes.length
      clientesConcluidos.value = clientes.filter(c => c.status === 'concluido').length
      clientesPendentes.value = clientes.filter(c => c.status === 'pendente').length
    } catch (error) {
      console.error('Erro ao carregar clientes:', error)
      carregarDadosSimulados()
    }
  } else {
    carregarDadosSimulados()
  }
})
</script>

<style scoped>
/* Background Styles */
.dashboard-page {
  min-height: 100vh;
  padding: 0;
}

.bg-light {
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.bg-dark {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
}

/* Main Container */
.main-container {
  width: 100%;
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
}

/* Header Section */
.header-section {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
  border-radius: 20px;
  margin-bottom: 30px;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.bg-dark .header-section {
  background: rgba(30, 30, 60, 0.4);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.profile-welcome-section {
  display: flex;
  align-items: center;
  gap: 20px;
}

.profile-container {
  position: relative;
  display: inline-block;
}

.profile-avatar {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  border: 4px solid rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
}

.profile-avatar:hover {
  transform: scale(1.05) translateY(-3px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
}

.profile-image {
  object-fit: cover;
  width: 100%;
  height: 100%;
  border-radius: 50%;
}

.avatar-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.4));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: all 0.3s ease;
  backdrop-filter: blur(2px);
}

.profile-avatar:hover .avatar-overlay {
  opacity: 1;
}

/* Welcome Text */
.welcome-text {
  font-size: 2.5rem;
  line-height: 1.2;
  font-weight: 300;
  margin: 0;
}

.naty-name {
  background: linear-gradient(45deg, #ff6b35, #f7931e, #ffd700, #ff69b4, #9b59b6);
  background-size: 300% 300%;
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: bold;
  font-family: 'Pacifico', cursive;
  animation: natyAnimation 4s ease-in-out infinite;
  display: inline-block;
  transform: scale(1.1);
}

@keyframes natyAnimation {
  0%, 100% {
    background-position: 0% 50%;
    transform: scale(1.1) rotate(0deg);
  }
  25% {
    background-position: 100% 0%;
    transform: scale(1.13) rotate(1deg);
  }
  50% {
    background-position: 100% 100%;
    transform: scale(1.15) rotate(-1deg);
  }
  75% {
    background-position: 0% 100%;
    transform: scale(1.13) rotate(1deg);
  }
}

.subtitle-text {
  font-size: 1.1rem;
  margin: 10px 0;
  display: flex;
  align-items: center;
}

/* System Info Section */
.system-info-section {
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

.system-status-card {
  text-align: right;
}

.status-header {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 10px;
}

.status-chip {
  animation: pulse 2s infinite;
  font-weight: 600;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

.time-info p {
  margin: 5px 0;
}

/* Section Titles */
.section-title {
  font-size: 1.8rem;
  font-weight: 600;
  margin: 0;
  display: flex;
  align-items: center;
}

/* Statistics Section */
.stats-section {
  margin-bottom: 30px;
}

.stat-card {
  transition: all 0.3s ease;
  border-radius: 16px;
  overflow: hidden;
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.bg-dark .stat-card {
  background: rgba(30, 30, 60, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.bg-light .stat-card {
  background: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.stat-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
}

.stat-icon-container {
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-icon {
  color: #1976d2;
}

.stat-icon.green {
  color: #4caf50;
}

.stat-icon.orange {
  color: #ff9800;
}

.stat-icon.purple {
  color: #9c27b0;
}

.stat-number {
  font-size: 2.5rem;
  font-weight: bold;
  margin: 10px 0;
}

.stat-label {
  font-size: 0.9rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Actions Section */
.actions-section {
  margin-bottom: 30px;
}

.action-btn {
  border-radius: 25px;
  transition: all 0.3s ease;
  font-weight: 600;
  text-transform: none;
  letter-spacing: 0.3px;
  padding: 15px 30px;
  min-width: 200px;
}

.action-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
}

.primary-action:hover {
  box-shadow: 0 12px 30px rgba(25, 118, 210, 0.4);
}

.secondary-action:hover {
  box-shadow: 0 12px 30px rgba(156, 39, 176, 0.4);
}

.positive-action:hover {
  box-shadow: 0 12px 30px rgba(76, 175, 80, 0.4);
}

/* Activity Section */
.activity-section {
  margin-bottom: 30px;
}

.activity-card {
  border-radius: 16px;
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.bg-dark .activity-card {
  background: rgba(30, 30, 60, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.bg-light .activity-card {
  background: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.activity-item {
  padding: 15px;
  transition: all 0.2s ease;
}

.activity-item:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateX(5px);
}

.bg-dark .activity-item:hover {
  background: rgba(255, 255, 255, 0.05);
}

.bg-light .activity-item:hover {
  background: rgba(0, 0, 0, 0.03);
}

/* Preview Container for Photo Dialog */
.preview-container {
  position: relative;
  display: inline-block;
}

.preview-image {
  object-fit: cover;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.photo-dialog .q-card {
  border-radius: 20px;
  overflow: hidden;
}

/* Responsive Design */
@media (max-width: 1024px) {
  .profile-welcome-section {
    flex-direction: column;
    text-align: center;
    gap: 15px;
  }

  .system-info-section {
    justify-content: center;
    margin-top: 20px;
  }

  .system-status-card {
    text-align: center;
  }

  .status-header {
    align-items: center;
  }
}

@media (max-width: 768px) {
  .main-container {
    padding: 15px;
  }

  .welcome-text {
    font-size: 2rem;
  }

  .naty-name {
    display: block;
    margin-top: 10px;
  }

  .section-title {
    font-size: 1.5rem;
  }

  .stat-number {
    font-size: 2rem;
  }

  .action-btn {
    min-width: 100%;
    margin-bottom: 10px;
  }

  .profile-avatar {
    width: 100px !important;
    height: 100px !important;
  }
}

@media (max-width: 480px) {
  .welcome-text {
    font-size: 1.8rem;
  }

  .header-section,
  .stats-section,
  .actions-section,
  .activity-section {
    padding: 15px;
  }

  .stat-card {
    margin-bottom: 15px;
  }
}
</style>
