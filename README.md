# cloudrun-v2-with-nginx

Try Cloud Run v2 multi container

## 下準備

Google Cloud で使うコンポーネントの有効化をする。なるべく話をわかりやすくするために Artifact Registry と Cloud Run だけ使う。

デフォルトでは API が有効になっていないのでコンソールから行うか、以下のコマンドで有効にする。

```shell
gcloud services enable artifactregistry.googleapis.com run.googleapis.com
```

### Debug

手元で挙動を確認するための compose.yaml も追加しておいたので、 nginx -> application の挙動を確認するために活用する。

また nginx のポートは Cloud Run のデフォルトである `8080` に合わせているため立ち上げた後、 `http://localhost:8080` で application のレスポンスを確認することができる。

また手元の docker 環境で確認する場合、 `127.0.0.1` ではなく `host.docker.internal` を通常使う。そのため proxy_pass の origin を `127.0.0.1` から `host.docker.internal` に書き換えてから実行。

```diff
location / {
+  proxy_pass   http://host.docker.internal:8888;
-  proxy_pass   http://127.0.0.1:8888;
}
```

```shell
docker compose up
```

また nginx.conf を書き換えた場合、そのまま `docker compose up` を行っても前回ビルドしたコンテナイメージが使われてしまうので、 `docker compose up --build` として再度ビルドを行う必要がある。

### Terraform

`terraform` ディレクトリで `terraform apply` を行うと Artifact Registry と Cloud Run の設定ができる。
