---
name: Asana MCP setup and troubleshooting
description: How the Asana MCP is configured and how to fix it when auth breaks
type: reference
---

## Setup

Asana MCP uses the official remote server at `https://mcp.asana.com/v2/mcp` via OAuth.

Config is stored in `~/.claude.json` under `projects["/Users/braxtengarcia"].mcpServers.asana`:

```json
{
  "type": "http",
  "url": "https://mcp.asana.com/v2/mcp",
  "oauth": {
    "clientId": "1213836286741692",
    "clientSecret": "653f2fa05f6e4ea562706bfd7cc03724",
    "callbackPort": 10000
  }
}
```

Redirect URI registered in Asana app: `http://localhost:10000/callback`

## When it breaks (token expired)

1. Run `/mcp` in Claude Code and click to authenticate Asana
2. Browser will open — approve access
3. Browser will show "Authentication Successful" — return to Claude Code
4. If Claude Code gets stuck on "Completing authentication in browser...", try **Check connection**
5. If still broken, remove and re-add:

```bash
claude mcp remove asana
claude mcp add asana https://mcp.asana.com/v2/mcp --transport http --client-id 1213836286741692 --client-secret --callback-port 10000
```

Enter `653f2fa05f6e4ea562706bfd7cc03724` when prompted for the secret.

Then restart Claude Code and re-authenticate via `/mcp`.

## Notes
- The `clientSecret` field must be present in `~/.claude.json` for token exchange to work
- Claude Code may overwrite the file on quit — verify with `claude mcp get asana` that "client_secret configured" appears
- The Asana OAuth app is registered at app.asana.com/0/my-apps (client ID: 1213836286741692)
