# mitsuami-backend

ミツアミ（Mitsuami）は、出自の違う3つのAIが合議して答える、球体の話しかけガジェットです。
名前は「三つ編み」から取りました。3本を編んで1本にするように、3つの意見をそれぞれの形のまま編み合わせて、1つの答えにします。

このリポジトリは、ミツアミの司令塔です。質問を受け取り、3つのユニットに同時に聞いて、多数決で結論を返します。

## 現在の状態

Rails API の雛形だけがあります。動くのはヘルスチェック（`GET /up`）のみで、多数決の処理はこれから作ります。

## 役割

- 質問を3つのユニットの `POST /judge` に並列で送る
- 返ってきた賛否（`approve` / `deny`）を多数決にかける
- タイムアウトや失敗は「棄権」として扱い、残りで多数決を続ける
- 質問と回答を PostgreSQL に記録する

司令塔が知っているのは、各ユニットのURLと名前だけです。ユニットの言語やモデルには依存しません。

## 技術

- Ruby 4.0.9 / Rails 8.1（API モード）
- PostgreSQL 18

## 起動

Docker が必要です。

```sh
docker compose up --build
curl http://localhost:3000/up
```

`Dockerfile` は開発用、`Dockerfile.prod` は本番用です。

## 関連リポジトリ

| リポジトリ | 役割 |
|---|---|
| [mitsuami-backend](https://github.com/terumitt-dev/mitsuami-backend) | 司令塔。3つのユニットに質問を送り、多数決で結論を返す（Rails） |
| [mitsuami-frontend](https://github.com/terumitt-dev/mitsuami-frontend) | 画面。質問を送り、賛否と結論を表示する（React） |
| [mitsuami-unit-python](https://github.com/terumitt-dev/mitsuami-unit-python) | ユニット「科学者」（Python、FastAPI、PyTorch） |
| [mitsuami-unit-go](https://github.com/terumitt-dev/mitsuami-unit-go) | ユニット「母」（Go、net/http、llama.cpp） |
| [mitsuami-unit-rust](https://github.com/terumitt-dev/mitsuami-unit-rust) | ユニット「女」（Rust、axum、ONNX Runtime） |
| mitsuami-personas（非公開） | 人格の定義、学習データ、追加学習と変換のスクリプト |
