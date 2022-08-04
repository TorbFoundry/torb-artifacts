module "postgres_helm_release" {
    source = "../../terraform/helm/main.tf"
    release_name = var.release_name
    chart_name = var.chart_name
    repository = var.repository
    namespace = var.namespace
    values = var.values
}