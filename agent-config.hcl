
vault {
  address = "https://VAULT_ADDR:8200"
}
auto_auth {
  method {
    type = "token_file"

    config = {
      token_file_path = "C:\\Program Files\\Vault\\Data\\vault-token"
    }
  }
}
template {
source = "C:\\Vault\\agent\\wincert.tpl"
destination = "C:\\Vault\Data\\certificate.crt"
command = "Set-Location -Path cert:\\CurrentUser\\My ; Import-Certificate -Filepath 'C:\\Vault\\Data\\certificate.crt"
}

