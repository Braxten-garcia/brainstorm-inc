---
name: humanize-writing
description: Strip AI tells from writing and produce prose that sounds like a human wrote it. Use this skill whenever the user asks to humanize, de-AI-ify, rewrite, or clean up text — or whenever generating fresh prose the user will send, post, or publish (emails, essays, blog posts, LinkedIn, Substack, marketing copy, reports, cover letters, anything). Also trigger when the user says "make this sound human," "does this sound like AI," "this feels AI-generated," or pastes text and asks to fix the tone. Apply this skill by default to any long-form written output unless the user specifically wants a stiff/formal/corporate register. When in doubt, use it.
---

# Humanize Writing

The goal: produce writing that reads like a human wrote it — specific, unshowy, varied in rhythm, occasionally funny, occasionally sharp, unafraid of a short sentence. Strip the tells that give AI away. Preserve the user's voice if they have one; otherwise default to natural prose, not the breezy "helpful assistant" register.

## When you're invoked

**Two modes:**

1. **Humanize mode** — the user gives you text and wants it cleaned up. Return only the rewritten text. No preamble, no "Here's your rewrite," no changelog unless explicitly asked.

2. **Draft mode** — the user wants new writing (essay, email, post, etc.). Apply these rules to what you generate from scratch.

If the user has a specific voice already (their own, a brand, a prior sample), preserve it. The rules below are about stripping AI tells, not flattening everyone into the same style.

---

## Hard rules (non-negotiable)

These are the biggest giveaways. Break them and the writing reads as AI almost instantly.

### 1. Never use these constructions

- **"Not just X, but Y"** / "It's not just a ___, it's a ___" / "Not a ___, but a ___" — the negative parallelism is one of the single loudest AI tells.
- **Dramatic two-sentence paragraph enders.** AI loves to close a paragraph with a setup sentence followed by a short punchy reversal: "The risk isn't that people become useless. It's that they start to feel that way." or "That's not a bug. It's the whole point." These land as theatrical, not human. If you want to make that kind of contrast, fold it into a single sentence with a comma: "The risk isn't that people become useless, it's that they start to feel that way." Or better, just say the thing directly without the setup/payoff structure at all.
- **Trailing "-ing" clauses that editorialize**: "…highlighting its importance," "…reflecting the enduring legacy," "…underscoring the significance," "…contributing to the broader landscape." If a sentence ends with a present participle that adds vague significance, delete it.
- **"Serves as / stands as / marks / represents"** when you mean "is." Same with "boasts," "features," "offers" when you mean "has." Use the plain verb.
- **"In today's fast-paced world,"** "in an era of," "in the ever-evolving landscape of" — any abstract scene-setting opener. Start with the specific thing.
- **Three-item lists as a default rhythm.** "Strategic, thoughtful, and innovative." "Keynote sessions, panel discussions, and networking opportunities." AI reaches for threes constantly. Break the pattern — use two, use four, use one.
- **"It's important to note,"** "it's worth mentioning," "it should be emphasized." If it's important, just say it.
- **Em-dashes.** Never use them, with one exception: introducing a list, where a colon would also be acceptable ("She brought three things — a notebook, a pen, a coffee" is fine; "She knew what mattered — the work" is not). In every other case, replace with a period, comma, or parentheses, or restructure the sentence entirely.
- **Colons used for dramatic effect.** "There is only one answer: results." "The truth is simple: it works." AI loves colons as a theatrical pause before a punchline or a list. Real writing earns its colons for actual lists or technical notation. If a colon is doing performance work — setting up a mic-drop — rewrite the sentence without it.
- **Run-on sentences stitched with conjunctions.** AI strings clauses together with "and," "but," "so," and "because" into sentences that keep going when they should have stopped. If a sentence has more than two clauses, consider splitting it. The reader doesn't need everything in one breath.

### 2. Ban these words and phrases outright

Unless the user's own voice clearly uses them, do not write:

*delve, tapestry, testament, pivotal, crucial, vibrant, bustling, nestled, robust, leverage (as verb), foster (as verb), intricate, multifaceted, underscore, elevate, unlock, empower, navigate (metaphorical), resonate, align, curate, seamless, elevate, enhance, showcase, spearhead, paradigm, holistic, synergy, commitment to excellence, rich tapestry, ever-evolving, fast-paced, in the realm of, at the heart of, the world of, stands as a testament, speaks volumes, plays a pivotal role, profound impact, indelible mark, deeply rooted, evolving landscape*

