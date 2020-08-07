resource "aws_codecommit_repository" "git_repository" {
  repository_name = var.www_domain
  description     = "This Repository contains Website and Terraform code for ${var.www_domain}"
  default_branch = "master"
}
