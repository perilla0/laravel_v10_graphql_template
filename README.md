- [1. このプロジェクトについて](#1-このプロジェクトについて)
  - [1.1. Laravelプロジェクト作成＆削除](#11-laravelプロジェクト作成削除)
  - [1.2. スターターキットのインストール](#12-スターターキットのインストール)
  - [1.3. コンテナ立ち上げ](#13-コンテナ立ち上げ)
  - [1.4. すべてのコンテナを削除](#14-すべてのコンテナを削除)

# 1. このプロジェクトについて

Laravel v10を自前のDocker Composeで使用するためのテンプレ用プロジェクトです。

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

## 1.2. スターターキットのインストール

Laravelプロジェクトが作成されいていることが前提となります。

```sh
docker compose run -u $(id -u):$(id -g) --rm app bash -c "
composer require laravel/breeze --dev
php artisan breeze:install
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
docker compose exec -u $(id -u):$(id -g) app php artisan migrate
```

npm

appコンテナが起動していることが前提です。

```sh
docker compose exec -u $(id -u):$(id -g) app npm install
docker compose exec -u $(id -u):$(id -g) app npm run build
```

## 1.4. すべてのコンテナを削除

```sh
cd script
./down_clear.sh
```
