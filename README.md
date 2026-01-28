# CITRIS Quest Landing Page

Flutter Web landing page for CITRIS Quest celebrating 25 years of CITRIS innovation.

## Features

- Retro pixel-art aesthetic with animated starfield background
- Responsive design (mobile, tablet, desktop)
- Single-page scroll layout with sections:
  - Hero with TestFlight download CTA
  - About CITRIS (25th anniversary)
  - How to Play (4-step guide)
  - Download (iOS TestFlight)
  - Contribute (form submission to Supabase)
  - Credits
  - Footer with legal links

## Tech Stack

- **Framework**: Flutter Web
- **Hosting**: GitHub Pages
- **Form Backend**: Supabase
- **Fonts**: Google Fonts (Tiny5, Silkscreen)

## Development

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart 3.9.2 or higher

### Setup

1. Install dependencies:

```bash
flutter pub get
```

2. Run locally (with Supabase so "By the numbers" and forms work):

```bash
flutter run -d chrome \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

Flutter web only reads these via `--dart-define` at build/run time.

3. Build for production:

```bash
flutter build web --release \
  --base-href /citris-quest-landing/ \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

## Deployment

### GitHub Pages setup

Supabase URL and anon key are **injected at build time** via GitHub Actions secrets and `--dart-define`. The built JS gets those values baked in; nothing is read at runtime from env files.

1. **Enable GitHub Pages**
   - Repo **Settings → Pages**
   - Source: **GitHub Actions** (not “Deploy from a branch”)
   - After the first successful deploy, the site will be at `https://[username].github.io/citris-quest-landing/` (or your repo name if different).

2. **Configure build: add Supabase secrets**
   - Repo **Settings → Secrets and variables → Actions**
   - Add **Repository secrets**:
     - **Name:** `SUPABASE_URL`  
       **Value:** `https://YOUR_PROJECT_REF.supabase.co`
     - **Name:** `SUPABASE_ANON_KEY`  
       **Value:** your project’s **anon/public** key from Supabase Dashboard → Project Settings → API

   If these are missing, the workflow builds with empty values and the site won’t talk to Supabase (e.g. “By the numbers” stays at 0, forms won’t submit).

3. **Deploy**
   - Push to `main`. The workflow in **`.github/workflows/deploy.yml`** builds and deploys.
   - Check the **Actions** tab to confirm “Deploy to GitHub Pages” succeeds.

### Custom Domain (Optional)

1. Add CNAME file in `web/` with your domain (e.g., `citrisquest.org`)
2. Configure DNS: CNAME record pointing to `[username].github.io`
3. Enable HTTPS in repo settings (automatic after DNS propagation)

## Project Structure

```
lib/
├── main.dart                  # Entry point
├── core/
│   ├── theme.dart             # Color palette, gradients
│   ├── typography.dart        # Font definitions
│   └── breakpoints.dart       # Responsive breakpoints
├── painters/
│   ├── starfield_painter.dart        # Animated starfield background
│   ├── pixelated_border_painter.dart # Retro border effect
│   ├── space_invader_painter.dart    # Space Invader sprite
│   ├── corner_brackets_painter.dart  # Button decorations
│   └── pixelated_circle_painter.dart # Anniversary badge
├── widgets/
│   ├── common/
│   │   ├── animated_starfield.dart   # Full-page starfield wrapper
│   │   └── primary_button.dart       # CTA button with hover effects
│   └── sections/
│       ├── hero_section.dart
│       ├── about_section.dart
│       ├── how_to_play_section.dart
│       ├── download_section.dart
│       ├── contribute_section.dart
│       ├── credits_section.dart
│       └── footer_section.dart
├── screens/
│   └── landing_page.dart      # Main single-page scroll layout
└── services/
    └── form_service.dart      # Supabase form submission
```

## Design System

### Colors

- Background: `#0A0E27` (navy)
- Primary Blue: `#1295D8`
- Cyan Accent: `#00E5FF`
- Magenta: `#FF00B8`
- Green: `#00FF88`
- Yellow: `#FFD700`

### Breakpoints

- Mobile: < 600px
- Tablet: 600-1200px
- Desktop: > 1200px

### Fonts

- Body: Tiny5 (Google Fonts)
- Headlines: Silkscreen (Google Fonts)

## Links

- **TestFlight**: https://testflight.apple.com/join/QSQXHdqH
- **Support**: https://citris-quest.notion.site/support?source=copy_link
- **Privacy Policy**: https://citris-quest.notion.site/privacy-policy?source=copy_link
- **Terms & Conditions**: https://citris-quest.notion.site/terms-and-conditions?source=copy_link

## Database / Supabase

Before deploying, ensure your Supabase project has the tables and policies the landing app needs:

- **contributions** table and RLS allowing anonymous inserts (for the Contribute form)
- **scans** and **user_profiles** with RLS policies allowing anonymous count (for “By the numbers”)

If you manage Supabase from another repo (e.g. the main app), run that project’s migrations (`supabase db push`) so these exist.

## License

© 2025 CITRIS Quest. All rights reserved.
