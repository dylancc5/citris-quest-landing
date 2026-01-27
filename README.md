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

2. Run locally:
```bash
flutter run -d chrome
```

3. Build for production:
```bash
flutter build web --release
```

## Deployment

### GitHub Pages Setup

1. **Enable GitHub Pages**:
   - Go to repository Settings → Pages
   - Source: GitHub Actions (not branch)
   - URL will be: `https://[username].github.io/citris-quest-landing/`

2. **Add Supabase Secrets**:
   - Go to Settings → Secrets and variables → Actions
   - Add secrets:
     - `SUPABASE_URL`: Your Supabase project URL
     - `SUPABASE_ANON_KEY`: Your Supabase anonymous key

3. **Deploy**:
   - Push to `main` branch
   - GitHub Actions will automatically build and deploy
   - Check Actions tab for deployment status

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

## Database Migration

Before deploying, ensure the `contributions` table exists in Supabase:

```bash
# From the main app directory (citris_quest):
supabase db push
```

This creates the contributions table with RLS policies allowing anonymous inserts.

## License

© 2025 CITRIS Quest. All rights reserved.
