<template>
  <q-page class="flex flex-center bg-gradient-primary">
    <div class="text-center">
      <!-- Foto de perfil ou ícone padrão -->
      <div class="q-mb-xl profile-section">
        <div class="profile-container" @click="mostrarDialogFoto">
          <q-avatar v-if="fotoPerfil" size="150px" class="profile-avatar cursor-pointer shadow-8">
            <img :src="fotoPerfil" alt="Foto de perfil" />
            <div class="avatar-overlay">
              <q-icon name="edit" size="2rem" color="white" />
            </div>
          </q-avatar>

          <q-avatar
            v-else
            size="150px"
            color="white"
            text-color="primary"
            class="profile-avatar cursor-pointer shadow-8"
          >
            <q-icon name="person" size="5rem" />
            <div class="avatar-overlay">
              <q-icon name="add_a_photo" size="2rem" color="white" />
            </div>
          </q-avatar>
        </div>

        <p class="text-white-7 q-mt-md text-body2">
          Clique para {{ fotoPerfil ? 'alterar' : 'adicionar' }} foto de perfil
        </p>
      </div>

      <!-- Mensagem de boas-vindas melhorada -->
      <div class="welcome-container q-mb-xl">
        <h1 class="welcome-text text-white text-weight-light q-mb-md">
          Bem-vinda,
          <span class="naty-name">Naty</span>
        </h1>
        <div class="subtitle-container">
          <p class="subtitle text-white text-h6 q-mb-lg">
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
          color="white"
          text-color="primary"
          icon="people"
          label="Gerenciar Clientes"
          class="q-px-xl q-py-md action-btn"
          @click="navegarParaClientes"
        />

        <q-btn
          outline
          size="lg"
          color="white"
          icon="analytics"
          label="Ver Estatísticas"
          class="q-px-xl q-py-md action-btn"
          @click="mostrarEstatisticas"
        />
      </div>

      <!-- Cards informativos melhorados -->
      <div class="row justify-center q-mt-xl q-gutter-md">
        <div class="col-auto">
          <q-card flat class="info-card bg-white-2 text-white" style="min-width: 220px">
            <q-card-section class="text-center">
              <q-icon name="people_outline" size="2.5rem" class="q-mb-sm" color="blue-3" />
              <div class="text-h5 text-weight-bold">{{ totalClientes }}</div>
              <div class="text-subtitle2">Clientes Cadastrados</div>
            </q-card-section>
          </q-card>
        </div>

        <div class="col-auto">
          <q-card flat class="info-card bg-white-2 text-white" style="min-width: 220px">
            <q-card-section class="text-center">
              <q-icon name="check_circle" size="2.5rem" class="q-mb-sm" color="green-4" />
              <div class="text-h5 text-weight-bold">{{ clientesConcluidos }}</div>
              <div class="text-subtitle2">Concluídos</div>
            </q-card-section>
          </q-card>
        </div>

        <div class="col-auto">
          <q-card flat class="info-card bg-white-2 text-white" style="min-width: 220px">
            <q-card-section class="text-center">
              <q-icon name="schedule" size="2.5rem" class="q-mb-sm" color="orange-4" />
              <div class="text-h5 text-weight-bold">{{ clientesPendentes }}</div>
              <div class="text-subtitle2">Pendentes</div>
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

    <!-- Dialog para upload de foto -->
    <q-dialog v-model="dialogFoto" persistent>
      <q-card style="min-width: 400px">
        <q-card-section>
          <div class="text-h6">Foto de Perfil</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <div class="text-center q-mb-md">
            <q-avatar size="120px" v-if="previewFoto">
              <img :src="previewFoto" alt="Preview" />
            </q-avatar>
            <q-avatar v-else size="120px" color="grey-3" text-color="grey-7">
              <q-icon name="person" size="3rem" />
            </q-avatar>
          </div>

          <q-file
            v-model="arquivoFoto"
            label="Selecionar foto"
            outlined
            accept="image/*"
            @update:model-value="onFileSelected"
            class="q-mb-md"
          >
            <template v-slot:prepend>
              <q-icon name="attach_file" />
            </template>
          </q-file>

          <div class="text-caption text-grey-6">Formatos aceitos: JPG, PNG, GIF (máx. 5MB)</div>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="grey" @click="cancelarFoto" />
          <q-btn flat label="Remover Foto" color="red" @click="removerFoto" v-if="fotoPerfil" />
          <q-btn
            unelevated
            label="Salvar"
            color="primary"
            @click="salvarFoto"
            :disable="!arquivoFoto"
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
    if (file.size > 5 * 1024 * 1024) {
      // 5MB
      $q.notify({
        type: 'negative',
        message: 'Arquivo muito grande. Máximo 5MB.',
      })
      arquivoFoto.value = null
      return
    }

    const reader = new FileReader()
    reader.onload = (e) => {
      previewFoto.value = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

const salvarFoto = () => {
  if (previewFoto.value) {
    fotoPerfil.value = previewFoto.value
    // Salvar no localStorage
    localStorage.setItem('fotoPerfil', previewFoto.value)

    $q.notify({
      type: 'positive',
      message: 'Foto de perfil atualizada com sucesso!',
    })
  }
  cancelarFoto()
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
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}

.welcome-text {
  font-size: 3.5rem;
  line-height: 1.2;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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

.profile-container {
  position: relative;
  display: inline-block;
}

.profile-avatar {
  transition: all 0.3s ease;
  border: 4px solid rgba(255, 255, 255, 0.3);
}

.profile-avatar:hover {
  transform: scale(1.05);
  border-color: rgba(255, 255, 255, 0.8);
}

.avatar-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
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
}

.info-card:hover {
  transform: translateY(-5px);
  border-color: rgba(255, 255, 255, 0.6);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
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
