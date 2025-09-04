@echo off
echo "===================================="
echo "SCRIPT DE SINCRONIZAÇÃO COM GITHUB"
echo "===================================="
echo.

echo "1. Verificando status do Git..."
git status
echo.

echo "2. Adicionando todos os arquivos..."
git add .
echo.

echo "3. Fazendo commit das alterações..."
git commit -m "feat: Sistema de Controle de Clientes completo

- Página inicial personalizada com boas-vindas à Naty
- Sistema de upload e gerenciamento de foto de perfil
- Página de gerenciamento de clientes com CRUD completo
- Modo dark/light com persistência
- Navbar com navegação entre páginas
- Design responsivo e moderno
- Animações e transições suaves"
echo.

echo "4. Adicionando repositório remoto..."
git remote add origin https://github.com/CyberStorebcb/sistema-controle-clientes.git
echo.

echo "5. Fazendo push para o GitHub..."
git branch -M main
git push -u origin main
echo.

echo "===================================="
echo "SINCRONIZAÇÃO CONCLUÍDA!"
echo "===================================="
echo.
echo "Seu código foi enviado para:"
echo "https://github.com/CyberStorebcb/sistema-controle-clientes"
echo.
pause
