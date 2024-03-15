#!/bin/bash
cd `dirname $0`
cd ../../

source .env

mkdir -p src/backend
mkdir -p src/frontend

# --------------------------------------------------------
# backend
# --------------------------------------------------------

# 現在ログイン中のユーザーでLaravelプロジェクトを作成する
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
composer create-project \"laravel/laravel=10.*\" ./
chmod -R 0777 storage
chmod -R 0777 bootstrap/cache
composer require predis/predis
composer require laravel/horizon
php artisan horizon:install
"

# 環境ファイルを差し替える
cp ./script/init/src/backend/.env.local ./src/backend/.env

# .envのAPP_KEYを変更する
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
php artisan key:generate
"

# スターターキットのインストール
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
composer require laravel/breeze --dev
php artisan breeze:install ${LARAVEL_BREEZE_FRONTEND_OPTION}
npm install
npm run build
"

# GraphQLプラグインのインストール
# https://lighthouse-php.com/5/getting-started/installation.html#install-via-composer
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
composer require nuwave/lighthouse
php artisan vendor:publish --tag=lighthouse-schema
composer require mll-lab/laravel-graphiql
php artisan lighthouse:ide-helper
php artisan vendor:publish --tag=lighthouse-config
"

# --------------------------------------------------------
# frontend
# --------------------------------------------------------

docker compose run -u $(id -u):$(id -g) --rm frontend bash -c "
npm create vite@latest . -- --template ${APOLLO_CLIENT_TEMPLATE_OPTION}
npm install @apollo/client graphql
npm install
"

# react
if [ -f ./src/frontend/src/App.jsx ]; then
    cp ./src/frontend/src/main.jsx ./src/frontend/src/main.origin.jsx
    cp ./src/frontend/src/App.jsx ./src/frontend/src/App.origin.jsx
    cp ./script/init/src/frontend/react/main.jsx ./src/frontend/src/main.jsx
    cp ./script/init/src/frontend/react/App.jsx ./src/frontend/src/App.jsx
fi

# react-ts
if [ -f ./src/frontend/src/App.tsx ]; then
    cp ./src/frontend/src/main.tsx ./src/frontend/src/main.origin.tsx
    cp ./src/frontend/src/App.tsx ./src/frontend/src/App.origin.tsx
    cp ./script/init/src/frontend/react-ts/main.tsx ./src/frontend/src/main.tsx
    cp ./script/init/src/frontend/react-ts/App.tsx ./src/frontend/src/App.tsx
fi
