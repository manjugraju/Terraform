provider "aws" {
    region = "us-east-1"
}

provider "vault" {
    address = "http://54.146.196.129:8200"
    skip_child_token = true
    auth_login {
      path = "auth/approle/login"
      parameters = {
        role_id = "2f75737b-b85f-4319-c2c7-fecfbc546a1b"
        secret_id = "b7114255-3f05-3b37-30d0-6c2f4437917f"
      }
    }
  
}

data "vault_kv_secret_v2" "example" {
  mount = "credentials"
  name  = "test secret"
}




