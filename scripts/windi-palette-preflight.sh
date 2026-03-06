#!/bin/bash
# ============================================================
# WINDI Palette Pre-Flight Check v1.0
# Executa antes de qualquer deploy de ferramentas no Palette
# Uso: bash windi-palette-preflight.sh
# ============================================================

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

PASS="${GREEN}✅ OK${RESET}"
WARN="${YELLOW}⚠️  WARN${RESET}"
FAIL="${RED}❌ FAIL${RESET}"

LEDGER_CHAIN_WARN=0
WARNINGS=0
FAILURES=0

line() { printf "${CYAN}%-40s${RESET}" "$1"; }
pad()  { printf "%-40s" "$1"; }

header() {
  echo ""
  echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${BOLD}  $1${RESET}"
  echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

result() {
  local label="$1"
  local status="$2"   # OK | WARN | FAIL
  local detail="$3"
  printf "  %-38s" "$label"
  case "$status" in
    OK)   echo -e "$PASS  $detail" ;;
    WARN) echo -e "$WARN  $detail"; ((WARNINGS++)) ;;
    FAIL) echo -e "$FAIL  $detail"; ((FAILURES++)) ;;
  esac
}

check_http() {
  local url="$1"
  local code
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 3 "$url" 2>/dev/null)
  echo "$code"
}

check_json_field() {
  local url="$1"
  local field="$2"
  local val
  val=$(curl -s --max-time 3 "$url" 2>/dev/null | grep -o "\"$field\":[^,}]*" | head -1)
  echo "$val"
}

# ============================================================
echo ""
echo -e "${BOLD}🐉 WINDI PALETTE PRE-FLIGHT${RESET}  $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "   Roda ANTES de qualquer deploy de ferramentas no Palette"

# ============================================================
header "1. CANVAS PIPELINE — Caminho crítico de entrega"

# Export Engine :8103
code=$(check_http "http://localhost:8103/health")
if [ "$code" = "200" ]; then
  result "Export Engine :8103 /health" "OK" "HTTP $code"
else
  result "Export Engine :8103 /health" "FAIL" "HTTP $code — export engine down"
fi

# Communiqué Engine :8105
code=$(check_http "http://localhost:8105/health")
if [ "$code" = "200" ]; then
  result "Communiqué Engine :8105 /health" "OK" "HTTP $code"
else
  result "Communiqué Engine :8105 /health" "FAIL" "HTTP $code — communiqué engine down"
fi

# Export → simula request mínimo
EXPORT_RESP=$(curl -s --max-time 5 -X POST http://localhost:8103/export \
  -H "Content-Type: application/json" \
  -d '{"doc_type":"communique","layers":[],"canvas_meta":{"test":true},"export_format":"pdf"}' \
  2>/dev/null)

if echo "$EXPORT_RESP" | grep -q "hash\|exported\|file\|error"; then
  if echo "$EXPORT_RESP" | grep -q "hash"; then
    result "Export Engine POST /export" "OK" "hash presente na resposta"
  else
    result "Export Engine POST /export" "WARN" "resposta sem hash — verificar schema"
  fi
else
  result "Export Engine POST /export" "WARN" "sem resposta válida — testar manualmente"
fi

# ActionBridge → :8105
AB_CODE=$(check_http "http://localhost:8105/actionbridge/health")
if [ "$AB_CODE" = "200" ] || [ "$AB_CODE" = "404" ]; then
  if [ "$AB_CODE" = "200" ]; then
    result "ActionBridge → :8105" "OK" "endpoint acessível"
  else
    result "ActionBridge → :8105" "WARN" "HTTP 404 — confirmar rota real no communiqué"
  fi
else
  result "ActionBridge → :8105" "WARN" "HTTP $AB_CODE — verificar manualmente"
fi

# ============================================================
header "2. LEDGER & VAULT — Integridade da cadeia"

# Ledger :8101
code=$(check_http "http://localhost:8101/health")
if [ "$code" = "200" ]; then
  result "Forensic Ledger :8101 /health" "OK" "HTTP $code"
else
  result "Forensic Ledger :8101 /health" "FAIL" "HTTP $code — ledger inacessível"
fi

# Verify endpoint
code=$(check_http "http://localhost:8101/api/verify/test")
if [ "$code" = "200" ] || [ "$code" = "404" ]; then
  result "Ledger /api/verify endpoint" "OK" "rota responde"
else
  result "Ledger /api/verify endpoint" "WARN" "HTTP $code"
fi

# chain_ok
CHAIN=$(curl -s --max-time 3 "http://localhost:8101/health" 2>/dev/null | grep -o '"chain_ok":[^,}]*')
if echo "$CHAIN" | grep -q "true"; then
  result "chain_ok" "OK" "cadeia íntegra"
elif echo "$CHAIN" | grep -q "false"; then
  result "chain_ok" "WARN" "chain_ok: false — investigar antes de selar docs novos"
  LEDGER_CHAIN_WARN=1
else
  result "chain_ok" "WARN" "campo não encontrado — verificar schema /health"
fi

# Vault :8106
code=$(check_http "http://localhost:8106/health")
if [ "$code" = "200" ]; then
  result "Forensic Vault :8106 /health" "OK" "HTTP $code"
else
  result "Forensic Vault :8106 /health" "WARN" "HTTP $code"
fi

# ============================================================
header "3. PALETTE ITSELF — Vitrine funcional"

# Palette :8108 local
code=$(check_http "http://localhost:8108/")
if [ "$code" = "200" ]; then
  result "Palette :8108 local" "OK" "HTTP $code"
else
  result "Palette :8108 local" "FAIL" "HTTP $code — servidor da palette down"
fi

