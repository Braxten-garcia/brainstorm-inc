---
name: blog-rewrite
description: Rewrite or refresh BrainStorm blog posts with SEO optimization, brand voice, and verified feature accuracy. Accepts a single URL, a number (batch mode: process top N pending blogs), or "all" to process the full queue.
---

# Blog rewrite

This skill runs in two modes depending on the argument provided:

- `/blog-rewrite https://...` — process a single URL
- `/blog-rewrite 3` — process the top 3 pending blogs from the audit queue
- `/blog-rewrite all` — process every pending blog in the queue

---

## Batch mode (number or "all")

### Step 1: Load the queue

Use Bash to read the audit and pull all Pending rows, sorted by sessions (highest first):

```python
import openpyxl
path = '/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx'
wb = openpyxl.load_workbook(path)
ws = wb.active
queue = []
for row in ws.iter_rows(min_row=2, values_only=True):
    url, sessions, _, rewrite_type, rationale, keywords, status = row[:7]
    if url and status == 'Pending':
        queue.append((url, sessions, rewrite_type, rationale, keywords))
queue.sort(key=lambda x: x[1] or 0, reverse=True)
for item in queue[:N]:  # replace N with the requested number, or all
    print(item)
```

### Step 2: Process each URL

For each URL in the queue, run the full single-URL workflow below (Steps 1-7). Process them sequentially, one at a time.

### Step 3: Update status after each post

After successfully saving the .docx for a post, immediately update its status to "Done" in the Excel:

```python
import openpyxl
path = '/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx'
wb = openpyxl.load_workbook(path)
ws = wb.active
for row in ws.iter_rows(min_row=2):
    if row[0].value == '<URL>':
        row[6].value = 'Done'
        break
wb.save(path)
```

### Step 4: Summary report

After processing all posts in the batch, output a summary:
- How many posts were processed
- File path for each .docx output
- Any posts skipped due to errors (with reason)

---

## Single URL mode

Complete the following steps for the given URL.

### Step 1: Fetch existing copy

Use WebFetch on the provided URL. Extract:
- Full headline (H1)
- All subheadings (H2, H3)
- All body copy
- CTAs
- Meta description (if visible)
- Published date

### Step 2: Look up the SEO audit

Use Bash to find the URL's row in the audit spreadsheet:

```python
import openpyxl
wb = openpyxl.load_workbook('/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx')
ws = wb.active
target = '<URL>'
for row in ws.iter_rows(values_only=True):
    if row[0] and target in str(row[0]):
        print(row)
        break
```

Pull from the row:
- **Rewrite type**: Complete Rewrite or Refresh
- **Rationale**: why the post needs updating
- **Keyword suggestions**: semicolon-separated list of target keywords

### Step 3: Determine scope

- **Complete Rewrite**: Write net new copy from scratch. Keep the general topic but replace all copy, structure, and examples.
- **Refresh**: Make targeted updates only. Keep the existing structure and most copy; update outdated sections, add missing keywords, fix deprecated references.

### Step 4: Write new copy

Follow all BrainStorm brand voice rules:
- Friendly, genuine, relatable, human — never corporate or stodgy
- Short sentences with a storytelling angle
- Make the customer the hero
- Avoid jargon and buzzwords
- Use "software adoption and usage" not "deployment" or "video platform"
- Use "training" sparingly

**Heading rules (apply strictly):**
- All headings must be sentence case — only first word and proper nouns capitalized
- H1: under 60 characters, primary keyword in first 4 words, one per page
- H2s: under 60 characters, descriptive not clever, logical hierarchy
- H3s: short and clear

**Never use em dashes (—).** Replace with a comma, period, or colon.

### Step 5: SEO optimize

- **Primary keyword**: H1 (first 4 words), meta description, first 100 words of body, at least one H2
- **Secondary keywords**: woven naturally into body copy and H2s/H3s
- **Meta description**: ~150 characters, includes primary keyword, reads naturally

### Step 6: Verify features via web search

Use WebSearch to confirm every product feature mentioned is accurate and current. Search by feature name + current year. Update any deprecated or changed functionality before finalizing copy.

### Step 7: Output as .docx

Use Bash + python-docx to generate the file. Derive the slug from the URL path. Save to:
`~/brainstorm-marketing/content/blog-<slug>-rewrite.docx`

Apply proper heading styles (Heading 1, Heading 2, Heading 3), normal paragraph style for body, List Bullet for lists, bold for CTAs, italic for the meta/keyword block at the top.

Then update the Excel status to "Done" for this URL (see Step 3 in batch mode above).

Confirm the file path and summarize: rewrite type used, keywords incorporated, any features updated.
