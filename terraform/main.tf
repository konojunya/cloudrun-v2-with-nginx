provider "google" {
  project = var.project_id
  region  = var.default_region
}

provider "google-beta" {
  project = var.project_id
  region  = var.default_region
}

// Artifact Registry
resource "google_artifact_registry_repository" "sample" {
  provider      = google-beta
  location      = var.default_region
  repository_id = "sample"
  description   = "sample project"
  format        = "DOCKER"

  /**
  * Artifact Registry で保存するコンテナイメージを数で指定する
  */
  cleanup_policies {
    id     = "keep_minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 3
    }
  }
}

// Cloud Run
resource "google_cloud_run_v2_service" "sample" {
  provider = google-beta
  name     = "sample"
  location = var.default_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    // アプリケーションコンテナイメージの設定
    containers {
      name  = "app"
      image = "asia-northeast1-docker.pkg.dev/${var.project_id}/sample/app:latest"
      env {
        name  = "PORT"
        value = "8888"
      }
    }

    // Proxy コンテナの設定
    containers {
      name = "proxy"
      ports {
        container_port = 8080
      }
      depends_on = ["app"]
      image      = "asia-northeast1-docker.pkg.dev/${var.project_id}/sample/proxy:latest"
    }

    // auto scaling の設定
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

// Cloud Run を一般公開する
resource "google_cloud_run_service_iam_binding" "sample" {
  location = google_cloud_run_v2_service.sample.location
  service  = google_cloud_run_v2_service.sample.name
  role     = "roles/run.invoker"
  members = [
    "allUsers",
  ]
}
