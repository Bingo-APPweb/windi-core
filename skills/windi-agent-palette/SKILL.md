---
name: windi-agent-palette
description: Palette frontend — deploy, temas KLAR/NOIR, tiles, SealBadge
tier: 1
agent: architect
---

# WINDI Agent Palette

Deploy e manutenção do frontend Palette (:8108).

## Localização

```
Serviço:  windi-agent-palette.service
Porta:    8108
Path:     /opt/windi/agent-palette/
UI:       /opt/windi/agent-palette/ui/index.html
URL:      https://windi-domain.com/app/
```

## Temas

### NOIR (Dark)
```css
--bg-primary: #0E0E14;
--text-primary: #F5F0E0;
--accent: #8B5CF6;
```

### KLAR (Light)
```css
--bg-primary: #F5F0E0;
--text-primary: #0E0E14;
--accent: #6366F1;
```

## Componentes Principais

- **SealBadge**: Indicador de documento selado
- **GovPanel**: Painel de governança
- **Tiles**: Cards de ação
- **W-WICKTHIS**: Modal de publicação Evidence Graph

## Deploy

```bash
# Verificar serviço
systemctl status windi-agent-palette

# Editar UI (arquivos estáticos - mudanças imediatas)
vi /opt/windi/agent-palette/ui/index.html

# Se mudar Python, restart necessário
sudo systemctl restart windi-agent-palette

# Verificar
curl -s https://windi-domain.com/app/ | head -20
```

## URLs da API

```javascript
// Produção (ONE TREE)
vaultApiUrl = 'https://windi-domain.com/vault'
communiqueApiUrl = 'https://windi-domain.com/communique'
wickApiUrl = 'https://windi-domain.com/api/sandbox/wick'
```
