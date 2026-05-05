---
name: keyword-fill
description: Given a brainstorminc.com URL, researches and fills in all keyword tracking columns for the keyword tracking spreadsheet. Pulls live page data via Playwright and keyword/ranking data via Semrush MCP.
trigger: /keyword-fill
args: "<url> — the full brainstorminc.com URL to research"
---

# Keyword fill

When invoked with `/keyword-fill <url>`, research and return all spreadsheet column values for that URL.

---

## What this produces

A filled row for the keyword tracking spreadsheet covering these columns:

| Column | Source |
|--------|--------|
| Page Title | Playwright — live `<title>` tag |
| Meta Description | Playwright — live `<meta name="description">` content |
| H1 | Playwright — live H1 text |
| Target Keyword | Semrush — top organic keyword by traffic for this URL |
| Supporting Keywords | Semrush — next 4 organic keywords by traffic |
| Monthly Search Volume | Semrush — volume for the target keyword |
| Keyword Difficulty (0–100) | Semrush — KD for the target keyword |
| Current Rank | Semrush — this URL's current position for the target keyword |
| Target Rank | Calculated (see logic below) |
| Notes / Optimization Ideas | Your synthesis based on page content + keyword data |

---

## Step-by-step execution

### Step 1 — Fetch the live page with Playwright

Use `mcp__playwright__browser_navigate` to open the URL, then `mcp__playwright__browser_snapshot` to read the page.

After navigating, extract the following via `mcp__playwright__browser_evaluate` using `document.title`, `document.querySelector('meta[name="description"]')?.content`, and `document.querySelector('h1')?.innerText`:
- **Page Title** — the `<title>` tag value
- **Meta Description** — the `<meta name="description">` content attribute
- **H1** — the first H1 on the page

Beyond extraction, understand what the page is actually about — the topics it covers, the product or use case it describes, and how the content is structured. This context informs which keywords are a genuine fit and what the optimization notes should say.

### Step 2 — Identify the target audience role, then pull Semrush data

Before running Semrush, identify who this page is for. Use the page content to determine the specific role or job title most likely to be searching for this solution — e.g., "Director of Customer Education at a SaaS company," "IT admin evaluating adoption tools," "VP of Customer Success." This role lens must drive keyword selection: the target keyword should reflect how that person would search for a solution like this, not how BrainStorm would describe it internally.

Use `mcp__semrush__url_research` with the exact URL. Set database to `us`.

From the results:
- **Target Keyword** — the keyword that best captures the search intent of the target audience role. Prefer terms a buyer would type when actively looking for a solution (e.g., "customer education platform" not "BrainStorm use case"). Use Semrush traffic data to choose between candidates — but always filter through the audience-role lens first.
- **Supporting Keywords** — the next 4 keywords by traffic that the same audience role would plausibly search, comma-separated
- **Current Rank** — the position (`Po`) for the target keyword
- **Monthly Search Volume** — the `Nq` (monthly searches) for the target keyword
- **Keyword Difficulty** — use `mcp__semrush__keyword_research` with the target keyword to get KD score

If `url_research` returns no results (URL not yet indexed or no ranking data), try `mcp__semrush__organic_research` on the domain with a URL filter, or note `[no data — page may not be indexed]`.

### Step 3 — Calculate target rank

Apply this logic based on current rank:

| Current rank | Target rank |
|---|---|
| 1–3 | 1 (defend / hold) |
| 4–10 | 3 |
| 11–20 | 5 |
| 21–50 | 10 |
| 51+ or not ranking | 10 |
| No data | 10 |

### Step 4 — Write optimization notes

Write 2–4 short, specific notes based on what you found. Use this as your checklist:

- Does the page content clearly match the target keyword's search intent? If not, flag a content alignment gap.
- Is the current rank far from the target? Call out the gap and suggest a quick win (e.g. internal links from related pages, content depth, keyword prominence in body copy).
- Is the page not ranking at all? Flag for content depth review — the page may be too thin or targeting the wrong terms.
- Are there obvious keyword gaps between what the page covers and what the supporting keywords suggest it should cover?
- Is there a stronger or higher-volume keyword the page could realistically target instead?

Keep notes direct and actionable. No filler. Example:
> "Currently ranking 34 for 'software adoption platform' — a high-volume term the page covers well. Gap to target (10) is large; adding internal links from /features and /pricing pages would help. Consider expanding the body copy to address change management, which appears in 3 of the top supporting keywords but isn't covered on the page."

