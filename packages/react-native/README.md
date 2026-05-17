# AppDesignSystem React Native

Expo-first React Native sibling package for the Swift `AppDesignSystem`.

## Usage

```tsx
import {
  AppButton,
  AppPage,
  AppSection,
  ThemeProvider,
  editorialTheme
} from "@app-design-system/react-native";

export function Screen() {
  return (
    <ThemeProvider theme={editorialTheme()}>
      <AppPage>
        <AppSection>
          <AppButton title="Continue" icon="arrow-forward" onPress={() => {}} />
        </AppSection>
      </AppPage>
    </ThemeProvider>
  );
}
```

## Included In V1

- semantic foundation tokens
- `ThemeProvider`, `useAppTheme`, `useThemeColor`
- `AppPage`, `AppSection`, `AppSectionHeader`, `AppSurface`
- core controls: button, text fields, search, toggle row, segmented control
- feedback and content primitives: banner, tag, list row, key-value row, metric, progress strip, loading state, empty state

## Catalog

The Expo catalog uses Expo SDK 55 and requires Node `>=20.19.4`.

Run:

```bash
npm run catalog --prefix packages/react-native
```
