# BrainStorm Blog Rewrite

You are running the BrainStorm blog rewrite workflow. Rewrite or refresh blog posts from the SEO audit queue, save each as a `.docx` file, and update the spreadsheet status — all without manual steps in between.

## Input modes

- `/blog-rewrite` — process the next 15 blogs by session count
- `/blog-rewrite 5` — process the top N blogs by session count
- `/blog-rewrite all` — process every row where Status = "Needs to be written"
- `/blog-rewrite https://www.brainstorminc.com/blog/[slug]` — rewrite one specific blog

---

## Step 1: Read the queue

Open the spreadsheet at:
`/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx`

Sheet: **REWRITE PRIORITIZATION**

Columns (in order):
- A: URL
- B: Sessions
- C: Last Updated (VLOOKUP formula — read as-is)
- D: Rewrite Type (`Complete Rewrite` or `Refresh`)
- E: Rationale
- F: Keyword Suggestions (Semrush)
- G: **Status** (`Needs to be written` or `Completed`)

Filter rows where **Status = "Needs to be written"**, sort by Sessions descending (column B), take the top N per the input mode.

Use openpyxl to read the file:
```python
import openpyxl
wb = openpyxl.load_workbook('/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx')
ws = wb['REWRITE PRIORITIZATION']
```

---

## Step 2: For each blog, run this full workflow

### 2a. Fetch existing copy
Use WebFetch on the blog URL. Extract: H1, all H2s and H3s, full body copy, CTAs, meta description.

### 2b. Verify features
Use WebSearch to confirm every product or software feature mentioned is current in 2026. Update anything deprecated, renamed, or changed. Note all updates made.

### 2c. Determine scope from column D
- **Complete Rewrite**: Write entirely new copy. Keep the topic, replace everything else.
- **Refresh**: Light updates. Fix outdated sections, add keywords, update deprecated references.

### 2d. Write the new copy

**Brand voice (non-negotiable):**
- Friendly, genuine, relatable, human — never corporate or stodgy
- Short sentences with a storytelling angle
- Make the customer the hero, not BrainStorm
- No jargon, no buzzwords
- Use "software adoption and usage" not "deployment" or "video platform"
- Use "training" sparingly

**NEVER use em dashes (—).** Replace with a comma, period, or colon. This applies everywhere in the copy including CTAs.

**Heading rules (non-negotiable):**
- ALL headings must be sentence case: only first word and proper nouns capitalized
- H1: under 60 characters, primary keyword in first 4 words, one per page
- H2s: under 60 characters, descriptive not clever
- H3s: short, clear, tell the reader exactly what the section covers

**SEO rules:**
- Primary keyword (first in column F): in H1 first 4 words, meta description, first 100 words of body, at least one H2
- Secondary keywords: woven naturally into body and subheadings
- Meta description: ~150 characters, includes primary keyword, reads naturally

**Closing CTA (use this context for every post):**
BrainStorm is an enterprise software adoption platform that drives real software adoption by changing individual behavior, not just giving people access to tools. Key proof points: 50% sustained increase in Copilot adoption (Masco case study), named Most Innovative Solution Provider by CLN, Microsoft Technology Partner of the Year. Primary products: Flows (modular learning), Analytics (links learning to adoption metrics), Packs (pre-built content campaigns), Events (on-demand and live). Close by connecting the topic to BrainStorm's value: people use 20% of their software because no one showed them the rest — that's what BrainStorm fixes. Do not use em dashes in this section either.

---

## Step 3: Save as .docx

Use the helper below to create properly formatted Word documents. Save each file to:
`/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/Marketing - Writing/2026/Website/Blog Rewrites - Blog Refreshes/`

**Filename format:** `[slug-from-url].docx`
For example: `https://www.brainstorminc.com/blog/how-to-use-onenote` → `how-to-use-onenote.docx`

**python-docx helper — write this to /tmp/blog_helper.py if it doesn't already exist:**

```python
from docx import Document
from docx.shared import Pt, RGBColor, Inches
import os

OUTPUT_DIR = "/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/Marketing - Writing/2026/Website/Blog Rewrites - Blog Refreshes"

def create_blog_doc(filename, url, keywords, meta, content_str):
    doc = Document()
    for sec in doc.sections:
        sec.top_margin = Inches(1)
        sec.bottom_margin = Inches(1)
        sec.left_margin = Inches(1.25)
        sec.right_margin = Inches(1.25)

    p = doc.add_paragraph()
    p.add_run("Source URL: ").bold = True
    p.add_run(url)

    p2 = doc.add_paragraph()
    p2.add_run("Keywords: ").bold = True
    p2.add_run(keywords)

    p3 = doc.add_paragraph()
    r = p3.add_run("SEO META: " + meta)
    r.italic = True
    r.font.size = Pt(9)
    r.font.color.rgb = RGBColor(0x66, 0x66, 0x66)

    doc.add_paragraph()

    buf = []

    def flush():
        if buf:
            text = " ".join(buf).strip()
            if text:
                doc.add_paragraph(text)
            buf.clear()

    for raw in content_str.split("\n"):
        line = raw.strip()
        if line.startswith("H1: "):
            flush(); doc.add_heading(line[4:], level=1)
        elif line.startswith("H2: "):
            flush(); doc.add_heading(line[4:], level=2)
        elif line.startswith("H3: "):
            flush(); doc.add_heading(line[4:], level=3)
        elif line.startswith("- "):
            flush(); doc.add_paragraph(line[2:], style="List Bullet")
        elif line == "":
            flush()
        else:
            buf.append(line)
    flush()

    path = os.path.join(OUTPUT_DIR, filename)
    doc.save(path)
    print(f"Saved: {filename}")
```

Structure your content_str with explicit `H1: `, `H2: `, `H3: ` prefixes on heading lines, `- ` for bullets, and plain text for body paragraphs separated by blank lines.

---

## Step 4: Mark as Completed in the spreadsheet

After saving each .docx, immediately update that row's Status cell (column G) to `Completed` and save the workbook:

```python
import openpyxl
path = '/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx'
wb = openpyxl.load_workbook(path)
ws = wb['REWRITE PRIORITIZATION']
for row in ws.iter_rows(min_row=2, max_row=ws.max_row):
    if row[0].value and row[0].value.strip() == url:
        row[6].value = 'Completed'
wb.save(path)
```

---

## Step 5: Summary output

After processing all blogs, print a summary:
- How many blogs processed
- List of filenames created
- Any features updated (deprecated references replaced)
- Any rows where the URL in the sheet didn't exactly match (flag for manual review)
