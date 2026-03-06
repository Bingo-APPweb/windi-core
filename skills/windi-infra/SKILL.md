---
name: windi-infra
description: Operações Strato — nginx, systemd, SSL, deploy, smoke test
tier: 1
agent: architect
---

# WINDI Infrastructure Operations

A bíblia do servidor. Consulte para QUALQUER operação de infraestrutura.

## Regras de Ouro

```
1. READ FIRST: ss + curl + grep ANTES de mudanças
2. BACKUP FIRST: sempre antes de nginx ou configs
3. nginx -t SEMPRE antes de reload
4. Propor ≠ Executar — aguardar Human Dragon
5. Git ao final: add + commit + push
```

## Nginx Operations

### Antes de editar
```bash
# Backup
sudo cp /etc/nginx/sites-enabled/windi-domain.com /opt/windi/backups/nginx_$(date +%Y%m%d_%H%M%S).conf

# Verificar estado atual
sudo nginx -t
```

### Depois de editar
```bash
# Testar
sudo nginx -t

# Se OK, reload
sudo systemctl reload nginx

# Verificar
curl -I https://windi-domain.com
```

## Systemd Operations

### Listar serviços WINDI
```bash
systemctl list-units --type=service --state=running | grep windi
```

### Restart seguro
```bash
# Status antes
systemctl status windi-<service>

# Restart
sudo systemctl restart windi-<service>

# Verificar
systemctl status windi-<service>
curl -s localhost:<port>/health
```

## Deploy Checklist

- [ ] Backup criado
- [ ] nginx -t passou
- [ ] Serviço reiniciado
- [ ] Health check OK
- [ ] Smoke test OK
- [ ] Git commit feito

## Smoke Test Template

```bash
for endpoint in /health /api/status; do
  code=$(curl -s -o /dev/null -w '%{http_code}' "https://windi-domain.com$endpoint")
  echo "$endpoint: $code"
done
```

## Portas SEALED (NUNCA tocar sem aprovação)

- **8101** — Forensic Ledger
- **8102** — Sentinel LAW
- **8106** — Forensic Vault
