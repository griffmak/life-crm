# Life CRM

An autonomous life management agent built on Claude Code cloud routines.

Reads your Gmail weekly, tracks adult responsibilities across 8 categories,
surfaces what needs attention, and sends a weekly briefing email. Text yourself
via iMessage to log things Gmail won't catch.

## How It Works

- **Sunday 8am** — Claude reads your Gmail (90-day lookback on first run, 7 days
  after), extracts bills, subscriptions, appointments, renewals, and deadlines,
  writes everything to Firestore, commits a LIFE-CRM.md snapshot to Git, and
  emails you a structured weekly briefing
- **Mon–Sat 8am** — lightweight check: reads Firestore, sends an alert only if
  something is overdue or due within 3 days
- **iMessage** — text yourself anytime to log things Claude won't find in Gmail
  ("AC filter replaced", "dentist April 30", "lunch with Jake next Friday")
- **Dashboard** — live Vercel app shows category cards, urgency indicators, people
  directory, and monthly completion rate

## Setup Your Own

### Prerequisites
- Claude Code account with Routines access
- Firebase project (free tier works)
- Resend account (free tier — 3,000 emails/month)
- GitHub account + Vercel account

### Steps
1. Fork this repo
2. Create Firebase project → enable Firestore (Native mode) → set security rules
   to `allow read, write: if true;`
3. Copy your Firebase `projectId` and `apiKey`
4. Deploy to Vercel → set `FIRESTORE_PROJECT_ID` and `FIRESTORE_API_KEY` env vars
5. Install Claude GitHub App on your fork → enable "Allow unrestricted branch pushes"
   in repo Settings → Actions
6. In Claude Code → Settings → Routines → create two routines:
   - `routines/weekly-scan.md` — schedule `0 13 * * 0` (Sunday 8am EST)
   - `routines/daily-check.md` — schedule `0 13 * * 1-6` (Mon–Sat 8am EST)
7. Set env vars on each routine: `FIRESTORE_PROJECT_ID`, `FIRESTORE_API_KEY`,
   `RESEND_API_KEY`, `ANTHROPIC_API_KEY`, `USER_EMAIL`
8. Edit `memory/CATEGORIES.md` to match your life — remove Roommate Finance if
   you live alone, add Car if you have one, rename anything that doesn't fit
9. Trigger a manual run of weekly-scan → check your inbox

## Categories (default)

Housing · Bills & Subscriptions · Health · Social & Plans · Taxes & Business ·
NYC & Bureaucratic · Digital · Roommate Finance

All categories are configurable — edit `memory/CATEGORIES.md` directly or text
yourself "add category: [name]" via iMessage.
