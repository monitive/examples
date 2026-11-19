# MCP — Claude Code

Connect Monitive to Claude Code and manage your monitors with natural language.

## Connect

```sh
claude mcp add --transport http monitive https://api.monitive.com/mcp \
  --header "Authorization: Bearer mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

Replace `mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` with your API key from
[my.monitive.com/keys](https://my.monitive.com/keys).

## Verify

After adding, confirm the server is reachable:

```
/mcp
```

You should see `monitive` listed with a green status.

## OAuth alternative

If you prefer not to embed your API key, Monitive MCP supports OAuth. Open
`https://api.monitive.com/mcp` in your browser to start the authorization flow,
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
| `monitive` not listed in `/mcp` | Check the endpoint is `api.monitive.com/mcp` (not `mcp.monitive.com`) |
| 401 Unauthorized | Verify the key starts with `mk_live_` (or `umk_live_` for a key created before 17 November 2026) and is not expired |
| Tools not available | Restart Claude Code after adding the server |

## Next steps

- [MCP for Cursor](../cursor/README.md)
- [REST API quickstart](../../curl/README.md)