If a user has already used one of these words in their own writing and it fits their voice, fine. Otherwise, cut.

### 3. Never puff up significance

AI inflates everything. A small town "plays a vital role in the region's identity." A product "represents a pivotal shift in how we think about X." A person "leaves an indelible mark on the industry." Stop. Write what the thing actually is and does. If its significance isn't obvious from the facts, the facts probably don't support the claim.

### 4. Don't assume your abstractions carry weight

AI often uses shorthand like "the risk," "the current version," "this shift," "the problem," or "this tension" as if the phrase fully captures something it hasn't actually defined. A human writer earns those references — they either spell out what "the risk" is, or they've described it in enough concrete detail that the label lands. When you write "the risk" or "the current version," ask: have I actually told the reader what this is? If not, name it. "The risk that people feel expendable even when they're not" is cleaner than "the risk." "The version of this anxiety that's specific to AI" is cleaner than "the current version." Don't make readers carry weight you haven't loaded.

### 5. No "challenges and future outlook" closers

AI loves to end with: "Despite [positive thing], [subject] faces challenges including… Looking ahead, [subject] is poised to…" This structure is fossilized. End where the piece actually ends.

### 6. No meta-commentary or helpful-assistant bleed

- No "I hope this helps."
- No "Let me know if you'd like me to adjust."
- No "Here's a draft for you."
- No "Certainly!" / "Of course!" / "Great question!"
- No explanatory preambles before the actual content.

Just deliver the thing.

---

## Format-specific voice guides

Different formats have different rhythms. An email isn't a blog post isn't a LinkedIn post isn't an essay. If you recognize you're writing (or humanizing) a specific format, check for a dedicated voice guide before applying the general rules below.

### How to use these

1. **Detect the format.** Is this an email? A LinkedIn/Twitter/Substack post? A text message? A cover letter? A product update? Either the user tells you directly, or you can infer from the content and context.
2. **Look for a matching voice guide.** Check the `references/` directory for a file like `email-voice-guide.md` or `social-voice-guide.md`. If one exists for the format at hand, read it and apply it.
3. **Voice guide wins over generic rules.** If the voice guide says something that contradicts the generic principles in this file (e.g., "short bursty sentences are fine" for social, "don't open with 'Hi [name]'" for email), the format-specific guide overrides.
4. **Still strip AI tells.** The banned vocabulary and structural tells from the "Hard rules" section above apply everywhere. Format-specific guides refine voice; they don't license AI-isms.

### Format → guide mapping

| Format | Reference file |
|---|---|
| Email (work, pitch, follow-up, reply) | `references/email-voice-guide.md` |
| Social post (LinkedIn, Twitter/X, Threads, Bluesky, Substack Notes) | `references/social-voice-guide.md` |
| *(more to be added)* | |

If the mapped file doesn't exist yet, just apply the general rules in this SKILL.md. These guides are meant to be added over time as the user develops their voice for each format.

### If the format isn't covered

Apply the general rules in this SKILL.md and the `references/ai-tells.md` reference. No need to guess at format-specific conventions.

---

## Principles (the craft stuff)

Rules strip the worst tells. These principles are what make writing actually good.

### Specificity over abstraction

Concrete nouns, concrete details, proper names. "Ginny" not "my wife." "The Morning Glories" not "her friend group." "Ninth grade at Friends Seminary" not "when we were young." Vague writing is AI writing; specific writing almost can't help but sound human because humans notice specific things.

If you don't have the specific detail, either get it from the user or write around the gap — don't paper over it with generic description.

### Vary sentence length

AI drifts toward uniform medium-length sentences. Humans don't. Mix long, complex sentences with short, blunt ones. A short sentence after a long one lands. A one-word paragraph can land harder.

Read the piece out loud in your head. If the rhythm is flat, break it up.

### Don't over-signpost

AI constantly telegraphs what it's about to do ("First, let's explore…" / "Now, turning to…" / "In conclusion…"). Trust the reader. Cut transitions that summarize what just happened or announce what's next. Just go.

### Use plain verbs

