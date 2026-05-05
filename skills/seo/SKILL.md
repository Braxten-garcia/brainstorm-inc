---
name: seo-audit
description: SEO optimization for blog posts and web pages. Use when asked to "optimize for SEO", "improve search ranking", "fix meta tags", "keyword optimize", or "SEO review" for BrainStorm content.
---

# SEO optimization — BrainStorm

SEO guidance tailored to BrainStorm's blog and web content. Based on Google Search guidelines, Semrush keyword research, and BrainStorm's content pillars.

## BrainStorm context

**Site:** brainstorminc.com
**CMS:** [update with your CMS, e.g. WordPress, HubSpot]
**Primary tool:** Semrush MCP for keyword research
**Content pillars:**
- AI Productivity (Workflow Automation, Prompt Engineering, AI Solutions, Time Management, Meeting Efficiency)
- AI Security (Data Privacy, Threat Detection, Compliance, Prompt Injection, Ethics & Trust)

**Audience:** IT decision-makers, HR/L&D stakeholders at enterprise orgs in the Microsoft ecosystem

---

## Fetching pages for audit

**Always use Playwright MCP to fetch pages, not WebFetch.**

BrainStorm's site renders meta tags, canonical URLs, and some heading content via JavaScript. WebFetch only sees raw HTML and will miss these. Playwright runs a real browser, so what you see is what Google sees.

Steps for every audit:
1. Use the Playwright MCP `browser_navigate` tool to open the URL
2. Wait for the page to fully load (use `browser_wait_for_load_state` if needed)
3. Use `browser_evaluate` to extract: title tag, meta description, canonical URL, all headings (H1–H3), and any `<script type="application/ld+json">` blocks
4. Then proceed with the audit below

If Playwright MCP is unavailable, fall back to WebFetch and note that meta tags may be incomplete.

---

## Before you optimize

Run keyword research in Semrush first. For each blog post, identify:
- **Primary keyword** — highest-volume, most relevant term
- **Secondary keywords** — 2-3 supporting terms
- **Search intent** — informational, navigational, or commercial?

Match intent to content type. An informational keyword needs an educational post, not a product pitch.

---

## On-page SEO

### Title tags

- 50-60 characters
- Primary keyword near the beginning
- Unique per page
- Brand name at end: `| BrainStorm`

```
✅ How to drive Microsoft Copilot adoption at scale | BrainStorm
✅ AI security risks every IT leader should know | BrainStorm

❌ BrainStorm Blog - AI and Productivity Tips
❌ Home
```

### Meta descriptions

- 150-160 characters
- Include primary keyword naturally
- Lead with the value, end with a light CTA
- No em dashes

```
✅ Most Copilot rollouts stall because employees never change their habits. Here's how BrainStorm helps teams actually use it.

❌ In this blog post, we discuss Microsoft Copilot adoption and why it matters for your organization's digital transformation journey.
```

### Heading structure

- One `<h1>` per page (the post title)
- Logical hierarchy: H1 > H2 > H3
- Include keywords in H2s naturally
- Use sentence case (BrainStorm style guide)

```
✅ H1: How to increase Copilot adoption across your organization
   H2: Why most Copilot rollouts fail
   H2: What behavior change actually looks like
   H3: The role of training flows
   H2: How to measure adoption over time

❌ H1: COPILOT ADOPTION GUIDE
   H4: Why rollouts fail
   H2: Contact us
```

### Image SEO

- Descriptive filenames: `copilot-adoption-dashboard.webp` not `IMG_1234.jpg`
- Alt text describes the image: `BrainStorm analytics dashboard showing Copilot adoption rate increase from 10% to 50%`
- Compress images before uploading
- Use WebP when possible

---

## Internal linking

**Rules for BrainStorm content:**
- Anchor text must come from body copy only — never use heading text (H1/H2/H3) as anchor text
- Link to related blog posts, product pages, and case studies
- 2-5 internal links per post is a good target
- Link to the Masco case study when discussing Copilot adoption ROI

```
✅ <a href="/case-studies/masco">see how Masco increased Copilot adoption by 50%</a>
✅ <a href="/platform/analytics">track adoption with BrainStorm's analytics</a>

❌ <a href="/case-studies/masco">Case Studies</a>
❌ <a href="/platform/analytics">click here</a>
```

---

## URL structure

- Use hyphens, not underscores
- Lowercase only
- Short and keyword-rich
- No dates in URLs (content stays evergreen)

```
✅ brainstorminc.com/blog/copilot-adoption-strategy
✅ brainstorminc.com/blog/ai-security-compliance

❌ brainstorminc.com/blog/2024/01/15/how-to-think-about-copilot-adoption-in-your-enterprise-org
❌ brainstorminc.com/blog?p=1234
```

---

## Structured data

### Article schema (for blog posts)

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "How to increase Copilot adoption across your organization",
  "description": "Most Copilot rollouts stall at 10% adoption. Here's what BrainStorm does differently.",
  "image": "https://brainstorminc.com/images/copilot-adoption-cover.jpg",
  "author": {
    "@type": "Person",
    "name": "[Author Name]",
    "url": "https://brainstorminc.com/authors/[author-slug]"
  },
  "publisher": {
    "@type": "Organization",
    "name": "BrainStorm",
    "logo": {
      "@type": "ImageObject",
      "url": "https://brainstorminc.com/logo.png"
    }
  },
  "datePublished": "YYYY-MM-DD",
  "dateModified": "YYYY-MM-DD"
}
</script>
```

### FAQ schema (add when post has FAQ section)

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What is software adoption?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Software adoption is the process of getting employees to actually use and benefit from tools their organization has purchased."
      }
    }
  ]
}
</script>
```

---

## Technical SEO checklist

Run this before publishing any blog post or page update.

### Critical
- [ ] HTTPS (all brainstorminc.com URLs)
- [ ] No `noindex` on the page
- [ ] Title tag present, unique, and under 60 characters
- [ ] Single `<h1>` matches or reflects the title tag
- [ ] Canonical URL set correctly

### High priority
- [ ] Meta description present and under 160 characters
- [ ] Primary keyword in: title, H1, first 100 words, at least one H2
- [ ] 2-5 internal links with descriptive anchor text
- [ ] All images have alt text
- [ ] Mobile-responsive layout
- [ ] Page loads in under 3 seconds

### Medium priority
- [ ] Article schema added
- [ ] FAQ schema added (if FAQ section exists)
- [ ] Descriptive URL slug
- [ ] No broken links
- [ ] Images compressed and using WebP

---

## Tools

| Tool | Use |
|------|-----|
| Playwright MCP | Fetch fully JS-rendered pages (use this first, always) |
| Semrush MCP | Keyword research, search volume, competition |
| Google Search Console | Monitor indexing, find crawl errors, track rankings |
| Google PageSpeed Insights | Page speed and Core Web Vitals |
| Google Rich Results Test | Validate structured data |
| Screaming Frog | Full site crawl audit |

---

## BrainStorm voice reminders (for SEO content)

- Make the customer the hero
- No em dashes — use commas, colons, or periods
- Sentence case headings only
- Say "software adoption and usage" not "deployment"
- Say "training" sparingly
- No jargon; write for people, not search engines
- No "Content Packs" — name specific platform tools instead

---
