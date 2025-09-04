# Script de Sincronização com GitHub
Write-Host "====================================" -ForegroundColor Green
Write-Host "SCRIPT DE SINCRONIZAÇÃO COM GITHUB" -ForegroundColor Green  
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

Write-Host "1. Verificando status do Git..." -ForegroundColor Yellow
git status
Write-Host ""

Write-Host "2. Adicionando todos os arquivos..." -ForegroundColor Yellow
git add .
Write-Host ""

Write-Host "3. Fazendo commit das alterações..." -ForegroundColor Yellow
git commit -m "feat: Sistema de Controle de Clientes completo

- Página inicial personalizada com boas-vindas à Naty
- Sistema de upload e gerenciamento de foto de perfil  
- Página de gerenciamento de clientes com CRUD completo
- Modo dark/light com persistência
- Navbar com navegação entre páginas
- Design responsivo e moderno
- Animações e transições suaves"
Write-Host ""

Write-Host "4. Adicionando repositório remoto..." -ForegroundColor Yellow
git remote add origin https://github.com/CyberStorebcb/sistema-controle-clientes.git
Write-Host ""

Write-Host "5. Fazendo push para o GitHub..." -ForegroundColor Yellow
git branch -M main
git push -u origin main
Write-Host ""

Write-Host "====================================" -ForegroundColor Green
Write-Host "SINCRONIZAÇÃO CONCLUÍDA!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Seu código foi enviado para:" -ForegroundColor Cyan
Write-Host "https://github.com/CyberStorebcb/sistema-controle-clientes" -ForegroundColor Cyan
Write-Host ""
Read-Host "Pressione Enter para continuar"