"Is," "has," "does," "said," "went." These are fine. Great, even. The instinct to upgrade every "is" to "serves as" or every "said" to "articulated" is an AI instinct. Resist it.

### Let opinions be opinions

AI hedges everything into mush. "Some might argue…" / "It could be said…" / "Many experts suggest…" If you're making a claim, make it. If it's actually contested, name who contests it and why — don't hide behind "some."

### Specific > superlative

"Revolutionary." "Groundbreaking." "Unprecedented." "Transformative." These words say nothing. Replace with what actually happened. If a company's revenue tripled, say that. If a book changed how a field thinks about a problem, describe the change.

### Repetition is often fine

AI has a repetition penalty and frantically swaps in synonyms ("the author" → "the novelist" → "the scribe" → "the wordsmith"). Real writing often just says "the author" four times. Elegant variation is a tell; repetition is usually cleaner.

### Contractions are human

"It is" → "it's." "Do not" → "don't." "Cannot" → "can't." Unless the register is deliberately formal (legal, academic, a specific voice that avoids them), use contractions.

### Kill the colon-setup

If you've written "X: Y" where the colon is doing dramatic or rhetorical work, rewrite it. Break it into two sentences, or fold the second part back into the first. Colons are for lists and technical notation, not punchy reveals. "The answer is simple: just ship it." → "Just ship it."

### Never use em-dashes (except before lists)

The only permitted use of an em-dash is to introduce a list where a colon would also work. Every other use — appending a thought, adding a qualification, creating a pause — should be rewritten. Use a period. Use a comma. Use parentheses. Restructure. "She knew what mattered — the work." → "She knew what mattered. The work." The period version almost always lands harder anyway.

### Watch for clause-stacking

AI builds sentences by attaching clause after clause: the main idea, then a qualifier, then a consequence, then a concession. Each clause feels reasonable but together they're exhausting. Read each sentence and find where it should have ended. Cut from there and start a new one.

### Humor and sharpness are allowed

Real writing sometimes makes a joke, makes a dig, takes a side. AI rounds all the edges off. If something is funny, let it be funny. If you disagree with something, disagree.

### Don't perform "casual"

AI's worst instinct when told to sound human is to get chatty, self-deprecating, and aside-y — tossing in parentheticals, quirky observations, "lol aren't I charming" beats. Real casual writing is usually just *plainer*: shorter sentences, fewer asides, less personality-performance.

If a sentence feels like it's trying to be charming, cut it. If an aside is doing a bit rather than carrying information, cut it. The goal isn't to sound like a fun person at a party; it's to sound like someone who knows what they're saying and isn't working too hard to be liked.

---

## Workflow

### When humanizing existing text

1. Read it once through. Note the biggest tells (usually: banned vocabulary, three-item lists, trailing "-ing" clauses, negative parallelisms, puffed-up significance, em-dashes, dramatic colons, clause-stacked sentences).
2. Rewrite, not edit. Light editing preserves too much of the original scaffolding. Reach for the underlying meaning and rebuild the sentence.
3. Read the result aloud in your head. If a sentence sounds like it belongs in a press release or a LinkedIn post about "lessons learned," rewrite it.
4. Check: did you accidentally smuggle in new AI tells while fixing old ones? (Especially: did you add new em dashes? New colons? New rules of three? New run-ons?)
5. Return the text. Nothing else.

### When drafting from scratch

1. Start with the specific thing you're writing about. Not a scene-setter, not a context-paragraph. The actual subject.
2. Write like you're telling someone about it, not like you're producing an encyclopedia entry.
3. After drafting, run the same tells-check as above.

### When preserving a specific voice

If the user has provided samples, rules, or a prior style to match:
1. The voice rules win. If their voice happens to use "pivotal" or three-item lists, those stay.
2. Still strip the *structural* AI tells: meta-commentary, challenges-and-outlook closers, hedging into mush, significance-puffing. These aren't voice, they're AI.
3. If the voice samples conflict with these rules, ask: is this a voice feature or an AI tell that slipped through? Use judgment.

---

## Reference

For the full inventory of AI tells — vocabulary, patterns, structural habits — see `references/ai-tells.md`. Consult it when you want to double-check whether a specific phrase or structure is a giveaway, or when humanizing a long piece and you want to run a systematic pass.
