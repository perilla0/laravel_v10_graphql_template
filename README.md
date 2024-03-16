- [1. このプロジェクトについて](#1-このプロジェクトについて)
  - [1.1. 環境ファイル（.env）編集](#11-環境ファイルenv編集)
  - [1.2. プロジェクト作成＆削除](#12-プロジェクト作成削除)
  - [1.3. CORS設定](#13-cors設定)
  - [1.4. コンテナ立ち上げ](#14-コンテナ立ち上げ)
  - [1.5. すべてのコンテナを削除](#15-すべてのコンテナを削除)
- [2. URL](#2-url)
  - [2.1. バックエンド](#21-バックエンド)
  - [2.2. フロントエンド](#22-フロントエンド)

# 1. このプロジェクトについて

Laravel v10を自前のDocker Composeで使用するためのテンプレ用プロジェクトです。

- バックエンド -> backendコンテナ [ [GraphQL on Laravel](https://lighthouse-php.com/) ]
- フロントエンド -> frontendコンテナ [ [Apollo Client on Vite](https://www.apollographql.com/docs/react/get-started/) ]

※ このプロジェクトでは、あえて`.gitignore`にて`/src`ディレクトリを捕捉しないよう設定しています。（必要に応じて指定を削除してください）

## 1.1. 環境ファイル（.env）編集

.envファイルの以下のオプションを設定します。

- LARAVEL_BREEZE_FRONTEND_OPTION（Laravel Breezeのフロントエンドオプション。）
- APOLLO_CLIENT_TEMPLATE_OPTION（Viteの言語オプション。）

## 1.2. プロジェクト作成＆削除

srcフォルダを作成します。  
srcフォルダには、以下の2つのコンテナで使用するソースファイルが含まれます。

- backend（[Laravel v10](https://readouble.com/laravel/10.x/ja/installation.html)プロジェクトファイル一式）
- frontend（[Vite](https://ja.vitejs.dev/)を中核としたフロントエンドファイル一式）

```sh
cd script/init/
./create_src.sh
```

srcフォルダを削除したい場合にのみ実行します。

```sh
cd script/init/
./remove_src.sh
```

## 1.3. CORS設定

/src/backend/config/cors.phpを編集する

https://lighthouse-php.com/master/getting-started/configuration.html#cors
https://developer.mozilla.org/ja/docs/Web/HTTP/CORS

Apollo ClientからGraphQLエンドポイントを使用するために必要な設定です。

```php
return [
-   'paths' => ['api/*', 'sanctum/csrf-cookie'],
+   'paths' => ['api/*', 'graphql', 'sanctum/csrf-cookie'],
    ...
];
```

## 1.4. コンテナ立ち上げ

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

テーブル作成（最初のみ）

`docker compose up`を実行して各コンテナが立ち上がっていることが前提。

```sh
docker compose exec -u $(id -u):$(id -g) backend php artisan migrate
```

usersテーブルにレコードを追加

```sh
docker compose exec backend php artisan tinker
\App\Models\User::factory(10)->create();
```

## 1.5. すべてのコンテナを削除

```sh
cd script
./down_clear.sh
```

# 2. URL

## 2.1. バックエンド

Laravel Breeze  
http://localhost

Laravel GraphQL エンドポイント  
http://localhost/graphiql

Laravel Horizon  
http://localhost/horizon

## 2.2. フロントエンド

http://localhost:4000
