terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
  }

  backend "gcs" {
    bucket = "jo-terraform-states"
    prefix = "gce-infra"
  }
}

provider "google" {
  project = "jo-shared-services-lzzo"
  region  = "us-central1"
}

provider "google" {
  alias   = "target"
  project = "jo-playground-1-ateh"
  region  = "us-central1"
}
