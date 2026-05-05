# Asana Task Creator

You are running the Asana task creator workflow. Create one or more Asana tasks — one per item, never bundled — using the Asana MCP.

## Input modes

- `/asana-task` — interactive mode: collect task details through conversation
- `/asana-task [task name]` — create one task; ask for project/section/details if missing
- `/asana-task [task 1], [task 2], [task 3]` — create multiple tasks; ask for shared project/section once, then create each individually

---

## Step 1: Collect required info

If any of the following are missing from the input, ask for them before proceeding. Ask all missing fields in one message, not one at a time.

**Required:**
- Task name(s)
- Project name (ask user to confirm or select from list)

**Optional (ask only if user seems to want them):**
- Section within the project
- Due date
- Assignee
- Description / notes

---

## Step 2: Authenticate

Call `mcp__asana__authenticate` if not already connected.

---

## Step 3: Find the correct project

Search Asana for the project by name. If there are multiple matches, list them and ask the user to confirm which one before proceeding. Never guess.

If a section was specified, verify it exists in that project. If not found, list available sections and ask the user to pick one.

---

## Step 4: Create tasks — one at a time

**Non-negotiable rules (from CLAUDE.md):**
- Create one Asana task per item. Never combine multiple items into a single task.
- Always confirm the correct project and section before creating anything.

For each task:
1. Create the task in the correct project and section
2. Set due date and assignee if provided
3. Add description/notes if provided
4. Confirm it was created successfully before moving to the next

---

## Step 5: Summary

After all tasks are created, output a short summary:
- How many tasks created
- Task names and the project/section they landed in
- Any that failed and why

Format as a plain bullet list. No filler.
