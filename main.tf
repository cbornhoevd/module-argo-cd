# Configure Kubernetes and Helm Providers
provider "kubernetes" {
  #load_config_file       = false
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_cert_data)
  host                   = var.kubernetes_cluster_endpoint

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws-iam-authenticator"
    args = [
      "token",
      "-i",
      "${var.kubernetes_cluster_name}"
    ]
  }
}

provider "helm" {
  kubernetes {
    #load_config_file       = false
    cluster_ca_certificate = base64decode(var.kubernetes_cluster_cert_data)
    host                   = var.kubernetes_cluster_endpoint

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws-iam-authenticator"
      args = [
        "token",
        "-i",
        "${var.kubernetes_cluster_name}"
      ]
    }
  }
}

# Helm Chart for Argo CD Deployment
resource "kubernetes_namespace" "argo-ns" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "jupiter"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"

  # We are going to access the console with a port forwarded connection,
  # so we will disable TLS. This allows us to avoid the self-signed certificate
  # warning for localhost.
  # controller.extraArgs = ["insecure"]
}
