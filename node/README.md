# Node.js Quickstart

Run the full monitor lifecycle — create, list, fetch state, test, delete — using Node's built-in `fetch`.

## Prerequisites

- Node.js 20 or later (`node --version`)
- An [UptimeMonitoring API key](https://uptimemonitoring.com/settings/api-keys) (`umk_live_…` or `umk_test_…`)

No dependencies to install — uses native `fetch` from Node 20+.

## How to run

```sh
export UPTIMEMONITORING_API_KEY=umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
node quickstart.mjs
```

Or via npm:

```sh
export UPTIMEMONITORING_API_KEY=umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
npm start
```

## What it does

1. **Create** a monitor named `examples-repo-smoke-test-<timestamp>` targeting `https://example.com/?um_examples_run=<timestamp>` — the unique URL avoids collisions.
2. **List** all monitors and print the count.
3. **Fetch state** for the newly created monitor.
4. **Run a test** and print the verdict.
5. **Delete** the monitor — the `finally` block ensures cleanup even if a step throws.

Non-2xx responses throw with the HTTP status and error body. `Retry-After` is printed on 429/503.

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

- [Python quickstart](../python/README.md)
- [cURL quickstart](../curl/README.md)
- [Webhooks](../webhooks/README.md)
