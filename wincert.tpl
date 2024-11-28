{{- with pkiCert "pki_int/issue/example-dot-com" "ttl=24h" "common_name=foo.example.com" -}}
{{ .Cert }}
{{ .CA }}
{{ if .Key }}
{{ .Key  | writeToFile "C:\\Program Files\Vault\\Data\\certificate.key" "" "" "" }}
{{ end }}