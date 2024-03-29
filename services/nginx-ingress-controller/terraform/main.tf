module "nginx_ingress_controller_helm_release" {
    source = "../common/helm"
    release_name = var.release_name
    chart_name = var.chart_name
    repository = var.repository
    namespace = var.namespace
    values = var.values
    inputs = var.inputs
    wait_for_jobs = false
}