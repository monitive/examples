# cURL Quickstart

Run the full monitor lifecycle — create, list, fetch state, test, delete — from the command line.

## Prerequisites

- `curl` 7.76 or later (`curl --version`)
- `jq` (`jq --version`)
- A [Monitive API key](https://my.monitive.com/keys) (`mk_live_…`)

## How to run

```sh
export MONITIVE_API_KEY=mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
chmod +x quickstart.sh
./quickstart.sh
```

## What it does

1. **Create** a monitor named `examples-repo-smoke-test-<timestamp>` targeting `https://example.com/?um_examples_run=<timestamp>` — the unique URL avoids collisions with any existing monitor.
2. **List** all monitors and print the count.
3. **Fetch state** for the newly created monitor.
4. **Run a test** (`POST /monitors/{id}/test`) and print the verdict.
5. **Delete** the monitor — the trap at the top ensures cleanup even if a step fails.

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

State is `unknown` immediately after creation (no check has run yet); the `/test` endpoint triggers an on-demand check and returns the verdict.

## Next steps

- [Node.js quickstart](../node/README.md)
- [Python quickstart](../python/README.md)
- [Webhooks](../webhooks/README.md) — get notified when a monitor goes down
