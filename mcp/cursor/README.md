# MCP — Cursor

Connect Monitive to Cursor and manage your monitors with natural language.

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
    "monitive": {
      "url": "https://api.monitive.com/mcp",
      "headers": {
        "Authorization": "Bearer mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      }
    }
  }
}
```

Replace `mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` with your API key from
[my.monitive.com/keys](https://my.monitive.com/keys).

## Verify

In Cursor, open the MCP panel (Cursor Settings → MCP) and confirm `monitive` shows a green dot.

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
| 401 error | Verify the key value starts with `mk_live_` (or `umk_live_` for a key created before 17 November 2026) |
| Wrong endpoint | The URL must be `api.monitive.com/mcp`, not `mcp.monitive.com` |

## Next steps

- [MCP for Claude Code](../claude-code/README.md)
- [REST API quickstart](../../curl/README.md)
