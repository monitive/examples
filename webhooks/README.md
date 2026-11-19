# Webhooks

Receive an HTTP POST to any URL when a monitor changes state (down, up, or flapping).

## How webhooks work

Each monitor has a single webhook slot. `PUT /monitors/{id}/webhook` sets (or replaces) the URL.
Monitive sends a `POST` to your URL when the monitor fires, with a JSON body and an
`X-UptimeMonitoring-Signature` header for HMAC-SHA256 verification.

The response to the `PUT` includes a `secret` (`whs_live_…`) that you store and use to verify
incoming deliveries. **Store it securely — treat it like a password.**

## Recipe: send monitor alerts to Slack

### 1. Create a Slack incoming webhook

Go to [api.slack.com/apps](https://api.slack.com/apps), create an app, enable Incoming Webhooks,
and copy the webhook URL (`https://hooks.slack.com/services/…`).

### 2. Set the webhook on your monitor

```sh
export MONITIVE_API_KEY=mk_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
chmod +x set-webhook.sh

# Pass your monitor ID as an argument (defaults to 123):
./set-webhook.sh 42
```

Or run the `curl` command directly:

```sh
curl -X PUT https://api.monitive.com/api/v1/monitors/42/webhook \
  -H "Authorization: Bearer $MONITIVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url":"https://hooks.slack.com/services/T00000000/B00000000/xxxxxxxxxxxxxxxxxxxxxxxxxxxx"}'
```

The response includes the HMAC signing secret:

```json
{
  "secret": "whs_live_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

Save this secret. Monitive signs every delivery with it.

### 3. Verify deliveries (recommended)

Compute HMAC-SHA256 over the **raw request body bytes** using the secret, then compare with
`X-UptimeMonitoring-Signature` using a **constant-time** comparison (to avoid timing attacks).

See [monitive.com/docs/webhooks](https://monitive.com/docs/webhooks/) for a
verification example.

## Notes

- Each monitor has **one** webhook slot. A second `PUT` replaces the previous URL and rotates the secret.
- To remove a webhook, `DELETE /monitors/{id}/webhook`.
- Deliveries are retried with exponential back-off on non-2xx responses.

## Next steps

- [GitHub Actions health gate](../github-actions/README.md)
- [REST API quickstart](../curl/README.md)
