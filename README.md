# Meridian

A production-ready personal journal built with **Ruby on Rails 8**. Clean slug URLs, a full editorial admin, categories, drafts, featured essays, and a reader-first public site — no client-side router, no extra JavaScript framework.

- A published post opens at `http://localhost:3000/your-blog-slug`
- A category opens at `http://localhost:3000/category/your-category-slug`

**Stack:** Rails 8 · Hotwire (Turbo + Stimulus) · Action Text · Active Storage · SQLite · bcrypt · Propshaft · Importmaps

---

## Features

### Public journal

| Feature | What it does |
| --- | --- |
| **Journal home** | Hero, one featured essay, and a grid of latest published posts |
| **Clean post URLs** | Posts live at `/:slug` — no `/posts/123`, no date prefixes |
| **Category archives** | Topic shelves at `/category/:slug` with description and essay count |
| **About page** | Editorial manifesto plus live counts of published essays and categories |
| **Featured essay** | One published, featured post is highlighted on the home page |
| **Drafts stay private** | Only `published` posts with a due `published_at` (or none) appear publicly |
| **Reading time** | Estimated minutes from word count (~200 wpm, minimum 1 minute) |
| **Related essays** | Up to 3 other published posts from the same category |
| **Cover images** | Optional Active Storage cover on the article page |
| **Rich text bodies** | Action Text / Trix — headings, quotes, lists, inline formatting |
| **Breadcrumbs** | Journal → category on posts and category pages |
| **SEO meta** | Per-page title and description (`<title>` + meta description) |
| **Author box** | Editorial byline and journal note at the end of each essay |
| **Empty states** | Helpful copy when there are no posts, no matches, or an empty category |

### Discovery & reading UX

| Feature | What it does |
| --- | --- |
| **Live search** | Filter the home grid by title or excerpt as you type |
| **Category pills** | Instant client-side filter: All Topics or a specific shelf |
| **Clear filters** | Reset search + category when nothing matches |
| **Live result count** | “N essays” updates as you filter |
| **Reading progress bar** | Scroll progress across the article |
| **Back to top** | Appears after ~400px scroll; smooth-scrolls to the header |
| **Copy link** | Copies the article URL; shows “Copied!” and a toast |
| **Native share** | Web Share API when available; falls back to copy |
| **Light / dark theme** | Toggle in the header; respects `prefers-color-scheme`; persists in `localStorage` |
| **No theme flash** | Inline script applies the saved theme before first paint |
| **Mobile nav** | Hamburger menu with accessible `aria-expanded` |
| **Skip to content** | Keyboard skip link for accessibility |
| **Flash + toast** | Notices, alerts, and polite live-region toasts |

### Navigation & chrome

- Brand wordmark links home
- Primary nav: Journal, first 5 categories, About
- Signed-in editors also see an **Admin** link
- Footer lists every category plus Home, About, and Editor Portal / Dashboard
- Theme-color meta for light and dark
- Custom SVG favicon

### Admin / editorial suite

Protected by session auth (`bcrypt` + `has_secure_password`). Unsigned visitors are redirected to `/admin/login`.

| Feature | What it does |
| --- | --- |
| **Sign in / sign out** | Email + password; session stored as `admin_user_id` |
| **Email normalization** | Trim + lowercase before lookup and save |
| **Password rules** | Minimum 8 characters |
| **Already signed in** | Login page redirects to the dashboard |
| **Dashboard** | Counts for published, drafts, all articles, and categories |
| **Recent articles** | Last 6 posts with status, slug, featured badge, and edit link |
| **Post CRUD** | Create, edit, list, delete posts |
| **Category CRUD** | Create, edit, list, delete categories |
| **Publish / draft** | Checkbox; unpublished posts never appear on the public site |
| **Featured flag** | Checkbox; featured posts can take the home hero |
| **Custom slugs** | Optional; otherwise generated from title (posts) or name (categories) |
| **Cover upload** | Optional image attachment on the post form |
| **Rich text editor** | Trix in the admin post form |
| **Excerpt** | Required, max 400 characters — used as card copy and meta description |
| **Delete confirm** | Turbo confirm before destroying a post or category |
| **Safe category delete** | Categories with posts cannot be deleted (`restrict_with_error`) |
| **Public preview links** | Published slugs and category paths open in a new tab |
| **Dark admin shell** | Sidebar: Dashboard, Posts, Categories, View Live Site, current email, Sign out |
| **Form errors** | Inline validation summary when a save fails |