# Versão
VERSION=$(curl -s --max-time 3 "http://localhost:8108/" 2>/dev/null | grep -o 'v[0-9]\.[0-9]\.[0-9]-[A-Z]' | head -1)
if [ -n "$VERSION" ]; then
  result "Versão detectada" "OK" "$VERSION"
else
  result "Versão detectada" "WARN" "não encontrada — verificar HTML"
fi

# HTML size
HTML_LINES=$(curl -s --max-time 3 "http://localhost:8108/" 2>/dev/null | wc -l)
if [ "$HTML_LINES" -gt 100 ]; then
  result "Build size" "OK" "${HTML_LINES} linhas"
else
  result "Build size" "WARN" "${HTML_LINES} linhas — build muito pequeno, possível erro"
fi

# Brand leaks
BRAND_COUNT=$(curl -s --max-time 3 "http://localhost:8108/" 2>/dev/null \
  | grep -ic "Claude\|GPT\|Gemini\|OpenAI\|Anthropic")
if [ "$BRAND_COUNT" = "0" ]; then
  result "Brand leaks (Claude/GPT/Gemini)" "OK" "nenhuma ocorrência"
else
  result "Brand leaks (Claude/GPT/Gemini)" "FAIL" "$BRAND_COUNT ocorrências — CRÍTICO para release"
fi

# KLAR/NOIR themes
THEME_COUNT=$(curl -s --max-time 3 "http://localhost:8108/" 2>/dev/null | grep -c "KLAR\|NOIR")
if [ "$THEME_COUNT" -ge 1 ]; then
  result "Temas KLAR/NOIR" "OK" "presentes"
else
  result "Temas KLAR/NOIR" "WARN" "não detectados no HTML"
fi

# windi-domain.com como base URL
DOMAIN_COUNT=$(curl -s --max-time 3 "http://localhost:8108/" 2>/dev/null | grep -c "windi-domain.com")
if [ "$DOMAIN_COUNT" -ge 1 ]; then
  result "API URLs → windi-domain.com" "OK" "$DOMAIN_COUNT referências"
else
  result "API URLs → windi-domain.com" "WARN" "0 referências — verificar se há URLs hardcoded antigas"
fi

# ============================================================
header "4. SERVIÇOS DE SUPORTE"

# Pulse :8109
code=$(check_http "http://localhost:8109/health")
[ "$code" = "200" ] && result "WINDI Pulse :8109" "OK" "" || result "WINDI Pulse :8109" "WARN" "HTTP $code"

# Dragon Chat :8111
code=$(check_http "http://localhost:8111/health")
[ "$code" = "200" ] && result "Dragon Chat :8111" "OK" "" || result "Dragon Chat :8111" "WARN" "HTTP $code"

# Orchestrator :8112
code=$(check_http "http://localhost:8112/health")
[ "$code" = "200" ] && result "Orchestrator :8112" "OK" "" || result "Orchestrator :8112" "WARN" "HTTP $code"

# Guardian :8110
GRD=$(curl -s --max-time 3 "http://localhost:8110/guardian/health" 2>/dev/null)
if echo "$GRD" | grep -qi "green\|ok\|healthy"; then
  result "Guardian :8110" "OK" "GREEN"
else
  result "Guardian :8110" "WARN" "verificar resposta manualmente"
fi

# jmpg export :8113
code=$(check_http "http://localhost:8113/health")
if [ "$code" = "200" ]; then
  result "JMPG Export :8113" "OK" "HTTP $code"
elif [ "$code" = "000" ]; then
  result "JMPG Export :8113" "WARN" "offline — se em uso, formalizar como serviço"
else
  result "JMPG Export :8113" "WARN" "HTTP $code — processo hack ativo"
fi

# ============================================================
header "5. COLOR AUDIT — Design token compliance"

# Grep no filesystem do palette
HARDCODED=$(grep -r "#8B5CF6" /opt/windi/agent-palette/ 2>/dev/null | wc -l)
if [ "$HARDCODED" = "0" ]; then
  result "Hardcoded #8B5CF6 no palette" "OK" "0 ocorrências"
else
  result "Hardcoded #8B5CF6 no palette" "WARN" "$HARDCODED ocorrências — migrar para token"
fi

# Desktop/Canvas
HARDCODED2=$(grep -r "#8B5CF6" /opt/windi/desktop/ 2>/dev/null | wc -l)
if [ "$HARDCODED2" = "0" ]; then
  result "Hardcoded #8B5CF6 no desktop" "OK" "0 ocorrências"
else
  result "Hardcoded #8B5CF6 no desktop" "WARN" "$HARDCODED2 ocorrências"
fi

# ============================================================
header "RESULTADO FINAL"

echo ""
if [ "$FAILURES" = "0" ] && [ "$WARNINGS" = "0" ]; then
  echo -e "  ${GREEN}${BOLD}🟢 SISTEMA LIMPO — Pode implementar ferramentas no Palette${RESET}"
elif [ "$FAILURES" = "0" ]; then
  echo -e "  ${YELLOW}${BOLD}🟡 $WARNINGS WARNING(S) — Revisar antes do deploy final${RESET}"
else
  echo -e "  ${RED}${BOLD}🔴 $FAILURES FAILURE(S) | $WARNINGS WARNING(S) — Bloquear deploy${RESET}"
fi

if [ "$LEDGER_CHAIN_WARN" = "1" ]; then
  echo ""
  echo -e "  ${YELLOW}⚠️  chain_ok: false — documentos novos serão selados mas a cadeia${RESET}"
  echo -e "  ${YELLOW}   precisa de investigação. Não urgente mas registrar.${RESET}"
fi

echo ""
echo -e "  Failures : ${RED}$FAILURES${RESET}"
echo -e "  Warnings : ${YELLOW}$WARNINGS${RESET}"
echo -e "  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  🐉 OM SHANTI"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
