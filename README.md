# cloudrun-v2-with-nginx

Try Cloud Run v2 multi container

## 下準備

Google Cloud で使うコンポーネントの有効化をする。なるべく話をわかりやすくするために Artifact Registry と Cloud Run だけ使う。

Artifact Registry はデフォルトでは API が有効になっていないのでコンソールから行うか、以下のコマンドで有効にする。

```shell
gcloud services enable artifactregistry.googleapis.com
```

### Terraform

`terraform` ディレクトリで `terraform apply` を行うと Artifact Registry と Cloud Run の設定が完了する。
