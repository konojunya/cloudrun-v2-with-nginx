# cloudrun-v2-with-nginx

Try Cloud Run v2 multi container

## 下準備

Google Cloud で使うコンポーネントの有効化をする。なるべく話をわかりやすくするために Artifact Registry と Cloud Run だけ使う。

デフォルトでは API が有効になっていないのでコンソールから行うか、以下のコマンドで有効にする。

```shell
gcloud services enable artifactregistry.googleapis.com run.googleapis.com
```

### Debug

手元で挙動を確認するための compose.yaml も追加しておいたので、 Nginx -> application の挙動を確認するために活用できます。

また Nginx のポートは Cloud Run のデフォルトである `8080` に合わせているため立ち上げた後、 `http://localhost:8080` で application のレスポンスを確認することができます。

```shell
docker compose up
```

### Terraform

`terraform` ディレクトリで `terraform apply` を行うと Artifact Registry と Cloud Run の設定が完了する。
