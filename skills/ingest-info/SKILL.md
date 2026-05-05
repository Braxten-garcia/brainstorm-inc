---
name: ingest-info
description: Given a new source (URL, file path, or pasted text), distill key facts into the knowledge wiki at ~/knowledge-base/. Updates existing articles, creates new ones if needed, links articles with wikilinks, and logs every change to log.md.
---

# Ingest info

Accepts a URL, file path, or pasted text block and routes distilled information into the right articles in `~/knowledge-base/`.

Usage:
- `/ingest-info https://example.com/article`
- `/ingest-info ~/Documents/notes.md`
- `/ingest-info` (paste text directly after the command)

---

## Step 1: Read the source

**URL:** Use WebFetch to retrieve the full page content.

**File path:** Use Read to load the file.

**Pasted text:** Use the text provided directly after the command as the source content.

Note the source identifier (URL or file path) — it will appear as a "Source" link at the top of every new section added.

---

## Step 2: Distill — extract only what matters

Do not copy the full source. Extract only:
- Key facts, numbers, and statistics
- Decisions or conclusions that have been made
- Frameworks, models, or named concepts
- Direct quotes worth preserving (short)
- Anything that changes how the AI should behave or what it should know

Discard:
- Background context that adds no new information
- Repetition, filler, and throat-clearing
- Anything already captured in the wiki

---

## Step 3: Map distilled points to existing articles

Read the full file list from `~/knowledge-base/index.md` to know what articles exist.

For each distilled point, decide:
- Does it belong in an **existing article**? → update it
- Does it span **multiple articles**? → split it across them
- Is it genuinely new territory with no home? → create a new article

Never create a "dump" article. Every new file should have a clear, focused topic.

---

## Step 4: Update or create articles

### When updating an existing article

1. Read the existing file first.
2. Find the most relevant section. If no section fits, add a new `##` heading.
3. At the top of the new section (or inline if small), include:
   ```
   Source: [title or filename](URL or path)
   ```
4. Add the distilled points as short paragraphs or bullet points.
5. Use `[[wikilinks]]` to link to related articles by filename without the `.md` extension. Example: `[[audience]]`, `[[avoid]]`, `[[domain-glossary]]`.
6. Keep it scannable. No multi-sentence intros. No filler.

### When creating a new article

1. Create the file at `~/knowledge-base/[topic-name].md`.
2. Use this structure:

```markdown
# [Topic title]

Source: [title or filename](URL or path)

[Distilled content — bullets or short paragraphs]

Related: [[article-one]], [[article-two]]
```

3. Use sentence case for the title and all headings.
4. No em dashes. Short sentences. Bullet points over prose.

---

## Step 5: Update index.md

Read `~/knowledge-base/index.md`.

- If you created a new article, add a row to the table:
  ```
  | [filename.md](filename.md) | One-line description of what's in it |
  ```
- If you made significant additions to an existing article, update its description if it no longer fits.

---

## Step 6: Append to log.md

Read `~/knowledge-base/log.md` if it exists. If it doesn't, create it with this header:

```markdown
# Ingest log

| Date | Source | What changed |
|------|--------|-------------|
```

Append one row:
```
| YYYY-MM-DD | [source name](URL or path) | One-line note on what was added or updated |
```

Use today's date. Keep the note tight — what changed and where.

---

## Output to user

After completing all steps, give a brief summary:
- Which articles were updated (list filenames)
- Which new articles were created (list filenames)
- One sentence on what was ingested

No lengthy recap. No restating what you did step by step. Just the result.
