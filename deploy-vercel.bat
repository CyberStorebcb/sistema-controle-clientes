@echo off
echo "========================================="
echo "PREPARANDO DEPLOY PARA VERCEL"
echo "========================================="
echo.

echo "1. Adicionando configurações do Vercel..."
git add .
echo.

echo "2. Fazendo commit das configurações..."
git commit -m "feat: Configurações para deploy no Vercel

- Adicionado vercel.json com configurações de build
- Alterado vueRouterMode para 'history'
- Criado guia completo de deploy
- Configurado build para SPA no Vercel
- README atualizado com instruções de deploy"
echo.

echo "3. Enviando para GitHub..."
git push
echo.

echo "========================================="
echo "CONFIGURAÇÕES ENVIADAS!"
echo "========================================="
echo.
echo "Próximos passos:"
echo "1. Acesse: https://vercel.com"
echo "2. Conecte com GitHub"
echo "3. Importe: sistema-controle-clientes"
echo "4. Deploy automatico sera configurado!"
echo.
echo "Guia completo: DEPLOY-VERCEL.md"
echo.
pause
