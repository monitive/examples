# GitHub Actions — Post-Deploy Health Gate

Assert that your Monitive monitor is healthy after every deployment to `main`.

## What it does

After `./deploy.sh` runs, the [`monitive/assert-healthy`](https://github.com/monitive/assert-healthy) action polls your monitor and fails the workflow if it is down, preventing a broken deploy from going undetected.

## Files

```
github-actions/
└── .github/
    └── workflows/
        └── deploy.yml   ← copy this to your repo's .github/workflows/
```

This nested path is intentional: GitHub only runs workflows from the **repository root** `.github/workflows/`. The copy here is documentation only and does not trigger CI on this examples repo.

## Setup

### 1. Create your secrets and variables

In your repository: **Settings → Secrets and variables → Actions**

| Type | Name | Value |
|------|------|-------|
| Secret | `MONITIVE_API_KEY` | Your Monitive API key (`mk_live_…`) |
| Variable | `MONITOR_ID` | Your monitor's numeric ID (find it in the dashboard URL) |

### 2. Copy the workflow

```sh
mkdir -p .github/workflows
cp github-actions/.github/workflows/deploy.yml .github/workflows/
```

### 3. Adapt `./deploy.sh`

Replace the `./deploy.sh` step with your actual deployment command (e.g. `npm run deploy`, `kubectl apply -f k8s/`).

## Action inputs used

| Input | Description |
|-------|-------------|
| `api-key` | Monitive API key with read access |
| `monitor-ids` | Comma- or newline-separated monitor IDs to assert |

See the [assert-healthy action](https://github.com/monitive/assert-healthy) for all available inputs (`strict-flapping`, `unknown-retry-delay-seconds`, etc.).

## Next steps

- [Webhooks](../webhooks/README.md) — push notifications when a monitor changes state
- [cURL quickstart](../curl/README.md) — manage monitors via the REST API