---

## Cannibalization check

Before finalizing the target keyword, read the keyword tracker spreadsheet to get all already-assigned target keywords:

**Spreadsheet path:**
`~/Library/CloudStorage/OneDrive-BrainStorminc.com/(02) Resources/Marketing - Writing/2026/Website/brainstorm-keyword-tracking.xlsx`

Run this Python snippet to extract already-claimed keywords:
```python
import openpyxl
wb = openpyxl.load_workbook('<path>')
ws = wb['Keyword Tracker']
claimed = {}
for row in ws.iter_rows(min_row=12, values_only=True):
    url, kw = row[1], row[4]  # col B = URL, col E = Target Keyword
    if url and kw and kw != '[FILL]':
        claimed[kw.lower()] = url
```

If the proposed target keyword (lowercased) already appears in `claimed` for a different URL:
- Pick the next best keyword that is distinct and not already assigned
- Flag the swap in the Notes field: "Note: '[keyword]' was considered but is already targeted by [other URL] — using '[alternate]' instead to avoid cannibalization."

Each page should own a unique primary keyword. Supporting keywords may overlap across pages but must not duplicate another page's target keyword.

---

## Output format

Return a clean, copy-paste-ready block in this exact format so it maps directly to spreadsheet columns:

```
PAGE TITLE:            <current <title> tag>
META DESCRIPTION:      <current meta description, or "[missing]" if not set>
H1:                    <current H1 text>
TARGET KEYWORD:        <value>
SUPPORTING KEYWORDS:   <kw1>, <kw2>, <kw3>, <kw4>
MONTHLY SEARCH VOLUME: <number>
KEYWORD DIFFICULTY:    <0–100>
CURRENT RANK:          <number or "not ranking">
TARGET RANK:           <number>
NOTES:                 <2–4 bullet points>
```

After the output block, add a one-line summary of the biggest opportunity or risk for this page.

---

## Step 5 — Present for approval (do NOT write to spreadsheet yet)

After generating all values, present the completed output block to the user and stop. Do not write anything to the spreadsheet.

End your response with:

> "Ready to publish this row to the spreadsheet — just say **approve** when you're happy with it."

Only write to the spreadsheet after the user explicitly approves (e.g., "approve", "publish it", "looks good, write it"). On approval, use the Python snippet below.

**Spreadsheet path:**
`/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/(02) Resources/Marketing - Writing/2026/Website/brainstorm-keyword-tracking.xlsx`

**Column mapping:**
- E (5): Target Keyword
- F (6): Supporting Keywords (comma-separated string)
- G (7): Monthly Search Volume
- H (8): Keyword Difficulty
- I (9): Current Rank (use integer or the string "not ranking")
- J (10): Target Rank
- K (11): Page Title
- L (12): Meta Description
- M (13): H1
- N (14): Notes (join bullet points into a single string, separated by " | ")
- O (15): Last Updated — set to today's date as a Python `datetime.date.today()` value
- P (16): Status — set to "In progress"

```python
import openpyxl
from datetime import date

XLSX = '/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/(02) Resources/Marketing - Writing/2026/Website/brainstorm-keyword-tracking.xlsx'
TARGET_URL = '<url>'

wb = openpyxl.load_workbook(XLSX)
ws = wb['Keyword Tracker']

for row in ws.iter_rows(min_row=12):
    if row[1].value == TARGET_URL:
        row[4].value  = '<target_keyword>'
        row[5].value  = '<supporting_keywords>'
        row[6].value  = <monthly_volume>
        row[7].value  = <kd>
        row[8].value  = <current_rank>
        row[9].value  = <target_rank>
        row[10].value = '<page_title>'
        row[11].value = '<meta_description>'
        row[12].value = '<h1>'
        row[13].value = '<notes>'
        row[14].value = date.today()
        row[15].value = 'In progress'
        break

wb.save(XLSX)
print("Saved.")
```

---

## Constraints

- Always use Playwright to get live page data. Never assume title/meta/H1 from the URL slug.
- Always use Semrush for keyword and ranking data. Never guess volume or difficulty.
- Semrush database default: `us`.
- If the URL is not a brainstorminc.com page, flag it and stop.
- Do not fill in the last 3 columns (Last Updated, Status, Owner) — those are manual.
