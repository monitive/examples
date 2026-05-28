# MCP — Cursor

Connect UptimeMonitoring to Cursor and manage your monitors with natural language.

## Setup

Copy `mcp.json` to `.cursor/mcp.json` in your project (or your home directory for global access):

```sh
mkdir -p .cursor
cp mcp.json .cursor/mcp.json
```

Then open `.cursor/mcp.json` and replace the placeholder key:

```json
{
  "mcpServers": {
    "uptimemonitoring": {
      "url": "https://api.uptimemonitoring.com/mcp",
      "headers": {
        "Authorization": "Bearer umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      }
    }
  }
}
```

Replace `umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` with your API key from
[uptimemonitoring.com/settings/api-keys](https://uptimemonitoring.com/settings/api-keys).

## Verify

In Cursor, open the MCP panel (Cursor Settings → MCP) and confirm `uptimemonitoring` shows a green dot.

## Usage

Chat with the Cursor agent naturally:

```
List my monitors
```

```
What's the status of monitor 123?
```

```
Run a test on monitor 123 and tell me the result
```

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Server not listed | Confirm the file is at `.cursor/mcp.json` and restart Cursor |
| 401 error | Verify the key value starts with `umk_live_` or `umk_test_` |
| Wrong endpoint | The URL must be `api.uptimemonitoring.com/mcp`, not `mcp.uptimemonitoring.com` |

## Next steps

- [MCP for Claude Code](../claude-code/README.md)
- [REST API quickstart](../../curl/README.md)
