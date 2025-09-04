<template>
  <q-page :class="pageClass">
    <div class="text-center">
      <!-- Foto de perfil ou ícone padrão -->
      <div class="q-mb-xl profile-section">
        <div class="profile-container" @click="mostrarDialogFoto">
          <q-avatar v-if="fotoPerfil" size="200px" class="profile-avatar cursor-pointer shadow-10">
            <img :src="fotoPerfil" alt="Foto de perfil" class="profile-image" />
            <div class="avatar-overlay">
              <q-icon name="edit" size="2.5rem" color="white" />
              <div class="overlay-text">Editar</div>
            </div>
          </q-avatar>

          <q-avatar
            v-else
            size="200px"
            :color="avatarColor"
            :text-color="avatarTextColor"
            class="profile-avatar cursor-pointer shadow-10"
          >
            <q-icon name="person" size="6rem" />
            <div class="avatar-overlay">
              <q-icon name="add_a_photo" size="2.5rem" color="white" />
              <div class="overlay-text">Adicionar Foto</div>
            </div>
          </q-avatar>
        </div>

        <p :class="subtitleTextClass">
          {{
            fotoPerfil
              ? 'Clique para alterar sua foto de perfil'
              : 'Clique para adicionar uma foto de perfil'
          }}
        </p>
      </div>

      <!-- Mensagem de boas-vindas melhorada -->
      <div class="welcome-container q-mb-xl">
        <h1 :class="welcomeTextClass">
          Bem-vinda,
          <span class="naty-name">Naty</span>
        </h1>
        <div class="subtitle-container">
          <p :class="subtitleClass">
            <q-icon name="business" class="q-mr-sm" />
            Sistema de Controle de Clientes
          </p>
          <div class="status-indicator q-mb-lg">
            <q-chip color="green" text-color="white" icon="check_circle" class="q-px-md">
              Sistema Online
            </q-chip>
          </div>
        </div>
      </div>

      <!-- Botões de ação melhorados -->
      <div class="action-buttons q-gutter-md q-mb-xl">
        <q-btn
          push
          size="lg"
          :color="$q.dark.isActive ? 'white' : 'primary'"
          :text-color="$q.dark.isActive ? 'primary' : 'white'"
          icon="people"
          label="Gerenciar Clientes"
          class="q-px-xl q-py-md action-btn"
          @click="navegarParaClientes"
        />

        <q-btn
          outline
          size="lg"
          :color="$q.dark.isActive ? 'white' : 'secondary'"
          :text-color="$q.dark.isActive ? 'white' : 'secondary'"
          icon="analytics"
          label="Ver Estatísticas"
          class="q-px-xl q-py-md action-btn"
          @click="mostrarEstatisticas"
        />
      </div>

      <!-- Cards informativos melhorados -->
      <div class="row justify-center q-mt-xl q-gutter-md">
        <div class="col-auto">
          <q-card flat :class="cardClass" style="min-width: 220px">
            <q-card-section class="text-center">
              <q-icon name="people_outline" size="2.5rem" class="q-mb-sm" color="blue-5" />
              <div :class="cardTextClass">{{ totalClientes }}</div>
              <div :class="cardSubtitleClass">Clientes Cadastrados</div>
            </q-card-section>
          </q-card>
        </div>

        <div class="col-auto">
          <q-card flat :class="cardClass" style="min-width: 220px">
            <q-card-section class="text-center">
              <q-icon name="check_circle" size="2.5rem" class="q-mb-sm" color="green-5" />
              <div :class="cardTextClass">{{ clientesConcluidos }}</div>
              <div :class="cardSubtitleClass">Concluídos</div>
            </q-card-section>
          </q-card>
        </div>

        <div class="col-auto">
          <q-card flat :class="cardClass" style="min-width: 220px">
            <q-card-section class="text-center">
              <q-icon name="schedule" size="2.5rem" class="q-mb-sm" color="orange-5" />
              <div :class="cardTextClass">{{ clientesPendentes }}</div>
              <div :class="cardSubtitleClass">Pendentes</div>
            </q-card-section>
          </q-card>
        </div>
      </div>

      <!-- Data atual -->
      <div class="q-mt-xl">
        <p :class="$q.dark.isActive ? 'text-white-7 text-body2' : 'text-grey-6 text-body2'">
          <q-icon name="today" class="q-mr-sm" />
          {{ dataAtual }}
        </p>
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

// Estados para foto de perfil
const fotoPerfil = ref(null)
const dialogFoto = ref(false)
const arquivoFoto = ref(null)
const previewFoto = ref(null)
const salvandoFoto = ref(false)

// Classes computadas para modo dark/light
const pageClass = computed(() => {
  return $q.dark.isActive
    ? 'flex flex-center bg-dark text-white'
    : 'flex flex-center bg-gradient-primary'
})

const welcomeTextClass = computed(() => {
  return $q.dark.isActive
    ? 'welcome-text text-white text-weight-light q-mb-md'
    : 'welcome-text text-grey-8 text-weight-light q-mb-md'
})

const subtitleClass = computed(() => {
  return $q.dark.isActive
    ? 'subtitle text-white text-h6 q-mb-lg'
    : 'subtitle text-grey-7 text-h6 q-mb-lg'
})

const subtitleTextClass = computed(() => {
  return $q.dark.isActive ? 'text-grey-4 q-mt-md text-body2' : 'text-grey-6 q-mt-md text-body2'
})

const avatarColor = computed(() => {
  return $q.dark.isActive ? 'grey-8' : 'white'
})

const avatarTextColor = computed(() => {
  return $q.dark.isActive ? 'white' : 'primary'
})

// Classes para os cards informativos
const cardClass = computed(() => {
  return $q.dark.isActive
    ? 'info-card bg-grey-8 text-white'
    : 'info-card bg-white text-grey-8 shadow-2'
})

