---
name: windi-clone
description: WINDI Clone instances — nós autônomos, prateleiras P0-P7, fases 1→3
tier: 2
agent: architect
---

# WINDI Clone

Deploy e gestão de instâncias Clone — nós autônomos constitucionais.

## Conceito

Clone = Instância autônoma do WINDI que opera sob as mesmas invariantes constitucionais, mas com dados e contexto próprios.

## Fases de Maturidade

### Fase 1 — Semente
- Configuração básica
- Conexão com WINDI central
- Validação de invariantes

### Fase 2 — Crescimento
- Dados próprios
- Ledger local sincronizado
- Autonomia operacional limitada

### Fase 3 — Maturidade
- Autonomia total (dentro das invariantes)
- Pode gerar sub-clones
- Participa da rede de evidências

## Prateleiras (Shelves)

| Shelf | Conteúdo | Autonomia |
|-------|----------|-----------|
| P0 | Core (invariantes) | Nenhuma |
| P1 | Configuração base | Baixa |
| P2 | Templates ISP | Média |
| P3 | Dados locais | Alta |
| P4 | Integrações | Média |
| P5 | Customizações | Alta |
| P6 | Extensions | Alta |
| P7 | Experimental | Total |

## Deploy de Clone

```bash
# 1. Preparar ambiente
./clone-init.sh --name "clone-name" --phase 1

# 2. Configurar invariantes (copiadas do central)
./clone-config.sh --invariants /opt/windi/constitutional/

# 3. Sincronizar ledger
./clone-sync.sh --source central --target local

# 4. Ativar
./clone-activate.sh
```

## Invariante Principal

> Todo Clone opera sob I9.
> Autonomia é liberdade DENTRO dos limites, não ALÉM deles.
