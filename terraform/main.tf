provider "aws" {
  profile = "personal"
  region = "us-east-2"
}

provider "aws" {
  profile = "personal"
  region = "us-east-1"
  alias = "us-east-1"
}



module "ophtalmo-site" {
  source = "./serverless-website"
  www_domain   = var.www_domain /* Your domain here e.g. www.example.com */
  root_domain = var.root_domain /* Your root domain here */
  ssl-validation = "EMAIL" /* How to validate */
  ssh_pub_key = "~/.ssh/id_rsa.pub" /* Path to the SSH Pub key for CodeCommit authentication */
  bucket_prefix = "" /* Prefix for S3 Buckets */
}

output "nameservers" {
  value = module.ophtalmo-site.nameservers
}

output "git_remote_url" {
  value = module.ophtalmo-site.git_remote_url
}
