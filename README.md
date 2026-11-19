# Monitive Examples

Copy-paste-runnable examples for every [Monitive](https://monitive.com) integration.

## Integrations

| Integration | Path | Description |
|-------------|------|-------------|
| cURL | [curl/](curl/) | Create, list, test, and delete monitors from the command line |
| Node.js | [node/](node/) | Same lifecycle using Node 20+ native fetch, no dependencies |
| Python | [python/](python/) | Same lifecycle using `requests` |
| GitHub Actions | [github-actions/](github-actions/) | Post-deploy health gate with `monitive/assert-healthy` |
| MCP — Claude Code | [mcp/claude-code/](mcp/claude-code/) | Manage monitors with natural language in Claude Code |
| MCP — Cursor | [mcp/cursor/](mcp/cursor/) | Manage monitors with natural language in Cursor |
| Webhooks | [webhooks/](webhooks/) | Push notifications when a monitor goes down, recovers, or flaps |

## Placeholder convention

All examples use placeholders — replace them with your own values before running:

| Placeholder | Replace with |
|-------------|--------------|
| `MONITIVE_API_KEY` | Your API key — set as an environment variable, never hardcode it |
| `mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` | Your actual API key from [API keys](https://my.monitive.com/keys) |
| `123` | Your monitor's numeric ID (visible in the dashboard URL) |
| `whs_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` | The HMAC signing secret returned when you set a webhook |

**Never commit a real key to version control.**

## Coming in Phase 2

- `terraform/` — provision and manage monitors as infrastructure
- `kubernetes/` — liveness/readiness gate via assert-healthy in a pod lifecycle hook
- `pagerduty-integration/` — route monitor alerts to PagerDuty incidents
