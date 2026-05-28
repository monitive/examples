import os
import sys
import time

import requests

BASE = "https://api.uptimemonitoring.com/api/v1"
KEY = os.environ.get("UPTIMEMONITORING_API_KEY")

if not KEY:
    print("UPTIMEMONITORING_API_KEY is not set", file=sys.stderr)
    sys.exit(1)

HEADERS = {"Authorization": f"Bearer {KEY}"}
TIMESTAMP = int(time.time())
MONITOR_URL = f"https://example.com/?um_examples_run={TIMESTAMP}"
MONITOR_NAME = f"examples-repo-smoke-test-{TIMESTAMP}"
monitor_id = None


def req(method, path, **kwargs):
    url = f"{BASE}{path}"
    response = requests.request(method, url, headers=HEADERS, **kwargs)
    if not response.ok:
        retry_after = response.headers.get("Retry-After")
        hint = f" (Retry-After: {retry_after}s)" if retry_after else ""
        print(f"HTTP {response.status_code}{hint}: {response.text}", file=sys.stderr)
        response.raise_for_status()
    return response.json() if response.content else None


try:
    # 1. Create
    print("Creating monitor...")
    created = req("POST", "/monitors", json={"name": MONITOR_NAME, "url": MONITOR_URL, "type": "http"})
    monitor_id = created["monitor"]["id"]
    print(f"  Created: id={monitor_id}")

    # 2. List
    print("Listing monitors...")
    monitors = req("GET", "/monitors")
    print(f"  Found {len(monitors)} monitor(s)")

    # 3. Get state
    print("Fetching monitor state...")
    state_data = req("GET", f"/monitors/{monitor_id}")
    raw_state = state_data.get("state", "unknown")
    status = raw_state.get("status", "unknown") if isinstance(raw_state, dict) else raw_state
    print(f"  State: {status}")

    # 4. Run test
    print("Running test...")
    test_result = req("POST", f"/monitors/{monitor_id}/test")
    raw_test = test_result.get("state", "unknown") if test_result else "unknown"
    test_state = raw_test.get("status", "unknown") if isinstance(raw_test, dict) else raw_test
    print(f"  Test result: {test_state}")

finally:
    if monitor_id:
        print("Deleting monitor...")
        try:
            req("DELETE", f"/monitors/{monitor_id}")
            print("  Deleted.")
        except Exception as exc:
            print(f"  Warning: cleanup failed — delete monitor {monitor_id} manually: {exc}", file=sys.stderr)

print("Done — account left clean.")
