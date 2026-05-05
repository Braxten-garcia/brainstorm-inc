---
name: BrainStorm Customer Success Summit Oct 2026
description: Full planning context — status, completed work, remaining templates, key decisions, and file locations
type: project
---

## Event Details
- **Dates:** October 13–15, 2026 (Day 0 arrival Oct 13, full days Oct 14–15)
- **Location:** BrainStorm HQ, American Fork, UT + Sundance Mountain Resort outing
- **Scale:** 12–15 customers, 6 companies — already approved and vetted (confirmed, not invited)
- **Hotel:** Hyatt House Pleasant Grove (https://www.hyatt.com/hyatt-house/en-US/pvuxp-hyatt-house-provo-pleasant-grove)
- **Organizer:** Braxten is lead Event Coordinator + Customer Marketing Manager (CMM)
- **CSM co-lead:** Tyler Rogers; Elliott also involved as MC

**Why:** Customer success/retention event; deepens relationships with existing enterprise customers. This is a curated, high-touch experience — not a large conference.

**How to apply:** When helping with summit planning, keep intimate scale in mind. Tone for all attendee communications should reflect that these are confirmed, vetted attendees — not invitees. "You earned your spot," not "we'd love to have you."

## Key People
- Elliott — MC / executive presence
- Tyler Rogers — Senior CSM co-lead
- Chandler — learning experience structure approval
- Kensie — slide design + swag
- Kate + Matt — agenda approval

## File Locations
- **2026 SharePoint site:** `https://bsionline.sharepoint.com/sites/2026CustomerSummit`
  - Internal comms folder: `Marketing Resources/Client Summits/Customer Summit 2026/Internal Communications/`
  - Client comms folder: `Marketing Resources/Client Summits/Customer Summit 2026/Client Communications/`
- **Local OneDrive sync:** `/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/2026 Customer Summit - Customer Summit 2026/`
  - `Client Communications/` — where new client-facing docs are saved
- **2025 reference files:** `https://bsionline.sharepoint.com/sites/CustomerSummit` → `Customer Summit/2025-08 Customer Summit Folder/`

## Completed Work (as of Mar 2026)
- Two planning meetings held
- Landing page copy drafted (`Summit 2026 - Landing Page Copy.docx`)
- Invitation email template drafted (`Email 1 - Invitation Email.docx`)
- Internal agenda draft shell (`2026-10 - Summit at the Fork - Internal Agenda draft.docx`)
- **Milestone tracker Excel** — `Summit_2026_Milestone_Tracker.xlsx` on Desktop
  - Built with xlsxwriter (openpyxl CF is unreliable — don't switch back)
  - Gold header (#FFBD1A), dark navy title (#0D2137) with gold text — user's custom theme
  - Status dropdown: Not Started / In Progress / Complete → rows turn green/yellow
  - Summary uses COUNTA(E5:E10000) — dynamic, works when rows are added
  - Milestones numbered 1–12, then 14–26 (user deliberately skipped #13)
  - Script: `/tmp/create_summit_tracker_v5.py`
- **Email Invite & Communications doc** — `October 2026 Customer Summit Email Invite & Communications.docx` in Client Communications folder
  - Email 1: Official confirmation (confirmed tone, no RSVP ask)
  - Email 2: Agenda + speaker preview (sends ~July after agenda locked)
  - Email 3: Guest speaker confirmation (CSM sends, Braxten cc'd, travel covered)
  - Email 4: Hotel & travel details (Hyatt House Pleasant Grove, group rate link TBD)
  - Script: `/tmp/create_invite_doc_v2.py`

## Remaining Templates To Build
1. Travel recommendations email
2. "Help shape the summit" + meet your speakers email
3. Pre-event prep / logistics email (packing, agenda, reminders — ~1 week before)
4. Daily agenda emails (sent each morning of the event)
5. Activity selection email + form
6. Post-session feedback email
7. Internal agenda (2026 version)
8. Customer-facing agenda (2026 version)
9. Invitee tracking spreadsheet (2026 version)
10. Catering tracker
11. Speaker prep brief + presentation structure
12. Post-event debrief doc
13. Van/transportation booking checklist (net new — no 2025 version exists)
14. Budget tracker (net new — no 2025 version exists)

## Key Decisions / Tone Rules
- Attendees are confirmed, not invited — all comms should reflect that
- Hotel is Hyatt House Pleasant Grove (NOT Hyatt Place Lehi — that was 2025)
- BrainStorm covers: all meals, activities, daily hotel↔HQ transportation
- Attendees cover: flights, hotel, airport transport
- Sundance activity day: Oct 15 afternoon (Day 2)
- Day 3 (Oct 15) is intentionally light — takeaways + 1:1 CSM time + travel

## 2025 Debrief Inputs (apply to 2026 planning)
- Eric & John sessions earlier in the agenda (not saved for Day 3)
- More roundtables/conversational formats — less lecture
- Send attendee list + clear agenda ~1 week before
- Segment attendees by adoption stage
- Recording experience needs improvement
- Boom campaign video idea for brand storytelling
- Stormies Awards integration under consideration

## Milestone Plan
| # | Milestone | Target |
|---|-----------|--------|
| 5 | Committee review: agenda structure | Apr 3 |
| 6 | Define attendee criteria + invite list | Apr 10 |
| 7 | Identify/confirm guest speakers | Apr 17 |
| 8–9 | Book Sundance + send invitations | May 15 |
| 10 | Hotel block negotiation | May 22 |
| 11 | Customer RSVP deadline | Jun 19 |
| 12 | Confirm headcount + van rental | Jun 26 |
| 14 | Finalize agenda | Jul 17 |
| 15 | Book conference rooms at HQ | Jul 31 |
| 16 | Activity selection form sent | Aug 7 |
| 17–18 | Speaker slides due + swag ordered | Sep 11 |
| 19 | Catering finalized | Sep 18 |
| 20 | Pre-event details email | Oct 6 |
| 21 | Final run-of-show complete | Oct 9 |
| 22–24 | EVENT | Oct 13–15 |
| 25 | Thank-you emails | Oct 17 |
| 26 | Debrief | Oct 23 |
