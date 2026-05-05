---
name: internal-link-finder
description: Scans a blog post or document and recommends internal linking opportunities. Blog links come exclusively from the REWRITE PRIORITIZATION sheet of the SEO Audit Excel (approved, live pages only). Core nav and product pages are always eligible. Output is anchor text + URL + placement context.
---

# Internal link finder

Find natural internal linking opportunities in a document without linking to any blog pages that are scheduled for redirect or removal.

**Usage:** `/internal-link-finder [SharePoint URL or local file path]`

If no argument is provided, ask the user to supply a document before proceeding.

---

## Step 1: Read the target document

**SharePoint or OneDrive URL:**
Use `mcp__claude_ai_Microsoft_365__sharepoint_search` to locate the file if needed, then `mcp__claude_ai_Microsoft_365__read_resource` to read the full content.

**Local file path:**
Use the Read tool.

Extract and note:
- Full body text and all section headings
- The document's primary topic, key concepts, and recurring phrases
- Any URLs already linked in the document (to avoid recommending duplicates)

---

## Step 2: Load the approved blog URL list

Use Bash to read every URL and its keyword suggestions from the REWRITE PRIORITIZATION sheet. This is the **only** source for blog page links — do not suggest any blog URL that does not appear in this list.

```python
import openpyxl

path = '/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx'
wb = openpyxl.load_workbook(path)

# Find the REWRITE PRIORITIZATION sheet
ws = wb['REWRITE PRIORITIZATION']

approved_blogs = []
for row in ws.iter_rows(min_row=2, values_only=True):
    url = row[0]
    keywords = row[5]  # semicolon-separated keyword suggestions
    if url:
        approved_blogs.append({
            'url': url,
            'keywords': keywords or ''
        })

for b in approved_blogs:
    print(b['url'], '|', b['keywords'])
```

---

## Step 3: Fetch current nav pages

Use WebFetch on `https://www.brainstorminc.com` to extract all primary navigation links (product/platform pages, pricing, use cases, resources, about, customers, case studies, demo/contact, etc.).

These pages are always eligible for internal links regardless of the Excel list.

---

## Step 4: Identify natural linking opportunities

### Blog posts
For each approved blog URL:
- Parse the URL slug into topic keywords (e.g., `/blog/microsoft-teams-adoption-tips` → "Microsoft Teams adoption tips")
- Combine slug keywords with the `Keyword Suggestions` column values
- Check whether the document naturally discusses or references that topic
- Only include links where the connection is genuinely useful to the reader — not forced

### Nav and product pages
- Look for mentions of BrainStorm's platform, specific features (Flows, Analytics, Events, etc.), pricing, use cases, or any CTA that pairs naturally with a nav page
- Suggest the most specific page available (e.g., link "Copilot adoption analytics" to a use case or platform page, not just the homepage)

### Exclusion rules
- Do not suggest any URL already linked in the document
- Do not suggest any blog URL not found in the REWRITE PRIORITIZATION sheet
- Do not suggest the blog post's own URL
- Never use heading text as anchor text — anchor text must come from body copy only (a sentence or phrase within a paragraph, not an H1/H2/H3)
- Skip tenuous matches — if you have to stretch to explain the relevance, leave it out
- Aim for 3–8 total suggestions; prioritize quality over volume

---

## Step 5: Output

Present results in two grouped tables. For each suggestion include the recommended anchor text (a natural phrase from the document, not generic text like "click here"), the destination URL, and a brief note on where and why it fits.

---

### Blog links

| Anchor text | URL | Where to place it |
|---|---|---|
| [phrase from document] | https://www.brainstorminc.com/blog/... | [sentence or section context] |

---

### Nav and product page links

| Anchor text | URL | Where to place it |
|---|---|---|
| [phrase from document] | https://www.brainstorminc.com/... | [sentence or section context] |

---

End with a one-line note on any topics in the document that had no good match in the approved list, so Braxten knows if a gap exists.
