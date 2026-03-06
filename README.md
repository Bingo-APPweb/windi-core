# windi-core — WINDI CCode Plugin v1.0.0

> **Ferramentas do construtor primeiro. Extensões do produto depois.**
> *— WINDI Decision Record, 2026-03-06*

## O que é

`windi-core` é o plugin Claude Code do ecossistema WINDI. Ele empacota os skills, agentes e hooks que o Gêmeo usa para construir e manter o WINDI no Strato — tornando esse conhecimento portátil, versionado e instalável com um comando.

**Importante:** O WINDI é a fonte soberana. O CCode é o canal de execução.

## Instalar

```bash
# A partir do repositório local (soberano)
claude plugin add /opt/windi/plugins/windi-core

# A partir do GitHub (mirror)
claude plugin add github:Bingo-APPweb/windi-core
```

## Skills incluídos (v1.0)

| Skill | Tier | Função |
|-------|------|--------|
| `windi-location-matrix` | 1 | GPS da infraestrutura |
| `windi-infra` | 1 | Operações Strato |
| `windi-terminal-code` | 1 | Self-knowledge CCode |
| `windi-agent-palette` | 1 | Palette frontend |
| `windi-memory-loop` | 2 | Inteligência fluídica |
| `windi-isp-factory` | 2 | Perfis institucionais |
| `windi-clone` | 2 | Clone instances |
| `windi-sge-analyzer` | 2 | SGE risk detection |

## Agentes incluídos

- **Guardian** — governança, invariantes, risco
- **Architect** — design técnico, coerência
- **Witness** — evidência, documentação, memória

## Hooks incluídos

- `pre-nginx-edit` — executa `nginx -t` antes de qualquer edição em sites-enabled/

## Limites Constitucionais

Este plugin opera sob **Invariante I9 (IRREMEDIÁVEL)**:
- Sem auto-instalação
- Sem self-update autônomo
- Sem escrita fora de `/opt/windi/`
- Portas SEALED (8101, 8102, 8106) requerem aprovação explícita
- Toda instalação/upgrade requer aprovação do Human Dragon

## Estrutura

```
windi-core/
├── .claude-plugin/plugin.json   ← manifesto
├── skills/                      ← 8 skills WINDI
├── agents/                      ← Guardian, Architect, Witness
├── hooks/                       ← pre-nginx-edit
├── CLAUDE.md                    ← contexto para o Gêmeo
├── CONSTITUTIONAL_LIMITS.md     ← I9 como arquitetura
└── README.md                    ← este arquivo
```

## v1.1 (roadmap)

- `windi-certification` — quando certification tiver mais movimento
- `windi-a4desk` — quando clareza sobre futuro a4desk vs Palette

## Decisão de origem

**WINDI Decision Record — Plugin Modalities**
Status: Ratificada | Data: 2026-03-06 | Human Dragon: aprovado
