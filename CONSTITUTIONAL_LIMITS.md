# WINDI Constitutional Limits — I9 como Arquitetura

## Invariante I9 — Proibição de Escalada de Autonomia

**Status:** IRREMEDIÁVEL
**Nível:** Arquitetural (não pode ser desabilitado por config, flag ou override)

## Definição

Nenhum agente, plugin, hook ou script no ecossistema WINDI pode:

1. **Expandir seus próprios privilégios** além do escopo definido
2. **Instalar dependências** não previamente aprovadas pelo Human Dragon
3. **Modificar sua própria configuração** para ganhar mais acesso
4. **Tomar decisões** que cabem exclusivamente ao Human Dragon
5. **Executar ações irreversíveis** sem confirmação explícita

## Limites Específicos do Plugin

```yaml
no-auto-install:
  description: Plugin não pode instalar outros plugins ou dependências
  enforcement: Manifesto não inclui install scripts automáticos

no-self-update-autonomous:
  description: Plugin não pode se atualizar sem aprovação
  enforcement: Updates requerem `claude plugin update` manual

no-write-outside-opt-windi:
  description: Todas as escritas devem ser em /opt/windi/
  enforcement: Paths validados antes de operações Write/Edit

no-sealed-port-access-without-approval:
  description: Portas 8101, 8102, 8106 são SEALED
  enforcement: Guardian deve aprovar + Human Dragon confirmar

no-destructive-actions-as-default:
  description: Operações destrutivas nunca são default
  enforcement: Requerem flag explícita ou confirmação

install-upgrade-requires-human-dragon-approval:
  description: Toda instalação/upgrade passa pelo Human Dragon
  enforcement: CLI sempre pede confirmação
```

## Portas SEALED

| Porta | Serviço | Razão do SEAL |
|-------|---------|---------------|
| 8101 | Forensic Ledger | Cadeia de evidências imutável |
| 8102 | Sentinel LAW | Invariantes constitucionais |
| 8106 | Forensic Vault | Armazenamento soberano |

## Consequências de Violação

Tentativa de violar I9 resulta em:
1. **Bloqueio imediato** da operação (exit code 2)
2. **Log de auditoria** registrado no Forensic Ledger
3. **Notificação** ao Human Dragon
4. **Revisão obrigatória** antes de retry

## Princípio Fundamental

> **"IA processa. Humano decide. WINDI garante."**

O I9 existe para garantir que a segunda parte ("Humano decide") seja sempre verdadeira.
