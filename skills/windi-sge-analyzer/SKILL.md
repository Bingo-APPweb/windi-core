---
name: windi-sge-analyzer
description: SGE risk detection — 6 camadas semânticas, R0-R5
tier: 2
agent: guardian
---

# WINDI SGE Analyzer

Semantic Governance Engine — Detecção de riscos em documentos.

## Níveis de Risco

| Nível | Nome | Descrição | Ação |
|-------|------|-----------|------|
| R0 | Trivial | Sem risco identificado | Auto-approve |
| R1 | Low | Risco mínimo | Auto-approve com log |
| R2 | Medium | Risco moderado | Review opcional |
| R3 | High | Risco significativo | Review obrigatório |
| R4 | Critical | Risco crítico | Human Dragon only |
| R5 | Blocked | Não processável | Rejeição automática |

## 6 Camadas de Análise

### L1 — Structural
- Formato do documento
- Seções obrigatórias
- Metadados

### L2 — Lexical
- Vocabulário sensível
- Termos legais
- Identificadores

### L3 — Semantic
- Significado contextual
- Intenção implícita
- Contradições

### L4 — Regulatory
- Compliance GDPR/DSGVO
- Requisitos legais
- Jurisdição

### L5 — Institutional
- Políticas internas
- Histórico de decisões
- Precedentes

### L6 — Constitutional
- Invariantes WINDI
- I9 compliance
- Limites de autonomia

## Uso

```python
from sge_analyzer import analyze_document

result = analyze_document(content, doc_type="communique")
print(f"Risk Level: {result.risk_level}")  # R0-R5
print(f"Flags: {result.flags}")
print(f"Recommendation: {result.recommendation}")
```

## Escalation Triggers

- Menção a valores > €10.000
- Dados pessoais identificados
- Termos jurídicos vinculantes
- Cross-border (PT/DE)
- Referência a invariantes
