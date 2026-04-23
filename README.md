# AppDesignSystem

`AppDesignSystem` is a reusable Swift package for modern `SwiftUI` iOS apps. It ships a theme provider, semantic design tokens, layout primitives, and a small set of production-ready components that emphasize restrained editorial hierarchy, strong readability, and accessible defaults.

## Highlights

- `iOS 18+` and `SwiftUI-first`
- semantic theme API instead of raw color/font overrides
- Dynamic Type-friendly typography and spacing
- high-contrast and reduced-motion aware token resolution
- reusable components for common app surfaces

## Installation

Add this package to your app in Xcode using the repository URL, then import `AppDesignSystem`.

```swift
import AppDesignSystem
import SwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeProvider(theme: .editorial()) {
                ContentView()
            }
        }
    }
}
```

## Quick Start

```swift
import AppDesignSystem
import SwiftUI

struct ContentView: View {
    var body: some View {
        AppPage {
            AppTopBar(
                eyebrow: "Workspace",
                title: "Focus stays on the work.",
                detail: "Use semantic surfaces and typography instead of ad hoc styling."
            )

            AppSection {
                AppSectionHeader(
                    title: "Primary actions",
                    detail: "Buttons carry intent, emphasis, and size rather than raw colors."
                )

                HStack(spacing: 12) {
                    AppButton("Continue", systemImage: "arrow.right") { }
                    AppButton(
                        "Secondary",
                        intent: .neutral,
                        emphasis: .subtle
                    ) { }
                }
            }

            AppSection {
                AppBanner(
                    title: "Ready for adoption",
                    message: "This package can be added to a clean app with one import and one theme provider.",
                    tone: .accent
                )
            }
        }
    }
}
```

## Theming

`ThemeProvider` injects an `AppTheme` into the environment. Start with the editorial preset, then override only the values your app needs.

```swift
let productTheme = AppTheme.editorial(
    accent: AppColorToken(
        light: "#245CFF",
        dark: "#8EAEFF",
        lightHighContrast: "#103FCC",
        darkHighContrast: "#C7D7FF"
    )
)
```

## Included Building Blocks

- `ThemeProvider`
- `AppPage`
- `AppPosterHero`
- `AppSection`
- `AppSplitWorkspace`
- `AppEditorialHero`
- `AppInspectorPanel`
- `AppTopBar`
- `AppScreenHeader`
- `AppButton`
- `AppTextField`
- `AppMultilineField`
- `AppDateField`
- `AppStepperRow`
- `AppSearchBar`
- `AppToggleRow`
- `AppMenuField`
- `AppRadioGroup`
- `AppSegmentedControl`
- `AppTabBar`
- `AppSidebarSection`
- `AppSidebarItem`
- `AppAvatar`
- `AppHeroImage`
- `AppMediaBlock`
- `AppBanner`
- `AppStatePanel`
- `AppValidationSummary`
- `AppTag`
- `AppListRow`
- `AppKeyValueRow`
- `AppSummaryPanel`
- `AppActionPanel`
- `AppMetric`
- `AppProgressStrip`
- `AppTimelineRow`
- `AppLoadingState`
- `AppBottomActionBar`
- `AppModalScaffold`
- `AppEmptyState`
- `AppSectionHeader`
- `AppFormScaffold`
- `AppGroupedListSection`

## Preview Catalog

Open the package in Xcode and inspect `AppDesignSystemCatalogView` previews for a reference screen that shows the default theme, layout rhythm, and component states.
