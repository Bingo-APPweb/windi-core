---
name: windi-isp-factory
description: ISP profiles — 19 perfis institucionais, templates Jinja2, SGE
tier: 2
agent: architect
---

# WINDI ISP Factory

Criação e gestão de Institutional Style Profiles (ISPs).

## O que é ISP

ISP = Institutional Style Profile
Define como um tipo de documento deve ser:
- Formatado
- Estruturado
- Validado
- Classificado (SGE)

## Profiles Disponíveis (19)

| ID | Nome | Uso |
|----|------|-----|
| ISP-001 | Communiqué | Comunicados oficiais |
| ISP-002 | Bescheid | Decisões administrativas (DE) |
| ISP-003 | Relatório | Reports técnicos |
| ISP-004 | Contrato | Contratos legais |
| ISP-005 | Ata | Atas de reunião |
| ISP-006 | Memo | Memorandos internos |
| ISP-007 | Invoice | Faturas |
| ISP-008 | Legal Filing | Petições jurídicas |
| ... | ... | ... |

## Estrutura de um ISP

```yaml
id: ISP-XXX
name: "Nome do Profile"
language: [PT, DE, EN]
sections:
  - header
  - body
  - footer
  - signatures
validation:
  required_fields: [...]
  max_length: ...
sge:
  baseline_risk: R2
  escalation_triggers: [...]
template: templates/isp-xxx.j2
```

## Uso

```python
from isp_factory import load_profile, render_document

profile = load_profile("ISP-001")
doc = render_document(profile, data={
    "title": "...",
    "body": "...",
    "date": "..."
})
```

## Assets

```
skills/windi-isp-factory/
├── SKILL.md
├── assets/           ← Logos, fontes, etc.
├── references/       ← Documentação legal
└── scripts/          ← Utilitários
```
