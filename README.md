## Findoc Assignment – Flutter (BLoC, Validation)

### Overview
Two-screen Flutter app using BLoC state management:
- Login screen with email/password validation.
- Home screen that fetches 10 images from `https://picsum.photos/` and displays them in a vertically padded list.

### Requirements implemented
- **Login**: Email, Password, Submit button
  - Email must be a valid format
  - Password must be at least 8 characters, contain uppercase, lowercase, number, and symbol
- **Navigation**: On successful login → Home screen
- **Home**: Fetch 10 Picsum images; image width matches screen, height respects aspect ratio
  - Title: Montserrat Semi-Bold, dark text (set as fixed text per request)
  - Description: Montserrat Regular, dark grey, max 2 lines

### Tech stack
- Flutter, Dart
- State management: `flutter_bloc`
- HTTP: `http`
- Images: `cached_network_image`
- Fonts: `google_fonts` (Montserrat)

### Project structure
```
lib/
  main.dart                       # App setup, DI for BLoC and repository
  src/
    login/
      bloc/                       # Login BLoC, events, states
        login_bloc.dart
        login_event.dart
        login_state.dart
      view/
        login_screen.dart         # UI + BLoC wiring
    home/
      data/
        picsum_repository.dart    # API integration
      model/
        picsum_image.dart         # Model
      view/
        home_screen.dart          # List UI, proportional padding
```

### Run locally
```bash
flutter pub get
flutter run -d <device_id>
```
Useful:
```bash
flutter devices             # list devices
flutter run -d chrome       # run on web
flutter run -d windows      # run on Windows desktop
```

### Build release APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Tests and lint
```bash
flutter analyze
flutter test
```

### Dependencies
Declared in `pubspec.yaml`:
- `flutter_bloc`, `equatable`, `http`, `cached_network_image`, `google_fonts`

### API
- GET `https://picsum.photos/v2/list?page=1&limit=10`
