# MCP server reference

Last verified: 2026-04-07. Run `claude mcp list` to recheck status.

---

## Connected and working

### asana
- **Type:** HTTP (configured in `settings.json`)
- **URL:** `https://mcp.asana.com/v2/mcp`
- **Auth:** Bearer token in `settings.json` > `mcpServers.asana.headers.Authorization`
- **Note:** Token was also used in a `claude mcp add` invocation with `--client-id 1213836286741692 --callback-port 10000`. If the HTTP token expires, re-run that OAuth flow.

### hubspot (local server)
- **Type:** stdio / npx
- **Command:** `npx -y @hubspot/mcp-server`
- **Auth:** Handled automatically by the HubSpot CLI on first run (OAuth)
- **Note:** Separate from the claude.ai HubSpot marketplace server below. Both are active.

### playwright
- **Type:** stdio / npx
- **Command:** `npx @playwright/mcp@latest`
- **Auth:** None (local browser automation)

### claude.ai Microsoft 365
- **Type:** HTTP (claude.ai marketplace)
- **URL:** `https://microsoft365.mcp.claude.com/mcp`
- **Auth:** OAuth via Microsoft account (re-authenticate with `mcp__claude_ai_Microsoft_365__authenticate` if it drops)
- **Tools available:** `outlook_email_search`, `outlook_calendar_search`, `sharepoint_search`, `sharepoint_folder_search`, `read_resource`, `chat_message_search`, `find_meeting_availability`

### claude.ai HubSpot
- **Type:** HTTP (claude.ai marketplace)
- **URL:** `https://mcp.hubspot.com/anthropic`
- **Auth:** OAuth via HubSpot account
- **Tools available:** `get_crm_objects`, `manage_crm_objects`, `search_crm_objects`, `get_properties`, `get_user_details`, `search_owners`, `search_properties`, `submit_feedback`

### claude.ai Microsoft Learn
- **Type:** HTTP (claude.ai marketplace)
- **URL:** `https://learn.microsoft.com/api/mcp`
- **Auth:** None (public)
- **Tools available:** `microsoft_docs_search`, `microsoft_docs_fetch`, `microsoft_code_sample_search`

---

## Installed but needs authentication

Re-authenticate by calling the `authenticate` tool for each server, or by removing and re-adding via `claude mcp remove` / `claude mcp add`.

| Server | URL | Authenticate tool |
|---|---|---|
| claude.ai Slack | `https://mcp.slack.com/mcp` | `mcp__claude_ai_Slack__authenticate` |
| claude.ai Gmail | `https://gmail.mcp.claude.com/mcp` | `mcp__claude_ai_Gmail__authenticate` |
| claude.ai Google Calendar | `https://gcal.mcp.claude.com/mcp` | `mcp__claude_ai_Google_Calendar__authenticate` |
| claude.ai Miro | `https://mcp.miro.com` | `mcp__claude_ai_Miro__authenticate` |
| claude.ai Atlassian | `https://mcp.atlassian.com/v1/mcp` | `mcp__claude_ai_Atlassian__authenticate` |
| claude.ai Zapier | `https://mcp.zapier.com/api/v1/connect` | `mcp__claude_ai_Zapier__authenticate` |
| semrush | `https://mcp.semrush.com/v1/mcp` | `mcp__semrush__authenticate` |
| mkt1 | `https://mkt1-mcp.data-1c2.workers.dev/mcp` | `mcp__mkt1__authenticate` |
| claude.ai Business Central BSI | `https://api.businesscentral.dynamics.com/v2.0/3013a262-bac5-4391-ab35-d43cf52ad904/Production/api/mcp/v1.0` | — |

---

## Failed / broken

| Server | URL | Status |
|---|---|---|
| claude.ai Figma | `https://mcp.figma.com/mcp` | Failed to connect — check if account still has access |

---

## How to add a new server

**HTTP server (with auth header):**
```json
// In ~/.claude/settings.json > mcpServers
"server-name": {
  "url": "https://example.com/mcp",
  "headers": {
    "Authorization": "Bearer YOUR_TOKEN"
  }
}
```

**stdio / npx server:**
```bash
claude mcp add server-name -- npx -y package-name
```

**HTTP server via CLI:**
```bash
claude mcp add server-name https://example.com/mcp --transport http
```

**OAuth server (like Asana):**
```bash
claude mcp add server-name https://mcp.example.com/mcp --transport http \
  --client-id YOUR_CLIENT_ID \
  --client-secret YOUR_CLIENT_SECRET \
  --callback-port 10000
```
