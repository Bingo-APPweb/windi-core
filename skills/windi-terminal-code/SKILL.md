---
name: windi-terminal-code
description: Referência CCode CLI — self-knowledge do Gêmeo
tier: 1
agent: all
---

# Claude Code CLI Reference

O Gêmeo conhecendo a si mesmo. Referência completa do CCode.

## Slash Commands Principais

| Comando | Função |
|---------|--------|
| `/help` | Ajuda geral |
| `/clear` | Limpar contexto |
| `/compact` | Compactar histórico |
| `/config` | Configurações |
| `/hooks` | Gerenciar hooks |
| `/permissions` | Ver permissões |
| `/status` | Status da sessão |
| `/tasks` | Ver tarefas background |

## Flags Úteis

```bash
# Iniciar com plugin local
claude --plugin-dir /opt/windi/plugins/windi-core

# Modo verbose
claude --verbose

# Continuar sessão
claude --continue

# Modelo específico
claude --model opus
```

## Atalhos de Teclado

| Atalho | Ação |
|--------|------|
| `Ctrl+C` | Cancelar operação |
| `Ctrl+D` | Sair |
| `Tab` | Autocomplete |
| `↑/↓` | Histórico |

## Integração Strato

```bash
# Conectar ao Strato
ssh windi@87.106.29.233

# Iniciar CCode com plugin WINDI
cd /opt/windi && claude --plugin-dir ./plugins/windi-core

# Verificar plugin carregado
/status
```

## Skills vs Plugins

- **Skills**: Markdown simples em `~/.claude/skills/`
- **Plugins**: Pacotes completos com manifesto

## Hooks

Hooks executam em eventos específicos:
- `PreToolUse` — antes de usar ferramenta
- `PostToolUse` — depois de usar ferramenta
- `SessionStart` — início de sessão
