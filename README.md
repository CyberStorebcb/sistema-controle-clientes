# Sistema de Controle de Clientes

Um sistema moderno e responsivo para gerenciamento de clientes, desenvolvido com Quasar Framework e Vue 3.

## 🚀 Características

- ✨ Interface moderna e responsiva
- 🌓 Modo dark/light
- 📱 Design mobile-first
- 👤 Sistema de foto de perfil
- 📊 Dashboard com estatísticas
- 🎨 Animações suaves e elegantes

## 🛠️ Tecnologias

- **Quasar Framework v2.18.2** - Framework Vue.js
- **Vue 3** - Framework JavaScript reativo
- **JavaScript/TypeScript** - Linguagem de programação
- **ESLint** - Linter para qualidade de código
- **Vite** - Build tool rápido

## 💻 Instalação

```bash
# Instalar dependências
npm install

# Executar em modo de desenvolvimento
npm run dev

# Build para produção
npm run build
```

## 🔧 Funcionalidades

### 🏠 Página Inicial

- Boas-vindas personalizadas para "Naty"
- Upload e gerenciamento de foto de perfil
- Cards informativos com estatísticas
- Animação especial no nome com gradiente colorido

### 👥 Gerenciamento de Clientes

- Formulário de cadastro com validação
- Lista de clientes com filtros
- Status de clientes (Pendente, Concluído, Indisponível)
- Operações CRUD completas

### 🎨 Interface

- Modo dark/light com persistência
- Design responsivo para mobile e desktop
- Navbar com navegação intuitiva
- Animações e transições suaves

## 📁 Estrutura do Projeto

```
src/
├── components/          # Componentes reutilizáveis
├── layouts/            # Layouts da aplicação
│   └── MainLayout.vue  # Layout principal
├── pages/              # Páginas da aplicação
│   ├── IndexPage.vue   # Página inicial
│   └── ClientesPage.vue # Página de clientes
├── router/             # Configuração de rotas
└── css/               # Estilos globais
```

## 🚀 Deploy e Sincronização com GitHub

### Primeira vez (criando repositório):

1. No GitHub, crie um novo repositório chamado "sistema-controle-clientes"
2. Execute um dos scripts de sincronização:

**Windows (CMD):**

```cmd
sync-github.bat
```

**Windows (PowerShell):**

```powershell
.\sync-github.ps1
```

**Manual (Git):**

```bash
git add .
git commit -m "feat: Sistema de Controle de Clientes completo"
git remote add origin https://github.com/CyberStorebcb/sistema-controle-clientes.git
git branch -M main
git push -u origin main
```

### Atualizações futuras:

```bash
git add .
git commit -m "Descrição das mudanças"
git push
```

## 🌐 Deploy no Vercel

### Deploy Automático:

1. Acesse: https://vercel.com
2. Conecte com GitHub
3. Importe o repositório: `sistema-controle-clientes`
4. Deploy automático será configurado!

### Configurações:

- **Build Command:** `npm run build`
- **Output Directory:** `dist/spa`
- **Framework:** Other (auto-detectado)

📖 **Guia completo:** Veja `DEPLOY-VERCEL.md`

## 🏃‍♂️ Scripts Disponíveis

```bash
# Desenvolvimento
npm run dev
quasar dev

# Build
npm run build
quasar build

# Linting
npm run lint

# Formatação
npm run format
```

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**CyberStorebcb**

- GitHub: [@CyberStorebcb](https://github.com/CyberStorebcb)
