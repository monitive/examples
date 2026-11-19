#!/usr/bin/env bash
# Sets the webhook URL for a monitor and prints the HMAC signing secret.
# Prerequisites: curl, jq
set -euo pipefail

BASE="https://api.monitive.com/api/v1"
KEY="${MONITIVE_API_KEY:?MONITIVE_API_KEY is not set}"

# Replace 123 with your actual monitor ID (find it in the dashboard URL).
MONITOR_ID="${1:-123}"

# Replace with your Slack incoming webhook URL.
WEBHOOK_URL="https://hooks.slack.com/services/T00000000/B00000000/xxxxxxxxxxxxxxxxxxxxxxxxxxxx"

echo "Setting webhook for monitor $MONITOR_ID..."
RESPONSE=$(curl -s --fail-with-body \
  -X PUT "$BASE/monitors/$MONITOR_ID/webhook" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d "{\"url\":\"$WEBHOOK_URL\"}")

SECRET=$(echo "$RESPONSE" | jq -r '.secret // empty')

echo "Webhook configured."
echo ""
echo "  Monitor ID : $MONITOR_ID"
echo "  Webhook URL: $WEBHOOK_URL"
echo ""
echo "  Signing secret: $SECRET"
echo ""
echo "Store the signing secret (whs_live_…) somewhere safe — you'll need it to"
echo "verify the HMAC-SHA256 signature on incoming deliveries."
echo "Monitive sends the signature in the X-UptimeMonitoring-Signature header."
