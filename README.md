# Flutter Template

Template project Flutter với Clean Architecture, được thiết kế để clone nhanh cho các dự án mới.

## Yêu cầu

- [FVM](https://fvm.app/) (Flutter Version Management)
- Flutter 3.35.7 (được quản lý bởi FVM)
- Dart SDK ^3.8.1

## Bắt đầu nhanh

```bash
# Clone template
git clone <repository-url> <new-project-name>
cd <new-project-name>

# Cài đặt Flutter version
fvm install

# Cài đặt dependencies
fvm flutter pub get

# Chạy code generation
fvm dart run build_runner build --delete-conflicting-outputs

# Chạy app
fvm flutter run
```

## Cấu trúc Project

```
├── lib/
│   ├── app/                          # Application layer
│   │   ├── dependencies/             # Dependency Injection (GetIt + Injectable)
│   │   ├── route/                    # Navigation (GoRouter + go_router_builder)
│   │   ├── services/                 # App services (localization, theme, storage)
│   │   ├── extensions/               # App context extensions
│   │   └── mediator/                 # Cross-module communication
│   │
│   ├── business/                     # Business logic layer
│   │   ├── data/                     # Models, DataSources, Repository implementations
│   │   └── domain/                   # Entities, Repository interfaces, UseCases
│   │
│   ├── core/                         # Core module (shared)
│   │   ├── classes/                  # Base interfaces (IEntity, IRepository...)
│   │   ├── constants/                # Constants (Environment)
│   │   ├── extensions/               # Dart extensions
│   │   ├── presentation/             # Reusable UI widgets
│   │   ├── theme/                    # Material 3 theme
│   │   └── utils/                    # Utilities (Either, Debouncer...)
│   │
│   ├── features/                     # Feature modules
│   │   ├── home/                     # Home feature
│   │   └── shared_presentation/      # Shared screens (Root, Splash, Error)
│   │
│   ├── gen/                          # Generated files (flutter_gen)
│   └── main.dart                     # Entry point
│
├── core_extension/                   # Workspace: Dart extensions
├── core_widget/                      # Workspace: Reusable widgets
├── icon/                             # Workspace: Icon assets
│
├── assets/
│   ├── images/                       # Image assets
│   ├── fonts/                        # Font files (Roboto)
│   └── translations/                 # Localization files (vi, en)
│
└── test/                             # Unit tests
```

## Kiến trúc & Patterns

### Clean Architecture
- **Presentation**: Screens, Widgets, BLoCs
- **Domain**: Entities, UseCases, Repository interfaces
- **Data**: Models, DataSources, Repository implementations

### State Management
- **Flutter Bloc** - State management chính
- **RxDart** - Reactive programming
- **dart_mediator** - Cross-module communication

### Dependency Injection
- **GetIt** + **Injectable** với code generation
- Config tại `lib/app/dependencies/`

### Navigation
- **GoRouter** với **go_router_builder** (type-safe routes)
- Routes tại `lib/app/route/route.dart`

### Theme & Localization
- Material 3 theme system
- Easy Localization (vi, en)

## Commands

```bash
# Chạy app
fvm flutter run                              # Flavor prod (default)
fvm flutter run --flavor dev                 # Flavor dev
fvm flutter run --flavor prod                # Flavor prod

# Code generation
fvm dart run build_runner build --delete-conflicting-outputs
fvm dart run build_runner watch --delete-conflicting-outputs  # Watch mode

# Testing
fvm flutter test                             # Chạy tất cả tests
fvm flutter test test/env_test.dart          # Chạy single test

# Analyze & Format
fvm flutter analyze
fvm dart format . --line-length 80

# Generate assets
fvm dart run flutter_launcher_icons          # App icons
fvm dart run flutter_native_splash:create    # Splash screen
```

## Cấu hình cho Project mới

### 1. Đổi tên package
```bash
# Đổi package name (Android)
fvm dart run change_app_package_name:main com.company.newapp

# Đổi tên app
fvm dart run rename setAppName --targets ios,android --value "New App Name"
```

### 2. Cập nhật Bundle ID (iOS)
Mở Xcode và thay đổi Bundle Identifier trong Runner target.

### 3. Cấu hình Environment
Tạo/cập nhật các file:
- `.env` - Environment chung
- `.env.dev` - Development
- `.env.prod` - Production

### 4. Cấu hình Flavors
- **Android**: `android/app/build.gradle.kts`
- **iOS**: Xcode Schemes

### 5. App Icons & Splash
```bash
# Cập nhật file cấu hình
# - flutter_launcher_icons.yaml (hoặc trong pubspec.yaml)
# - flutter_native_splash.yaml

# Generate
fvm dart run flutter_launcher_icons
fvm dart run flutter_native_splash:create
```

### 6. Chạy Code Generation
```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

## Flavors

| Flavor | App Name | App ID Suffix | Mô tả |
|--------|----------|---------------|-------|
| prod | Template | (none) | Production build |
| dev | Template Dev | .dev | Development build với flavor banner |

## Workspace Packages

Project sử dụng Dart workspace với 3 packages:

| Package | Mô tả |
|---------|-------|
| `core_extension` | Dart extensions dùng chung |
| `core_widget` | Flutter widgets dùng chung |
| `icon` | Icon assets (Phosphor, Iconify) |

## App Extensions

Truy cập qua `App.*`:

```dart
// Navigation
App.router                    // GoRouter instance
App.go(location)              // Navigate
App.push<T>(location)         // Push route
App.pop<T>()                  // Pop route

// Overlays
App.showDialog(...)           // Show dialog
App.showBottomSheet(...)      // Show bottom sheet
App.showLoading()             // Show loading

// Debug
App.debug(message)            // Log với Talker
```

## Code Generation

Chạy build_runner sau khi thay đổi:
- Models với `@freezed` hoặc `@JsonSerializable`
- Routes với `@TypedGoRoute`
- DI với `@injectable`, `@singleton`, `@lazySingleton`
- Retrofit API clients

Output:
- `*.g.dart` - JSON serialization, Retrofit
- `*.freezed.dart` - Immutable models
- `route.g.dart` - Type-safe routes
- `injectable.config.dart` - DI configuration
- `lib/gen/` - Assets, fonts, translations

## Resources

- [Flutter Bloc](https://bloclibrary.dev/)
- [GoRouter](https://pub.dev/packages/go_router)
- [Injectable](https://pub.dev/packages/injectable)
- [Freezed](https://pub.dev/packages/freezed)
- [Easy Localization](https://pub.dev/packages/easy_localization)
