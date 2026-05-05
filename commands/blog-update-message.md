# Blog update Teams message

You are generating a brief Microsoft Teams message for Braxten to send to Troy and Debra after a blog post has been rewritten or refreshed.

## Input

`/blog-update-message https://www.brainstorminc.com/blog/[slug]`

The URL is the live blog post (old copy). The new copy is the corresponding `.docx` file in:
`/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/Marketing - Writing/2026/Website/Blog Rewrites - Blog Refreshes/`

Filename matches the URL slug. Example: `how-to-use-onenote.docx`

---

## Step 1: Look up the blog in the SEO audit

Read the spreadsheet:
`/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx`

Sheet: **REWRITE PRIORITIZATION**

Columns:
- A: URL
- B: Sessions
- D: Rewrite Type (`Complete Rewrite` or `Refresh`)
- E: Rationale
- F: Keyword Suggestions

```python
import openpyxl
wb = openpyxl.load_workbook('/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/BrainStorm Blog SEO Audit.xlsx')
ws = wb['REWRITE PRIORITIZATION']
for row in ws.iter_rows(min_row=2, values_only=True):
    if row[0] and row[0].strip() == url:
        rewrite_type = row[3]  # col D
        rationale = row[4]     # col E
        keywords = row[5]      # col F
        break
```

If the URL is not found in the sheet, note that and continue with what you can infer.

---

## Step 2: Fetch the old copy

Use WebFetch on the URL. Extract: H1, all H2s and H3s, full body copy.

---

## Step 3: Read the new copy

Use python-docx to extract the text from the `.docx` file:

```python
from docx import Document
doc = Document('/Users/braxtengarcia/Library/CloudStorage/OneDrive-BrainStorminc.com/Marketing - Writing/2026/Website/Blog Rewrites - Blog Refreshes/[slug].docx')
full_text = '\n'.join([p.text for p in doc.paragraphs if p.text.strip()])
print(full_text)
```

---

## Step 4: Compare old vs. new

Analyze the differences between the old copy (from the URL) and the new copy (from the .docx). Note:

- Did the H1 change?
- Were headings restructured?
- Was the body largely replaced or just updated in spots?
- Were new sections added or old ones removed?
- Were keywords or SEO elements updated?

Use column D from the audit as the definitive classification:
- `Complete Rewrite` = net new (majority of copy replaced)
- `Refresh` = subtle updates (light edits, keyword additions, outdated sections updated)

---

## Step 5: Write the Teams message

Use this exact format:

```
Blog rewrite ready for review

Flagged because [rationale from column E]

Current Copy: [URL from column A]
New: [filename of the .docx file]
```

No greeting, no summary sentences, no extra commentary. Just the four lines above.

---

## Step 6: Output

Print only the final message, ready to copy/paste. Do not include any preamble, file paths, or technical notes in the output.