### Slugs & publishing rules

- Slugs must be lowercase letters, numbers, and hyphens (`why-ruby-still-feels-like-home`)
- Unique per model; used as `to_param` so admin URLs stay readable
- Reserved slugs are blocked: `admin`, `about`, `category`, `login`, `logout`, `up`, `assets`, `rails`, `posts`, `pages`, and similar
- Public catch-all `/:slug` only matches valid slug format and never steals reserved paths
- First time a post is marked published, `published_at` is stamped automatically
- `published` scope: `published = true` **and** (`published_at` is null **or** already in the past)

### Data model

- **Posts** — title, slug, excerpt, rich body, published, published_at, featured, category, cover image
- **Categories** — name (unique), slug, description; many posts
- **Admin users** — email (unique), password digest
- Action Text for essay HTML; Active Storage for covers

### Seed content

`bin/rails db:seed` creates:

- Admin `admin@meridian.test` / `admin12345`
- Categories: **Ruby**, **Craft**, **Design**, **Essays**
- Six published sample essays (one featured)

### Engineering & ops

- Rails 8 defaults, Puma, SQLite, Propshaft asset pipeline
- Hotwire Turbo for navigation; Stimulus for theme, search, share, progress, nav
- Health check at `/up`
- CSRF + CSP meta tags
- GitHub Actions CI: Brakeman, Importmap audit, RuboCop, unit + system tests
- Dependabot config for dependency updates

---

## Requirements

- Ruby 3.3+ (`.ruby-version` pins `3.3.12`)
- Bundler

## Setup

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Then open [http://localhost:3000](http://localhost:3000).

## Admin panel

- URL: [http://localhost:3000/admin/login](http://localhost:3000/admin/login)
- Email: `admin@meridian.test`
- Password: `admin12345`

From the admin panel you can create and edit posts and categories, set slugs, upload a cover, write with the rich-text editor, publish or unpublish, feature a post on the home page, and delete content (with confirmation).

## Routes

| URL | Page |
| --- | --- |
| `/` | Journal home |
| `/:slug` | Single published essay |
| `/category/:slug` | Category archive |
| `/about` | About |
| `/up` | Health check |
| `/admin/login` | Editor sign-in |
| `/admin` | Editorial dashboard |
| `/admin/posts` | Post manager |
| `/admin/posts/new` | New post |
| `/admin/posts/:id/edit` | Edit post |
| `/admin/categories` | Category manager |
| `/admin/categories/new` | New category |
| `/admin/categories/:id/edit` | Edit category |

---

## Hire / collaborate

I'm actively open to:

**Remote Senior Full-Stack Roles · Freelance Contracts · Technical Partnerships · Long-Term Collaborations**

in **Laravel · WordPress · React/Next.js · AI-powered Platforms · Security Audits · SaaS Architecture**

📍 **Timezone:** UTC+6 (Dhaka/Rangpur) — flexible overlap for US, EU & Asia  
⚡ **Available:** Immediately · Production-first · Fast delivery · Transparent communication

| Platform | Link |
| --- | --- |
| 🌐 Portfolio | [imrandev.bd](https://imrandev.bd/) |
| 💼 LinkedIn | [linkedin.com/in/imranbru99](https://www.linkedin.com/in/imranbru99/) |
| 🐙 GitHub | [github.com/imranbru99](https://github.com/imranbru99) |
| 🐦 X / Twitter | [@imrandev_bd](https://x.com/imrandev_bd) |
| 📺 YouTube | [@ImranDevBD](https://www.youtube.com/@ImranDevBD) |
| 📸 Instagram | [@imranbru99](https://www.instagram.com/imranbru99/) |
| 📘 Facebook | [ExpertImranDev](https://www.facebook.com/ExpertImranDev/) |
| 🎵 TikTok | [@imrandev_bd](https://www.tiktok.com/@imrandev_bd) |
| 🧵 Threads | [@imranbru99](https://www.threads.com/@imranbru99) |
| 📌 Pinterest | [@imrandev_bd](https://www.pinterest.com/imrandev_bd/) |
| 💬 WhatsApp | [+880 1576-918420](http://wa.me/+8801576918420) |
| 📧 Email | [me@imrandev.bd](mailto:me@imrandev.bd) |
| 🔗 All Links | [linktr.ee/ExpertImranDev](https://linktr.ee/ExpertImranDev) |

> “Security isn't an add-on — it's the foundation. Scale, speed, and trust drive every line of code I write.”  
> — **Imran Ahmed**
