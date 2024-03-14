- [1. このプロジェクトについて](#1-このプロジェクトについて)
  - [1.1. Laravelプロジェクト作成＆削除](#11-laravelプロジェクト作成削除)
  - [1.2. プロジェクト作成後の各種インストール](#12-プロジェクト作成後の各種インストール)
    - [スターターキットインストール](#スターターキットインストール)
    - [LightHouseインストール](#lighthouseインストール)
  - [1.3. コンテナ立ち上げ](#13-コンテナ立ち上げ)
  - [1.4. すべてのコンテナを削除](#14-すべてのコンテナを削除)

# 1. このプロジェクトについて

Laravel v10を自前のDocker Composeで使用するためのテンプレ用プロジェクトです。

- Backend [ GraphQL on Laravel ]
- Frontend [ Apollo Client (React-ts) ]

※ このプロジェクトでは、あえて`.gitignore`にて`/src`ディレクトリを捕捉しないよう設定しています。（必要に応じて指定を削除してください）

## 1.1. Laravelプロジェクト作成＆削除

Laravelプロジェクト（srcフォルダ）を作成します。

```sh
cd script/init/
./create_src.sh
```

Laravelプロジェクト（srcフォルダ）を削除したい場合にのみ実行します。

```sh
cd script/init/
./remove_src.sh
```

## 1.2. プロジェクト作成後の各種インストール

Laravelプロジェクトが作成されいていることが前提となります。

### スターターキットインストール

react + ダークデザインでインストールします。

```sh
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
composer require laravel/breeze --dev
php artisan breeze:install react --dark
npm install
npm run build
"
```

### LightHouseインストール

LaravelのGraphQLプラグインをインストールします。

https://lighthouse-php.com/5/getting-started/installation.html#install-via-composer

```sh
docker compose run -u $(id -u):$(id -g) --rm backend bash -c "
composer require nuwave/lighthouse
php artisan vendor:publish --tag=lighthouse-schema
composer require mll-lab/laravel-graphiql
php artisan lighthouse:ide-helper
php artisan vendor:publish --tag=lighthouse-config
"
```

## 1.3. コンテナ立ち上げ

コンテナビルド

```sh
cd script
./build.sh
```

コンテナ立ち上げ

```sh
docker compose up --build
docker compose up
```

DBマイグレーション（最初１回）

`docker compose up`で全てのコンテナが起動していることが前提です。

```sh
docker compose exec -u $(id -u):$(id -g) backend php artisan migrate
```

usersにレコードを追加

```sh
docker compose exec backend php artisan tinker
\App\Models\User::factory(10)->create()
```

npm

backendコンテナが起動していることが前提です。
※ Laravel付属のフロントエンドのため、管理画面に使用する予定

```sh
docker compose exec -u $(id -u):$(id -g) backend npm install
docker compose exec -u $(id -u):$(id -g) backend npm run build
```

## 1.4. すべてのコンテナを削除

```sh
cd script
./down_clear.sh
```
