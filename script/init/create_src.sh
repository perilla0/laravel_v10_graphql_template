#!/bin/bash
cd `dirname $0`
cd ../../

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
cp ./script/init/.env.local ./src/backend/.env

# .envのAPP_KEYを変更する
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
php artisan key:generate
"

# --------------------------------------------------------
# frontend
# --------------------------------------------------------

docker compose run -u $(id -u):$(id -g) --rm frontend bash -c "
npm create vite@latest . -- --template react-ts
npm install @apollo/client graphql
npm install
"