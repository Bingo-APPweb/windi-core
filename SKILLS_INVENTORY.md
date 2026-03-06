# WINDI Skills Inventory — Canonical Classification
# Para: windi-core CCode Plugin (Modalidade A)
# Decisão: WINDI Decision Record — Plugin Modalities (ratificada 2026-03-06)
# Princípio: WINDI = fonte soberana. CCode = canal de execução.

---

## Resumo Executivo

| Categoria        | Skills | Status        |
|------------------|--------|---------------|
| Tier 1 — Core    | 4      | ✅ Entram agora |
| Tier 2 — Domain  | 4      | ✅ Entram agora |
| Tier 3 — Ops     | 2      | ⏳ Próxima iteração |
| **Total WINDI**  | **10** | 8 na v1.0 |

---

## TIER 1 — CORE INFRASTRUCTURE
*Skills que o Gêmeo usa em TODA sessão no Strato. Entram no windi-core v1.0.*

### windi-location-matrix (147L)
- **Função:** GPS instantâneo da infraestrutura — portas, paths, nginx, serviços
- **Maturidade:** Alta. Estável desde ONE TREE (Mar 1). Sem dependências externas.
- **Plugin slot:** `skills/windi-location-matrix/`
- **Agente destino:** Guardian (READ FIRST em qualquer operação no Strato)
- **Decisão:** ✅ TIER 1 — obrigatório no core

### windi-infra (470L — maior skill do ecossistema)
- **Função:** Gerenciamento nginx, systemd, portas, SSL, deploy, smoke test
- **Maturidade:** Alta. 470L com tabelas, templates, checklists. A bíblia do servidor.
- **Plugin slot:** `skills/windi-infra/`
- **Agente destino:** Architect (operações estruturais no Strato)
- **Decisão:** ✅ TIER 1 — obrigatório no core

### windi-terminal-code (184L)
- **Função:** Referência completa do próprio CCode CLI — o Gêmeo conhecendo a si mesmo
- **Maturidade:** Alta. Documenta slash commands, flags, atalhos, integração Strato.
- **Plugin slot:** `skills/windi-terminal-code/`
- **Agente destino:** Todos (bootstrapping de qualquer sessão CCode)
- **Decisão:** ✅ TIER 1 — obrigatório no core. Irônico e necessário.

### windi-agent-palette (185L)
- **Função:** Deploy, atualização e manutenção da Palette frontend (:8108)
- **Maturidade:** Alta. Cobre temas KLAR/NOIR, SealBadge, GovPanel, tiles.
- **Plugin slot:** `skills/windi-agent-palette/`
- **Agente destino:** Architect (frontend operations)
- **Decisão:** ✅ TIER 1 — core do frontend atual

---

## TIER 2 — DOMAIN KNOWLEDGE
*Skills de domínio específico. Entram no windi-core v1.0 como módulos especializados.*

### windi-memory-loop (430L)
- **Função:** Motor de inteligência fluídica — osmose, blocos de sabedoria, destilação
- **Maturidade:** Alta. 430L, arquitetura complexa com ciclos temporais.
- **Plugin slot:** `skills/windi-memory-loop/`
- **Agente destino:** Witness (memória institucional)
- **Decisão:** ✅ TIER 2 — domínio crítico, entra na v1.0

### windi-isp-factory (90L + refs + scripts + assets)
- **Função:** Criar/gerir ISPs — perfis institucionais de documento (19 profiles)
- **Maturidade:** Alta. Único skill com scripts/ e assets/ — o mais completo estruturalmente.
- **Plugin slot:** `skills/windi-isp-factory/` (com bundled resources)
- **Agente destino:** Architect (document governance)
- **Decisão:** ✅ TIER 2 — entra na v1.0, preservando refs/scripts/assets

### windi-clone (238L)
- **Função:** Deploy e gestão de WINDI Clone instances — nós autônomos constitucionais
- **Maturidade:** Média-Alta. 238L, cobre fases 1→2→3, prateleiras P0-P7.
- **Plugin slot:** `skills/windi-clone/`
- **Agente destino:** Architect + Guardian (autonomia governada)
- **Decisão:** ✅ TIER 2 — entra na v1.0

### windi-sge-analyzer (67L)
- **Função:** Detecção de riscos semânticos em documentos — 6 camadas, R0-R5
- **Maturidade:** Média. 67L — o mais enxuto. Funcional, pode crescer.
- **Plugin slot:** `skills/windi-sge-analyzer/`
- **Agente destino:** Guardian (risk assessment)
- **Decisão:** ✅ TIER 2 — entra na v1.0

---

## TIER 3 — PRÓXIMA ITERAÇÃO
*Skills válidos mas com menor frequência de uso pelo Gêmeo no Strato day-to-day.*

### windi-certification (282L)
- **Função:** Gateway de onboarding de agentes LLM externos (WAQP, SHP, compliance)
- **Maturidade:** Média. Sistema ainda em maturação, poucos agents certificados hoje.
- **Plugin slot:** `skills/windi-certification/` (v1.1)
- **Decisão:** ⏳ TIER 3 — entra na v1.1 quando certification tiver mais movimento

### windi-a4desk (84L + refs)
- **Função:** Editor A4 Desk BABEL — Tiptap, export, audit trail, login/auth
- **Maturidade:** Média. 84L com references/. O próprio a4desk está sendo substituído pelo Palette.
- **Plugin slot:** `skills/windi-a4desk/` (v1.1)
- **Decisão:** ⏳ TIER 3 — aguardar clareza sobre o futuro do a4desk vs Palette

---

## Metadados

```
Plugin name:    windi-core
Version:        1.0.0
Skills v1.0:    8 (4 TIER 1 + 4 TIER 2)
Skills v1.1:    +2 (certification + a4desk)
Repository:     Ambos — /opt/windi/plugins/windi-core/ + GitHub mirror
Fonte soberana: WINDI (/mnt/skills/user/)
Canal execução: Claude Code (CCode)
Invariant:      I9 (Proibição de Escalada de Autonomia) — IRREMEDIÁVEL
Decisão:        WINDI Decision Record 2026-03-06, ratificada Human Dragon
```
