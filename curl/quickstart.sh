#!/usr/bin/env bash
# Prerequisites: curl 7.76+, jq
set -euo pipefail

BASE="https://api.uptimemonitoring.com/api/v1"
KEY="${UPTIMEMONITORING_API_KEY:?UPTIMEMONITORING_API_KEY is not set}"
TIMESTAMP=$(date +%s)
MONITOR_URL="https://example.com/?um_examples_run=${TIMESTAMP}"
MONITOR_NAME="examples-repo-smoke-test-${TIMESTAMP}"
MONITOR_ID=""

cleanup() {
  if [[ -n "$MONITOR_ID" ]]; then
    echo "Cleaning up: deleting monitor $MONITOR_ID"
    curl -s -o /dev/null -X DELETE "$BASE/monitors/$MONITOR_ID" \
      -H "Authorization: Bearer $KEY" || echo "Warning: cleanup delete failed — delete monitor $MONITOR_ID manually"
  fi
}
trap cleanup EXIT

# ── 1. Create monitor ────────────────────────────────────────────────────────
echo "Creating monitor..."
CREATE=$(curl -s --fail-with-body -X POST "$BASE/monitors" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$MONITOR_NAME\",\"url\":\"$MONITOR_URL\",\"type\":\"http\"}")
MONITOR_ID=$(echo "$CREATE" | jq -r '.monitor.id')
echo "  Created: id=$MONITOR_ID"

# ── 2. List monitors ─────────────────────────────────────────────────────────
echo "Listing monitors..."
LIST=$(curl -s --fail-with-body "$BASE/monitors" \
  -H "Authorization: Bearer $KEY")
COUNT=$(echo "$LIST" | jq 'length')
echo "  Found $COUNT monitor(s)"

# ── 3. Fetch monitor state ───────────────────────────────────────────────────
echo "Fetching monitor state..."
STATE=$(curl -s --fail-with-body "$BASE/monitors/$MONITOR_ID" \
  -H "Authorization: Bearer $KEY")
STATUS=$(echo "$STATE" | jq -r '.state.status // .state // "unknown"')
echo "  State: $STATUS"

# ── 4. Run test ──────────────────────────────────────────────────────────────
echo "Running test..."
TEST=$(curl -s --fail-with-body -X POST "$BASE/monitors/$MONITOR_ID/test" \
  -H "Authorization: Bearer $KEY")
TEST_STATE=$(echo "$TEST" | jq -r '.state.status // .state // "unknown"')
echo "  Test result: $TEST_STATE"

# ── 5. Delete monitor ────────────────────────────────────────────────────────
echo "Deleting monitor..."
curl -s --fail-with-body -o /dev/null -X DELETE "$BASE/monitors/$MONITOR_ID" \
  -H "Authorization: Bearer $KEY"
MONITOR_ID=""  # prevent double-delete in trap
echo "  Deleted."

echo "Done — account left clean."
