# Plan: Create 1:1s with Debra Notion database

## Context
Braxten wants a structured Notion database to track recurring 1:1 meetings with Debra (their boss, VP of Marketing). Currently there's a single unstructured "Meetings With Debra" page with ad-hoc notes. A proper database will make it easy to log each meeting, track status, and review past notes.

## Placement
Inside the existing "Meetings With Debra" page (ID: `3108668a-51f5-80ab-b29f-d493eeb657df`), located under BrainStorm > Work > Marketing > Areas > Braxten's LifeOS.

## Database design

**Title:** 1:1s with Debra

**Properties:**
| Property | Type | Values |
|---|---|---|
| Name | title | Meeting date, e.g. "Apr 27, 2026" |
| Date | date | Meeting date |
| Status | select | Scheduled / Done |
| Agenda | rich_text | Topics to cover going in |
| Key takeaways | rich_text | Main outcomes or decisions |
| My action items | rich_text | Braxten's follow-ups |
| Debra's action items | rich_text | Items for Debra to follow up on |

Each row (meeting entry) is also a full Notion page — detailed notes live in the page body.

## Implementation steps

1. Call `mcp__notion__notion-create-database` with:
   - Parent: page ID `3108668a-51f5-80ab-b29f-d493eeb657df`
   - Title: "1:1s with Debra"
   - Properties as defined above

2. Create one starter entry for today's date (Apr 27, 2026) with Status = "Scheduled" so the database isn't empty.

## Verification
- Confirm database appears inside the "Meetings With Debra" page in Notion
- Confirm all 7 properties are present with correct types
- Confirm the starter entry is visible
