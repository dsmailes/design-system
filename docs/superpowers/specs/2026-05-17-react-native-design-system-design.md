# React Native Design System Design

## Context

The existing `AppDesignSystem` repo is a Swift Package for SwiftUI apps. It provides semantic foundation tokens, an environment-backed theme provider, layout primitives, and reusable product UI components. The React Native equivalent should live alongside the Swift package, preserve the same design language and naming where useful, and avoid restructuring the Swift package.

## Decision Summary

Create an Expo-first TypeScript package at `packages/react-native`. The package will be hand-authored for the first version, with APIs shaped so token generation can be introduced later if Swift and React Native need to share one neutral token source.

The first version will target reusable foundation and core app primitives rather than full catalog parity.

## Goals

- Provide a reusable React Native design-system package for Expo projects.
- Preserve the Swift package's semantic model: roles, intents, emphasis, tone, spacing, radii, typography, elevation, and motion.
- Offer a familiar but idiomatic React API using providers, hooks, props, and style arrays.
- Include an Expo catalog app for visual review and component state coverage.
- Keep the initial component slice small enough to ship and iterate.

## Non-Goals

- Replacing or restructuring the Swift package.
- Generating Swift and React Native tokens from a shared source in v1.
- Porting every SwiftUI catalog component in the first pass.
- Supporting web-specific React Native behavior beyond Expo's normal compatibility.

## Repository Layout

The new package will be added as a sibling package:

```text
packages/react-native/
  package.json
  tsconfig.json
  src/
    foundation/
    theme/
    layout/
    components/
    index.ts
  example/
    app.json
    package.json
    App.tsx
```

If workspace tooling is needed, it should be added conservatively and only to support local package development and the Expo example app.

## Package Architecture

### Foundation

`src/foundation` will define the platform-neutral design primitives:

- `AppColorToken`
- `AppColorRole`
- `AppSpacing`
- `AppRadii`
- `AppTypography`
- `AppElevation`
- `AppMotion`
- shared control types such as `AppControlSize`

The default values will mirror the Swift package:

- spacing scale: `xxSmall`, `xSmall`, `small`, `medium`, `large`, `xLarge`, `xxLarge`, `pageInset`, `sectionGap`
- color roles: `canvas`, `surface`, `surfaceMuted`, `surfaceElevated`, content roles, accent roles, status roles, `border`, `separator`, `overlay`
- motion durations: `quick`, `standard`, `emphasis`, with reduced motion collapsing to near-instant transitions

### Theme

`src/theme` will expose:

- `AppTheme`
- `editorialTheme()`
- `ThemeProvider`
- `useAppTheme()`
- `useThemeColor(role)`
- helpers for resolving color tokens by scheme and contrast

`ThemeProvider` will read React Native color scheme by default. High contrast and reduced motion will be configurable through provider props so catalog screens and tests can force states that React Native does not expose consistently across platforms.

### Layout

`src/layout` will include:

- `AppPage`
- `AppSection`
- `AppSurface`
- `AppSectionHeader`

These components will provide page insets, section gaps, surface tones, bordered/elevated surfaces, and readable text hierarchy. They should use React Native primitives directly and keep layout behavior predictable on phone and tablet sizes.

### Components

The v1 component set will include:

- `AppButton`
- `AppTextField`
- `AppMultilineField`
- `AppSearchBar`
- `AppToggleRow`
- `AppSegmentedControl`
- `AppBanner`
- `AppTag`
- `AppListRow`
- `AppKeyValueRow`
- `AppMetric`
- `AppProgressStrip`
- `AppLoadingState`
- `AppEmptyState`

Deferred components:

- tab bar
- sidebar
- modal scaffold
- date picker
- menu field
- radio group
- timeline
- media and hero components
- bottom action bar

The deferred set needs more platform-specific design decisions, especially around navigation, modals, icons, and native picker behavior.

## Public API Shape

The package should feel close to the Swift design system without copying SwiftUI mechanics:

```tsx
import {
  AppButton,
  AppPage,
  AppSection,
  ThemeProvider,
  editorialTheme,
} from "@app-design-system/react-native";

export function Screen() {
  return (
    <ThemeProvider theme={editorialTheme()}>
      <AppPage>
        <AppSection>
          <AppButton
            title="Continue"
            icon="arrow-forward"
            intent="primary"
            emphasis="strong"
            onPress={() => {}}
          />
        </AppSection>
      </AppPage>
    </ThemeProvider>
  );
}
```

Buttons should keep the Swift model:

- `intent`: `primary | neutral | success | warning | critical`
- `emphasis`: `strong | subtle | ghost`
- `size`: `compact | regular | large`

Inputs should keep the Swift field-state model:

- `state`: `normal | success | warning | error`
- label, helper text, icon, placeholder, accessibility label

## Icons

The package will be Expo-first. Components that accept icons should use Expo-compatible vector icon names. The first implementation should use a single icon family consistently, with Ionicons as the default unless implementation findings suggest a better Expo-compatible fit.

Icon props should stay simple in v1. Components can accept an icon name and optional accessibility behavior, rather than requiring consumers to pass custom icon render functions everywhere.

## Accessibility

The package should preserve the Swift design system's accessible defaults:

- semantic labels for buttons and form fields
- minimum touch targets aligned with the existing control sizes
- sufficient color contrast in default themes
- explicit disabled and loading states
- reduced-motion-aware press and transition feedback
- text layouts that wrap or scale predictably without overlapping

High-contrast behavior will be supported through token resolution. Because React Native does not provide the same system contrast environment as SwiftUI, the provider will expose a `contrast` override for app integration and tests.

## Testing

The package should include focused tests for:

- color token resolution for light, dark, and high-contrast variants
- editorial theme accent overrides
- spacing scale ordering
- reduced-motion duration behavior
- button style resolution across intent/emphasis combinations
- input style resolution across field states
- smoke rendering and accessibility labels with React Native Testing Library

The Expo catalog app will provide manual visual verification for light/dark, high contrast, reduced motion, component states, and representative screen composition.

## Implementation Notes

- Prefer TypeScript types and small pure helpers for token/style resolution so behavior is testable without rendering.
- Components should consume semantic roles rather than raw hex colors.
- Keep style overrides available through standard React Native `style` props, but make the default design complete without consumer styling.
- Avoid a large abstraction layer over React Native primitives in v1.
- Keep file boundaries narrow: foundation values, theme resolution, layout components, and each reusable component should be independently understandable.

## Open Follow-Up Decisions

- Exact package name and publish strategy.
- Whether to add a root workspace manager or keep the RN package self-contained initially.
- Whether to add generated token output after the first RN package proves useful.
- Which deferred components should be ported in v2.
