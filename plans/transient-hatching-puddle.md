# Plan: /start-day skill

## Context
Braxten needs a skill he can run each morning to pull together everything he needs to plan his day optimally. It should aggregate Asana tasks, his M365 calendar, and a light email triage — then synthesize into a clear, prioritized plan so he's always working on the most impactful things first.

## Skill file to create
`/Users/braxtengarcia/.claude/skills/start-day/SKILL.md`

## What the skill does

### Step 1 — Pull data (run in parallel)
- **Asana:** Get my tasks — overdue, due today, and due this week. Use `mcp__asana__get_my_tasks`.
- **M365 Calendar:** Get today's calendar events via `mcp__claude_ai_Microsoft_365__outlook_calendar_search`.
- **Email triage:** Pull unread emails from the last 24h via `mcp__claude_ai_Microsoft_365__outlook_email_search`. Flag only items that need a reply or action today — skip newsletters, automated notifications, CCs with no implied action.

### Step 2 — Synthesize into a daily plan
Apply this prioritization logic:
1. **Urgent/overdue** — anything overdue in Asana or email that needs a reply by EOD
2. **High-impact scheduled** — tasks or meetings tied to major projects (Summit, LinkedIn publishing, blog rewrites)
3. **Due today** — everything else due today
4. **Due this week** — awareness items

### Step 3 — Output format
Clean, scannable daily plan:

```
## Good morning, Braxten

Today: [Day, Date]

### Top 3 priorities
1. [Most urgent/impactful task + why]
2. [Second priority]
3. [Third priority]

### Meetings today
- [Time] — [Event name]

### Full Asana task list
**Overdue:**
- [task] — due [date]

**Due today:**
- [task]

**Due this week:**
- [task] — due [date]

### Email actions
- [Sender] — [subject] — [action needed]
  (Skip if inbox is clear)
```

## Trigger
- `/start-day`
- "plan my day"
- "morning briefing"
- "start my day"

## Tools used
- `mcp__asana__get_my_tasks`
- `mcp__claude_ai_Microsoft_365__outlook_calendar_search`
- `mcp__claude_ai_Microsoft_365__outlook_email_search`

## File to create
`~/.claude/skills/start-day/SKILL.md`

## Verification
Run `/start-day` in a new session. Confirm it pulls Asana tasks, today's calendar, and unread emails, then outputs a clean prioritized plan.