const cardTextClass = computed(() => {
  return $q.dark.isActive
    ? 'text-h5 text-weight-bold text-white'
    : 'text-h5 text-weight-bold text-grey-8'
})

const cardSubtitleClass = computed(() => {
  return $q.dark.isActive ? 'text-subtitle2 text-grey-3' : 'text-subtitle2 text-grey-6'
})

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

// Carregar dados ao montar o componente
onMounted(() => {
  // Carregar foto de perfil do localStorage
  const fotoSalva = localStorage.getItem('fotoPerfil')
  if (fotoSalva) {
    fotoPerfil.value = fotoSalva
  }

  // Aqui você pode carregar dados reais do localStorage ou API
  totalClientes.value = 0
  clientesConcluidos.value = 0
  clientesPendentes.value = 0
})
</script>

<style scoped>
.bg-gradient-primary {
  background: linear-gradient(135deg, #ffffff 0%, #f5f5f5 100%);
  min-height: 100vh;
}

.welcome-text {
  font-size: 3.5rem;
  line-height: 1.2;
}

/* Sombras diferentes para cada modo */
.dark-mode .welcome-text {
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.light-mode .welcome-text {
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
}

.naty-name {
  background: linear-gradient(45deg, #ff6b35, #f7931e, #ffd700, #ff69b4, #9b59b6);
  background-size: 300% 300%;
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: bold;
  font-family: 'Pacifico', cursive;
  animation:
    natyAnimation 4s ease-in-out infinite,
    bounce 2s ease-in-out infinite;
  display: inline-block;
  transform: scale(1.15);
  position: relative;
}

@keyframes natyAnimation {
  0%,
  100% {
    background-position: 0% 50%;
    transform: scale(1.15) rotate(0deg);
  }
  25% {
    background-position: 100% 0%;
    transform: scale(1.18) rotate(1deg);
  }
  50% {
    background-position: 100% 100%;
    transform: scale(1.2) rotate(-1deg);
  }
  75% {
    background-position: 0% 100%;
    transform: scale(1.18) rotate(1deg);
  }
}

@keyframes bounce {
  0%,
  20%,
  50%,
  80%,
  100% {
    transform: translateY(0) scale(1.15);
  }
  40% {
    transform: translateY(-8px) scale(1.18);
  }
  60% {
    transform: translateY(-4px) scale(1.16);
  }
}

.profile-container {
  position: relative;
  display: inline-block;
}

.profile-avatar {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  border: 5px solid rgba(255, 255, 255, 0.4);
  backdrop-filter: blur(10px);
}

/* Estilos específicos para modo light */
.light-mode .profile-avatar {
  border: 5px solid rgba(25, 118, 210, 0.3);
}

.profile-avatar:hover {
  transform: scale(1.08) translateY(-5px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.light-mode .profile-avatar:hover {
  border-color: rgba(25, 118, 210, 0.6);
  box-shadow: 0 20px 40px rgba(25, 118, 210, 0.3);
}

.profile-image,
.preview-image {
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
  flex-direction: column;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: all 0.3s ease;
  backdrop-filter: blur(2px);
}

.profile-avatar:hover .avatar-overlay {
  opacity: 1;
}

.overlay-text {
  color: white;
  font-size: 0.9rem;
  font-weight: 600;
  margin-top: 0.5rem;
  text-align: center;
}

.preview-container {
  position: relative;
  display: inline-block;
}

.photo-dialog .q-card {
  border-radius: 20px;
  overflow: hidden;
}

.photo-dialog .preview-image {
  transition: all 0.3s ease;
}

.profile-container:hover .avatar-overlay {
  opacity: 1;
}

.subtitle {
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
}

.status-indicator {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%,
  100% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
}

.info-card {
  backdrop-filter: blur(15px);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 20px;
  transition: all 0.3s ease;
  min-height: 120px;
}

.info-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
}

/* Estilos específicos para modo light */
.light-mode .info-card {
  border: 2px solid rgba(200, 200, 200, 0.3);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.light-mode .info-card:hover {
  border-color: rgba(25, 118, 210, 0.4);
  box-shadow: 0 15px 35px rgba(25, 118, 210, 0.2);
}

.action-btn {
  border-radius: 30px;
  transition: all 0.3s ease;
  font-weight: 600;
  text-transform: none;
  letter-spacing: 0.5px;
}

.action-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
}

/* Dark Mode Styles */
.dark-mode {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  color: #e0e0e0;
}

.dark-mode .info-card {
  background: rgba(30, 30, 60, 0.7);
  border: 2px solid rgba(255, 255, 255, 0.1);
  color: #e0e0e0;
}

.dark-mode .info-card:hover {
  border-color: rgba(255, 255, 255, 0.3);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
}

.dark-mode .q-card {
  background: rgba(30, 30, 60, 0.8);
  color: #e0e0e0;
}

.dark-mode .welcome-text {
  color: #ffffff;
}

.dark-mode .subtitle {
  color: #b0b0b0;
}

/* Light Mode Styles */
.light-mode {
  background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
  color: #333;
}

.light-mode .info-card {
  background: rgba(255, 255, 255, 0.9);
  border: 2px solid rgba(255, 255, 255, 0.3);
  color: #333;
}

.light-mode .q-card {
  background: rgba(255, 255, 255, 0.95);
  color: #333;
}

@media (max-width: 768px) {
  .welcome-text {
    font-size: 2.5rem;
  }

  .naty-name {
    display: block;
    margin-top: 0.5rem;
  }

  .action-buttons {
    flex-direction: column;
  }

  .action-btn {
    width: 100%;
    margin-bottom: 10px;
  }
}
</style>
