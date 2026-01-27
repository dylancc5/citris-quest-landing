# CITRIS Quest Landing Page - Implementation Status

## ✅ COMPLETED (Phase 1 & 2)

### Core Setup
- ✅ Flutter project created (`citris_quest_landing`)
- ✅ Dependencies installed (google_fonts, url_launcher, supabase_flutter, visibility_detector)
- ✅ Directory structure created
- ✅ Supabase migration created (`20260126_create_contributions_table.sql`)

### Core Files
- ✅ `lib/core/theme.dart` - Copied from main app
- ✅ `lib/core/typography.dart` - Copied from main app
- ✅ `lib/core/breakpoints.dart` - NEW responsive system

### Painters
- ✅ `lib/painters/starfield_painter.dart` - Copied
- ✅ `lib/painters/pixelated_border_painter.dart` - Copied
- ✅ `lib/painters/space_invader_painter.dart` - Copied
- ✅ `lib/painters/corner_brackets_painter.dart` - Copied

### Common Widgets
- ✅ `lib/widgets/common/animated_starfield.dart` - Full-page wrapper with responsive particle count
- ✅ `lib/widgets/common/primary_button.dart` - With hover glow effects

### Sections
- ✅ `lib/widgets/sections/hero_section.dart` - Floating Space Invader + CTA
- ✅ `lib/widgets/sections/about_section.dart` - 25th anniversary badge + description

### Entry Point
- ✅ `lib/main.dart` - Supabase initialization + MaterialApp setup

---

## ⚠️ TODO (Phase 3-5)

### Missing Painter
- [ ] Copy `pixelated_circle_painter.dart` from main app
  ```bash
  cp ../citris_quest/lib/ui/widgets/painters/pixelated_circle_painter.dart lib/painters/
  ```

### Remaining Sections (Priority Order)

1. **Landing Page Layout** (`lib/screens/landing_page.dart`)
   - Single-page scroll with all sections
   - AnimatedStarfield background
   - VisibilityDetector for lazy loading
   - Section spacing (80/120/160px by breakpoint)

2. **How to Play Section** (`lib/widgets/sections/how_to_play_section.dart`)
   - 4-step grid (responsive columns)
   - Icons: Space Invader, compass, coins, trophy
   - Placeholder images (400x800px)
   - Scroll-triggered fade-in

3. **Download Section** (`lib/widgets/sections/download_section.dart`)
   - Headline: "Join the Beta"
   - 4-step TestFlight instructions
   - CTA → `https://testflight.apple.com/join/QSQXHdqH`

4. **Contribute Section** (`lib/widgets/sections/contribute_section.dart`)
   - Form: Name, Email, Type (dropdown), Message
   - FormService integration
   - Success/error states

5. **Credits Section** (`lib/widgets/sections/credits_section.dart`)
   - 3-column grid (responsive)
   - Categories: Dev Team, CITRIS, OSS, ML, Artists
   - Space Invader avatars with unique colors

6. **Footer Section** (`lib/widgets/sections/footer_section.dart`)
   - Legal links (Notion URLs)
   - Social icons (GitHub, Email)
   - Copyright notice

### Services
- [ ] `lib/services/form_service.dart` - Supabase contributions insert

### Assets
- [ ] Create 4 placeholder images (400x800px):
  - `assets/images/placeholder_scan_1.png`
  - `assets/images/placeholder_scan_2.png`
  - `assets/images/placeholder_scan_3.png`
  - `assets/images/placeholder_scan_4.png`

### Web Configuration
- [ ] Update `web/index.html` with SEO meta tags
- [ ] Create `web/manifest.json` for PWA

### Deployment
- [ ] Create `.github/workflows/deploy.yml`
- [ ] Set GitHub Secrets (SUPABASE_URL, SUPABASE_ANON_KEY)
- [ ] Enable GitHub Pages in repo settings

### Database
- [ ] Run Supabase migration in main app repo:
  ```bash
  cd ../citris_quest
  supabase db push
  ```

---

## 🔗 Quick Reference

### Notion URLs (for Footer)
```dart
'https://citris-quest.notion.site/support?source=copy_link'
'https://citris-quest.notion.site/privacy-policy?source=copy_link'
'https://citris-quest.notion.site/terms-and-conditions?source=copy_link'
```

### TestFlight URL (for Download Section)
```dart
'https://testflight.apple.com/join/QSQXHdqH'
```

### Contribution Types (for Form Dropdown)
```dart
['Artwork Submission', 'CV Model Improvements', 'General Ideas', 'Bug Reports']
```

---

## 🧪 Testing Commands

```bash
# Local development
flutter run -d chrome \
  --dart-define=SUPABASE_URL=your_url \
  --dart-define=SUPABASE_ANON_KEY=your_key

# Production build
flutter build web --release \
  --web-renderer canvaskit \
  --base-href /citris_quest_landing/ \
  --dart-define=SUPABASE_URL=$SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY

# Analyze code
flutter analyze

# Check outdated packages
flutter pub outdated
```

---

## 📊 Progress: 40% Complete

**Completed**: 9/22 files
**Remaining**: 13 files + deployment setup

**Estimated Time to MVP**: 6-8 hours
- Sections: 4 hours
- Form service: 30 minutes
- Layout integration: 1 hour
- Assets + web config: 1 hour
- Deployment setup: 30 minutes
- Testing: 1 hour

---

## 🎯 Next Immediate Steps

1. Copy `pixelated_circle_painter.dart`
2. Create `landing_page.dart` skeleton
3. Implement `how_to_play_section.dart`
4. Implement `download_section.dart`
5. Implement `contribute_section.dart` + `form_service.dart`
6. Complete remaining sections
7. Create placeholder images
8. Configure web files
9. Setup GitHub Actions
10. Test & deploy

---

Full implementation plan: `~/.claude/plans/temporal-riding-waffle.md`
