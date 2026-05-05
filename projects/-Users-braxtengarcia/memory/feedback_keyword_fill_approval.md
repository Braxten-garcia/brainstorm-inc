---
name: keyword-fill approval required before writing
description: Never write keyword-fill results to the spreadsheet without explicit user approval
type: feedback
originSessionId: 44548133-b71b-4b33-82ff-e9caf4493b6e
---
Never publish keyword-fill output to the spreadsheet automatically. Always present the completed row output first and wait for explicit approval ("approve", "publish it", "looks good") before writing.

**Why:** User noticed cannibalization overlaps that weren't being caught, and has low confidence in fully automated writes. They want to review each row before it hits the spreadsheet.

**How to apply:** After generating keyword research output, end with "Ready to publish — just say approve when you're happy with it." Only run the openpyxl write script after the user explicitly approves.
