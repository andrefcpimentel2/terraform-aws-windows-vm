vault {
  address = "https://vault-cluster-public-vault-ac8761f4.d81e32a1.z1.hashicorp.cloud:8200"
  namespace = "admin"
}
auto_auth {
  method {
    type      = "approle"

    config = {
      role_id_file_path = "3f75fdf8-1bf7-837c-5c19-54404a522e42"
      secret_id_file_path = "de3653f5-d5f6-d7db-1c49-1916094402fa"
      remove_secret_id_file_after_reading = false
    }
  }
}


template {
  contents             = "{{- with pkiCert \"pki_int/issue/example-dot-com\" \"ttl=24h\" \"common_name=foo.example.com\" -}}{{ .Cert }}{{- end }}"
  destination  = "cert.crt"
}
