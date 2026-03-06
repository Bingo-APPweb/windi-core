#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# WINDI Hook: pre-nginx-edit
# Executa nginx -t antes de qualquer edição em sites-enabled/
# Se falhar, bloqueia a operação (exit 2)
# ═══════════════════════════════════════════════════════════════════

set -e

# Lê o input do hook (JSON com file_path)
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Só executa se for arquivo nginx
if [[ "$FILE_PATH" == */nginx/* ]] || [[ "$FILE_PATH" == */sites-enabled/* ]] || [[ "$FILE_PATH" == */sites-available/* ]]; then
    echo "🔍 [pre-nginx-edit] Detectado arquivo nginx: $FILE_PATH"

    # Testa configuração atual antes de permitir edição
    if ! nginx -t 2>&1; then
        echo "❌ [pre-nginx-edit] nginx -t FALHOU antes da edição. Verifique a configuração atual."
        echo "   Bloqueando operação para evitar estado inconsistente."
        exit 2  # Exit code 2 = bloqueia a operação
    fi

    echo "✅ [pre-nginx-edit] nginx -t OK. Edição permitida."
fi

exit 0
