---
name: windi-location-matrix
description: GPS instantâneo da infraestrutura WINDI — portas, paths, nginx, serviços
tier: 1
agent: guardian
---

# WINDI Location Matrix

GPS instantâneo da infraestrutura. Consulte ANTES de qualquer operação no Strato.

## Mapa de Portas

| Porta | Serviço | Status |
|-------|---------|--------|
| 8080 | Governance API | active |
| 8085 | Hub | active |
| 8091 | Sandbox Core / Agent Corps | active |
| 8098 | Sentinel | active |
| 8099 | Wallet | active |
| 8100 | a4Desk Desktop | active |
| 8101 | Forensic Ledger | **SEALED** |
| 8102 | Sentinel LAW | **SEALED** |
| 8103 | Export Engine | active |
| 8104 | JMPG Viewer | active |
| 8105 | Communiqué Engine | active |
| 8106 | Forensic Vault | **SEALED** |
| 8107 | Landing P/M/G | active |
| 8108 | Dragon / Palette | active |
| 8114 | Verify Public | active |

## Paths Críticos

```
/opt/windi/                    ← Base
/opt/windi/agents/             ← Agent blueprints
/opt/windi/communique/         ← Communiqué Engine
/opt/windi/forensic-ledger/    ← Ledger data
/opt/windi/forensic-vault/     ← Vault storage
/opt/windi/plugins/            ← CCode plugins
/etc/nginx/sites-enabled/      ← Nginx configs
```

## Domínio

```
windi-domain.com (ONE TREE)
├── /app/           → :8108 Palette
├── /communique/    → :8105 Engine
├── /vault/         → :8106 Vault
├── /api/ledger/    → :8101 Ledger
└── /verify-public/ → :8114 Verify
```

## Comandos de Verificação

```bash
# Status de portas
ss -tlnp | grep 81

# Health check
curl -s localhost:8091/health

# Nginx routes
grep "location" /etc/nginx/sites-enabled/windi-domain.com
```
