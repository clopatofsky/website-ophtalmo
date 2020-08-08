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

  sender_email = var.sender_email // "no-reply@awesomelitbusiness.biz"
  recipient_email = var.recipient_email // "sales@awesomelitbusiness.biz"
  allowed_origin = var.allowed_origin // "http://localhost:8000,https://awesomelitbusiness.biz"
  required_params = var.required_params // "name,email,message,how_did_you_find_us"
  optional_params = var.optional_params // "company,cell_phone,work_phone"
}

output "nameservers" {
  value = module.ophtalmo-site.nameservers
}

output "git_remote_url" {
  value = module.ophtalmo-site.git_remote_url
}

output "message_post_url" {
  value = module.ophtalmo-site.message_post_url
}

output "api_key" {
  value = module.ophtalmo-site.api_key
}
