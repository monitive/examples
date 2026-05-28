# Python Quickstart

Run the full monitor lifecycle — create, list, fetch state, test, delete — using the `requests` library.

## Prerequisites

- Python 3.8 or later (`python --version`)
- An [UptimeMonitoring API key](https://uptimemonitoring.com/settings/api-keys) (`umk_live_…` or `umk_test_…`)

## Install dependencies

```sh
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

## How to run

```sh
export UPTIMEMONITORING_API_KEY=umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
python quickstart.py
```

## What it does

1. **Create** a monitor named `examples-repo-smoke-test-<timestamp>` targeting `https://example.com/?um_examples_run=<timestamp>` — the unique URL avoids collisions.
2. **List** all monitors and print the count.
3. **Fetch state** for the newly created monitor.
4. **Run a test** and print the verdict.
5. **Delete** the monitor — the `finally` block ensures cleanup even if a step raises.

Non-2xx responses raise `requests.HTTPError` with the status and error body printed first. `Retry-After` is surfaced on 429/503.

## Expected output

```
Creating monitor...
  Created: id=42
Listing monitors...
  Found 3 monitor(s)
Fetching monitor state...
  State: unknown
Running test...
  Test result: up
Deleting monitor...
  Deleted.
Done — account left clean.
```

## Next steps

- [cURL quickstart](../curl/README.md)
- [Node.js quickstart](../node/README.md)
- [Webhooks](../webhooks/README.md)
