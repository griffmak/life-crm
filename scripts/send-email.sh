#!/usr/bin/env bash
set -euo pipefail

RESEND_API_KEY="${RESEND_API_KEY:?RESEND_API_KEY not set}"
TO="${1:?Recipient email required}"
SUBJECT="${2:?Subject required}"
HTML="${3:?HTML body required}"

curl -sf -X POST \
  -H "Authorization: Bearer ${RESEND_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"from\": \"Life CRM <onboarding@resend.dev>\",
    \"to\": [\"${TO}\"],
    \"subject\": \"${SUBJECT}\",
    \"html\": \"${HTML}\"
  }" \
  "https://api.resend.com/emails"
