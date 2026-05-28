# MCP — Claude Code

Connect UptimeMonitoring to Claude Code and manage your monitors with natural language.

## Connect

```sh
claude mcp add --transport http uptimemonitoring https://api.uptimemonitoring.com/mcp \
  --header "Authorization: Bearer umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

Replace `umk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` with your API key from
[uptimemonitoring.com/settings/api-keys](https://uptimemonitoring.com/settings/api-keys).

## Verify

After adding, confirm the server is reachable:

```
/mcp
```

You should see `uptimemonitoring` listed with a green status.

## OAuth alternative

If you prefer not to embed your API key, UptimeMonitoring MCP supports OAuth. Open
`https://api.uptimemonitoring.com/mcp` in your browser to start the authorization flow,
then re-run the `claude mcp add` command without the `--header` flag.

## Usage

Once connected, talk to Claude naturally:

```
List my monitors
```

```
What is the current status of monitor 123?
```

```
Create an HTTP monitor for https://example.com named "My Site"
```

```
Run a test on monitor 123
```

Claude will call the MCP tools and return the results inline.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `uptimemonitoring` not listed in `/mcp` | Check the endpoint is `api.uptimemonitoring.com/mcp` (not `mcp.uptimemonitoring.com`) |
| 401 Unauthorized | Verify the key starts with `umk_live_` or `umk_test_` and is not expired |
| Tools not available | Restart Claude Code after adding the server |

## Next steps

- [MCP for Cursor](../cursor/README.md)
- [REST API quickstart](../../curl/README.md)
