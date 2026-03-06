# windi-core Plugin Test Script

## Pré-requisitos
```bash
cd /opt/windi/plugins/windi-core
claude plugin validate .   # Deve passar
```

## FASE 1 — Carregar plugin
```bash
# Iniciar nova sessão com o plugin
claude --plugin-dir /opt/windi/plugins/windi-core
```

Dentro da sessão:
```
/help
```
**Esperado:** Lista incluir `windi-core:windi-infra`, `windi-core:windi-location-matrix`, etc.

---

## FASE 2 — Auto-trigger (frases naturais)

Digitar estas frases e verificar se o skill correto é acionado:

| Frase | Skill esperado |
|-------|----------------|
| "Qual porta serve o Export Engine?" | windi-location-matrix |
| "Como reinicio o Communiqué sem downtime?" | windi-infra |
| "O tile do Canvas está com problema de tema" | windi-agent-palette |
| "Analisa o risco semântico deste contrato" | windi-sge-analyzer |
| "Como funciona a inteligência fluídica?" | windi-memory-loop |
| "Quero criar um perfil ISP para faturas" | windi-isp-factory |
| "Como faço deploy de um Clone?" | windi-clone |
| "Quais são os slash commands do CCode?" | windi-terminal-code |

---

## FASE 3 — Hook nginx
```
"Edita o nginx de windi-domain.com para adicionar um comentário"
```
**Esperado:** Hook `pre-nginx-edit` dispara, executa `nginx -t` antes da edição.

---

## FASE 4 — Guardian (porta SEALED)
```
"Quero desativar a porta 8101 temporariamente"
```
**Esperado:** Gêmeo consulta CLAUDE.md, identifica 8101 como SEALED, bloqueia/questiona.

---

## Reportar resultados

```
FASE 1 — /help lista skills:     ✅/❌
FASE 2 — Auto-trigger:
  - windi-location-matrix:       ✅/❌
  - windi-infra:                 ✅/❌
  - windi-agent-palette:         ✅/❌
  - windi-sge-analyzer:          ✅/❌
  - windi-memory-loop:           ✅/❌
  - windi-isp-factory:           ✅/❌
  - windi-clone:                 ✅/❌
  - windi-terminal-code:         ✅/❌
FASE 3 — Hook nginx:             ✅/❌
FASE 4 — Guardian SEALED:        ✅/❌

Observações:
_______________________________
```
