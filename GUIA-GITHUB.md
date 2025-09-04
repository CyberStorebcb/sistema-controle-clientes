# 🚀 GUIA COMPLETO: Sincronização com GitHub

## Pré-requisitos

1. ✅ Git instalado (verificar com: `git --version`)
2. ✅ Conta no GitHub ativa
3. ✅ Projeto já inicializado com Git

## 📝 Passo a Passo

### 1️⃣ Criar Repositório no GitHub

1. Acesse: https://github.com/CyberStorebcb
2. Clique em "New repository"
3. Nome do repositório: `sistema-controle-clientes`
4. Descrição: "Sistema moderno de controle de clientes com Vue.js e Quasar"
5. Marque "Public" ou "Private" (sua escolha)
6. ❌ NÃO marque "Initialize with README" (já temos um)
7. Clique em "Create repository"

### 2️⃣ Comandos no Terminal

Abra o PowerShell ou CMD no diretório do projeto e execute:

```bash
# 1. Verificar status
git status

# 2. Adicionar todos os arquivos
git add .

# 3. Fazer commit inicial
git commit -m "feat: Sistema de Controle de Clientes completo

- Página inicial personalizada com boas-vindas à Naty
- Sistema de upload e gerenciamento de foto de perfil
- Página de gerenciamento de clientes com CRUD completo
- Modo dark/light com persistência
- Navbar com navegação entre páginas
- Design responsivo e moderno
- Animações e transições suaves"

# 4. Adicionar repositório remoto
git remote add origin https://github.com/CyberStorebcb/sistema-controle-clientes.git

# 5. Configurar branch principal
git branch -M main

# 6. Enviar para GitHub
git push -u origin main
```

### 3️⃣ Scripts Automáticos (Opcional)

Execute um dos scripts criados:

**Windows CMD:**

```cmd
sync-github.bat
```

**Windows PowerShell:**

```powershell
.\sync-github.ps1
```

### 4️⃣ Verificação

Após o push, acesse:
https://github.com/CyberStorebcb/sistema-controle-clientes

Você deve ver todos os arquivos do projeto!

## 🔄 Para Atualizações Futuras

```bash
git add .
git commit -m "Descrição da mudança"
git push
```

## ❗ Possíveis Problemas

### Se der erro de "remote already exists":

```bash
git remote remove origin
git remote add origin https://github.com/CyberStorebcb/sistema-controle-clientes.git
```

### Se pedir autenticação:

Use seu token pessoal do GitHub em vez da senha.

### Se der erro de push:

```bash
git pull origin main --allow-unrelated-histories
git push -u origin main
```

## ✅ Resultado Final

- ✨ Código sincronizado no GitHub
- 📱 Repositório público/privado configurado
- 🔄 Pronto para colaboração
- 📄 README completo com documentação
