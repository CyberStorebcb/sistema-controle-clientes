<template>
  <q-page class="q-pa-md">
    <div class="row justify-center q-gutter-md">
      <!-- Formulário para adicionar cliente -->
      <div class="col-12 col-md-5">
        <q-card class="q-pa-md">
          <q-card-section>
            <h5 class="q-ma-none text-h6">Adicionar Cliente</h5>
          </q-card-section>

          <q-card-section>
            <q-form @submit="adicionarCliente" class="q-gutter-md">
              <q-input
                v-model="novoCliente.nome"
                label="Nome completo"
                outlined
                :rules="[(val) => !!val || 'Nome é obrigatório']"
                required
              />

              <q-input
                v-model="novoCliente.cpf"
                label="CPF"
                outlined
                mask="###.###.###-##"
                :rules="[(val) => !!val || 'CPF é obrigatório', validarCPF]"
                required
              />

              <q-input
                v-model="novoCliente.telefone"
                label="Número de telefone"
                outlined
                mask="(##) #####-####"
                :rules="[(val) => !!val || 'Telefone é obrigatório']"
                required
              />

              <div class="q-mt-md">
                <q-btn
                  type="submit"
                  color="primary"
                  label="Adicionar Cliente"
                  class="full-width"
                  :loading="carregando"
                />
              </div>
            </q-form>
          </q-card-section>
        </q-card>
      </div>

      <!-- Lista de clientes -->
      <div class="col-12 col-md-6">
        <q-card class="q-pa-md">
          <q-card-section>
            <h5 class="q-ma-none text-h6">Lista de Clientes</h5>
          </q-card-section>

          <q-card-section>
            <div v-if="clientes.length === 0" class="text-center text-grey-6">
              Nenhum cliente cadastrado
            </div>

            <q-list v-else separator>
              <q-item
                v-for="(cliente, index) in clientes"
                :key="index"
                class="q-pa-md"
              >
                <q-item-section>
                  <q-item-label class="text-weight-bold">
                    {{ cliente.nome }}
                  </q-item-label>
                  <q-item-label caption>
                    CPF: {{ cliente.cpf }}
                  </q-item-label>
                  <q-item-label caption>
                    Telefone: {{ cliente.telefone }}
                  </q-item-label>
                  <q-item-label caption class="text-grey-6">
                    Adicionado em: {{ cliente.dataAdicao }}
                  </q-item-label>
                </q-item-section>

                <q-item-section side class="q-gutter-xs">
                  <div class="column q-gutter-xs">
                    <q-chip
                      :color="getStatusColor(cliente.status)"
                      text-color="white"
                      :label="cliente.status || 'Pendente'"
                      class="text-center"
                    />
                    <div class="row q-gutter-xs">
                      <q-btn
                        dense
                        size="sm"
                        color="green"
                        icon="check"
                        @click="alterarStatus(index, 'Concluído')"
                        :disable="cliente.status === 'Concluído'"
                      >
                        <q-tooltip>Marcar como Concluído</q-tooltip>
                      </q-btn>
                      <q-btn
                        dense
                        size="sm"
                        color="red"
                        icon="close"
                        @click="alterarStatus(index, 'Indisponível')"
                        :disable="cliente.status === 'Indisponível'"
                      >
                        <q-tooltip>Marcar como Indisponível</q-tooltip>
                      </q-btn>
                    </div>
                  </div>
                </q-item-section>

                <q-item-section side>
                  <q-btn
                    flat
                    round
                    color="negative"
                    icon="delete"
                    @click="removerCliente(index)"
                    size="sm"
                  >
                    <q-tooltip>Remover Cliente</q-tooltip>
                  </q-btn>
                </q-item-section>
              </q-item>
            </q-list>
          </q-card-section>
        </q-card>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useQuasar } from 'quasar'

const $q = useQuasar()

// Estado reativo
const carregando = ref(false)
const clientes = ref([])

// Novo cliente (removido o campo status)
const novoCliente = reactive({
  nome: '',
  cpf: '',
  telefone: ''
})

// Validação de CPF simples
const validarCPF = (cpf) => {
  if (!cpf) return 'CPF é obrigatório'
  const cpfLimpo = cpf.replace(/\D/g, '')
  if (cpfLimpo.length !== 11) return 'CPF deve ter 11 dígitos'
  return true
}

// Função para adicionar cliente
const adicionarCliente = async () => {
  carregando.value = true
  
  try {
    // Verificar se CPF já existe
    const cpfExiste = clientes.value.some(cliente => 
      cliente.cpf.replace(/\D/g, '') === novoCliente.cpf.replace(/\D/g, '')
    )
    
    if (cpfExiste) {
      $q.notify({
        type: 'negative',
        message: 'Cliente com este CPF já está cadastrado!'
      })
      return
    }

    // Adicionar cliente à lista (sem status inicial)
    clientes.value.push({
      nome: novoCliente.nome,
      cpf: novoCliente.cpf,
      telefone: novoCliente.telefone,
      status: 'Pendente', // Status inicial
      dataAdicao: new Date().toLocaleDateString('pt-BR')
    })

    // Limpar formulário
    Object.assign(novoCliente, {
      nome: '',
      cpf: '',
      telefone: ''
    })

    // Notificação de sucesso
    $q.notify({
      type: 'positive',
      message: 'Cliente adicionado com sucesso!'
    })

  } catch {
    $q.notify({
      type: 'negative',
      message: 'Erro ao adicionar cliente!'
    })
  } finally {
    carregando.value = false
  }
}

// Função para remover cliente
const removerCliente = (index) => {
  $q.dialog({
    title: 'Confirmar',
    message: 'Tem certeza que deseja remover este cliente?',
    cancel: true,
    persistent: true
  }).onOk(() => {
    clientes.value.splice(index, 1)
    $q.notify({
      type: 'positive',
      message: 'Cliente removido com sucesso!'
    })
  })
}

// Função para alterar status do cliente
const alterarStatus = (index, novoStatus) => {
  clientes.value[index].status = novoStatus
  $q.notify({
    type: 'positive',
    message: `Status alterado para: ${novoStatus}`,
    position: 'top-right'
  })
}

// Função para obter cor do status
const getStatusColor = (status) => {
  switch (status) {
    case 'Concluído':
      return 'green'
    case 'Indisponível':
      return 'red'
    case 'Pendente':
      return 'orange'
    default:
      return 'grey'
  }
}
</script>
