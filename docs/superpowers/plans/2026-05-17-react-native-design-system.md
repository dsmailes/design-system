# React Native Design System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build an Expo-first React Native sibling package that mirrors the Swift design system's foundation, theme, layout primitives, and v1 core components.

**Architecture:** Add `packages/react-native` without restructuring the Swift package. Keep foundation and theme resolution in small pure TypeScript modules, then build React Native components on top of semantic roles. Use an Expo example app as the catalog and manual visual verification surface.

**Tech Stack:** TypeScript, React Native, Expo-compatible peer dependencies, `@expo/vector-icons`, Jest, React Native Testing Library.

---

## File Structure

Create:

- `packages/react-native/package.json`: package scripts, peer dependencies, dev dependencies, and export metadata.
- `packages/react-native/tsconfig.json`: TypeScript config for source, tests, and example imports.
- `packages/react-native/jest.config.js`: Jest configuration using `jest-expo`.
- `packages/react-native/jest.setup.ts`: React Native Testing Library setup.
- `packages/react-native/src/foundation/colors.ts`: color token and color role types, token resolver.
- `packages/react-native/src/foundation/spacing.ts`: spacing scale.
- `packages/react-native/src/foundation/radii.ts`: radius scale.
- `packages/react-native/src/foundation/typography.ts`: text style tokens and style resolver.
- `packages/react-native/src/foundation/elevation.ts`: shadow/elevation defaults.
- `packages/react-native/src/foundation/motion.ts`: motion durations and reduced-motion resolver.
- `packages/react-native/src/foundation/controls.ts`: shared control size values.
- `packages/react-native/src/foundation/index.ts`: foundation exports.
- `packages/react-native/src/theme/theme.ts`: `AppTheme`, `editorialTheme`, and theme override helpers.
- `packages/react-native/src/theme/ThemeProvider.tsx`: context provider and hooks.
- `packages/react-native/src/theme/index.ts`: theme exports.
- `packages/react-native/src/internal/AppText.tsx`: internal themed text primitive.
- `packages/react-native/src/internal/styleUtils.ts`: helpers for merging style arrays and testable style resolution.
- `packages/react-native/src/layout/AppSurface.tsx`: surface wrapper.
- `packages/react-native/src/layout/AppPage.tsx`: scrollable page shell.
- `packages/react-native/src/layout/AppSection.tsx`: section shell.
- `packages/react-native/src/layout/AppSectionHeader.tsx`: reusable section heading.
- `packages/react-native/src/layout/index.ts`: layout exports.
- `packages/react-native/src/components/AppButton.tsx`: button component and style resolver.
- `packages/react-native/src/components/AppTextField.tsx`: single-line field.
- `packages/react-native/src/components/AppMultilineField.tsx`: multiline field.
- `packages/react-native/src/components/AppSearchBar.tsx`: search field.
- `packages/react-native/src/components/AppToggleRow.tsx`: switch row.
- `packages/react-native/src/components/AppSegmentedControl.tsx`: segmented selector.
- `packages/react-native/src/components/AppBanner.tsx`: feedback banner.
- `packages/react-native/src/components/AppTag.tsx`: compact label.
- `packages/react-native/src/components/AppListRow.tsx`: list row shell.
- `packages/react-native/src/components/AppKeyValueRow.tsx`: key-value display row.
- `packages/react-native/src/components/AppMetric.tsx`: compact metric display.
- `packages/react-native/src/components/AppProgressStrip.tsx`: progress summary.
- `packages/react-native/src/components/AppLoadingState.tsx`: loading placeholder state.
- `packages/react-native/src/components/AppEmptyState.tsx`: empty state prompt.
- `packages/react-native/src/components/index.ts`: component exports.
- `packages/react-native/src/index.ts`: public package exports.
- `packages/react-native/src/__tests__/foundation.test.ts`: foundation behavior tests.
- `packages/react-native/src/__tests__/theme.test.tsx`: provider and hook tests.
- `packages/react-native/src/__tests__/components.test.tsx`: component smoke and accessibility tests.
- `packages/react-native/example/package.json`: Expo catalog app package.
- `packages/react-native/example/app.json`: Expo app config.
- `packages/react-native/example/App.tsx`: catalog screen.
- `packages/react-native/README.md`: RN package usage notes.

Modify:

- `.gitignore`: add React Native package build, dependency, and Expo local outputs if missing.
- `README.md`: mention the React Native sibling package after it exists.

---

### Task 1: Package Scaffold

**Files:**
- Create: `packages/react-native/package.json`
- Create: `packages/react-native/tsconfig.json`
- Create: `packages/react-native/jest.config.js`
- Create: `packages/react-native/jest.setup.ts`
- Modify: `.gitignore`

- [ ] **Step 1: Create package metadata**

Create `packages/react-native/package.json`:

```json
{
  "name": "@app-design-system/react-native",
  "version": "0.1.0",
  "private": true,
  "description": "Expo-first React Native design system mirroring AppDesignSystem.",
  "main": "src/index.ts",
  "types": "src/index.ts",
  "scripts": {
    "typecheck": "tsc --noEmit",
    "test": "jest --runInBand",
    "test:watch": "jest --watch",
    "catalog": "npm --prefix example run start"
  },
  "peerDependencies": {
    "@expo/vector-icons": "*",
    "expo": "*",
    "react": "*",
    "react-native": "*"
  },
  "devDependencies": {
    "@testing-library/react-native": "^13.0.0",
    "@types/jest": "^29.5.14",
    "@types/react": "^19.0.0",
    "jest": "^29.7.0",
    "jest-expo": "^53.0.0",
    "react": "^19.0.0",
    "react-native": "^0.79.0",
    "react-test-renderer": "^19.0.0",
    "typescript": "^5.8.0"
  }
}
```

- [ ] **Step 2: Create TypeScript config**

Create `packages/react-native/tsconfig.json`:

```json
{
  "compilerOptions": {
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "jsx": "react-jsx",
    "lib": ["ES2022"],
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "noEmit": true,
    "resolveJsonModule": true,
    "skipLibCheck": true,
    "strict": true,
    "target": "ES2022",
    "types": ["jest", "react"]
  },
  "include": ["src", "jest.setup.ts", "example/App.tsx"]
}
```

- [ ] **Step 3: Create Jest config**

Create `packages/react-native/jest.config.js`:

```js
module.exports = {
  preset: "jest-expo",
  setupFilesAfterEnv: ["<rootDir>/jest.setup.ts"],
  testMatch: ["<rootDir>/src/**/__tests__/**/*.test.ts?(x)"],
  transformIgnorePatterns: [
    "node_modules/(?!((jest-)?react-native|@react-native|expo(nent)?|@expo(nent)?/.*|@expo/.*|@unimodules/.*|unimodules|sentry-expo|native-base|react-native-svg))"
  ]
};
```

- [ ] **Step 4: Create Jest setup**

Create `packages/react-native/jest.setup.ts`:

```ts
import "@testing-library/react-native/extend-expect";
```

- [ ] **Step 5: Update `.gitignore`**

Add these lines to `.gitignore` if they are not already present:

```gitignore
node_modules/
packages/react-native/example/.expo/
packages/react-native/example/dist/
packages/react-native/.expo/
packages/react-native/coverage/
```

- [ ] **Step 6: Install package dependencies**

Run:

```bash
npm install --prefix packages/react-native
```

Expected: dependencies install and `packages/react-native/package-lock.json` is created.

- [ ] **Step 7: Run initial checks**

Run:

```bash
npm test --prefix packages/react-native
npm run typecheck --prefix packages/react-native
```

Expected: Jest reports no tests found or passes once later tests exist. TypeScript may fail until source files exist; record the failure and proceed to Task 2.

- [ ] **Step 8: Commit scaffold**

Run:

```bash
git add .gitignore packages/react-native/package.json packages/react-native/package-lock.json packages/react-native/tsconfig.json packages/react-native/jest.config.js packages/react-native/jest.setup.ts
git commit -m "Add React Native package scaffold"
```

---

### Task 2: Foundation Tokens

**Files:**
- Create: `packages/react-native/src/__tests__/foundation.test.ts`
- Create: `packages/react-native/src/foundation/colors.ts`
- Create: `packages/react-native/src/foundation/spacing.ts`
- Create: `packages/react-native/src/foundation/radii.ts`
- Create: `packages/react-native/src/foundation/typography.ts`
- Create: `packages/react-native/src/foundation/elevation.ts`
- Create: `packages/react-native/src/foundation/motion.ts`
- Create: `packages/react-native/src/foundation/controls.ts`
- Create: `packages/react-native/src/foundation/index.ts`

- [ ] **Step 1: Write foundation tests**

Create `packages/react-native/src/__tests__/foundation.test.ts`:

```ts
import {
  AppSpacing,
  AppMotion,
  resolveColorToken,
  textStyle,
  controlSize,
  type AppColorToken
} from "../foundation";

describe("foundation tokens", () => {
  it("uses high contrast color overrides", () => {
    const token: AppColorToken = {
      light: "#111111",
      dark: "#eeeeee",
      lightHighContrast: "#000000",
      darkHighContrast: "#ffffff"
    };

    expect(resolveColorToken(token, "light", "increased")).toBe("#000000");
    expect(resolveColorToken(token, "dark", "increased")).toBe("#ffffff");
    expect(resolveColorToken(token, "dark", "normal")).toBe("#eeeeee");
  });

  it("orders the spacing scale", () => {
    expect(AppSpacing.xxSmall).toBeLessThan(AppSpacing.small);
    expect(AppSpacing.small).toBeLessThan(AppSpacing.large);
    expect(AppSpacing.large).toBeLessThan(AppSpacing.xxLarge);
    expect(AppSpacing.pageInset).toBeLessThanOrEqual(AppSpacing.sectionGap);
  });

  it("collapses motion duration when reduced motion is enabled", () => {
    expect(AppMotion.duration(true)).toBe(0.01);
    expect(AppMotion.duration(false, true)).toBe(AppMotion.emphasis);
  });

  it("returns stable typography styles", () => {
    expect(textStyle("body").fontSize).toBe(17);
    expect(textStyle("bodyEmphasis").fontWeight).toBe("600");
    expect(textStyle("numeric").fontVariant).toEqual(["tabular-nums"]);
  });

  it("returns stable control sizes", () => {
    expect(controlSize("compact").minHeight).toBe(44);
    expect(controlSize("regular").horizontalPadding).toBe(18);
    expect(controlSize("large").minHeight).toBe(56);
  });
});
```

- [ ] **Step 2: Run foundation tests to verify failure**

Run:

```bash
npm test --prefix packages/react-native -- foundation.test.ts
```

Expected: FAIL because `../foundation` does not exist.

- [ ] **Step 3: Implement color tokens**

Create `packages/react-native/src/foundation/colors.ts`:

```ts
export type AppColorScheme = "light" | "dark";
export type AppColorContrast = "normal" | "increased";

export type AppColorToken = {
  light: string;
  dark: string;
  lightHighContrast?: string;
  darkHighContrast?: string;
};

export type AppColorRole =
  | "canvas"
  | "surface"
  | "surfaceMuted"
  | "surfaceElevated"
  | "contentPrimary"
  | "contentSecondary"
  | "contentTertiary"
  | "accent"
  | "accentSecondary"
  | "accentTertiary"
  | "accentEmphasis"
  | "accentForeground"
  | "success"
  | "warning"
  | "critical"
  | "border"
  | "separator"
  | "overlay";

export function colorToken(token: AppColorToken): Required<AppColorToken> {
  return {
    light: token.light,
    dark: token.dark,
    lightHighContrast: token.lightHighContrast ?? token.light,
    darkHighContrast: token.darkHighContrast ?? token.dark
  };
}

export function resolveColorToken(
  token: AppColorToken,
  scheme: AppColorScheme,
  contrast: AppColorContrast = "normal"
): string {
  const resolved = colorToken(token);
  if (scheme === "light" && contrast === "increased") {
    return resolved.lightHighContrast;
  }
  if (scheme === "dark" && contrast === "increased") {
    return resolved.darkHighContrast;
  }
  return scheme === "dark" ? resolved.dark : resolved.light;
}
```

- [ ] **Step 4: Implement spacing**

Create `packages/react-native/src/foundation/spacing.ts`:

```ts
export const AppSpacing = {
  xxSmall: 4,
  xSmall: 8,
  small: 12,
  medium: 16,
  large: 24,
  xLarge: 32,
  xxLarge: 48,
  pageInset: 20,
  sectionGap: 28
} as const;

export type AppSpacing = typeof AppSpacing;
```

- [ ] **Step 5: Implement radii**

Create `packages/react-native/src/foundation/radii.ts`:

```ts
export const AppRadii = {
  small: 12,
  medium: 18,
  large: 28,
  pill: 999
} as const;

export type AppRadii = typeof AppRadii;
```

- [ ] **Step 6: Implement typography**

Create `packages/react-native/src/foundation/typography.ts`:

```ts
import type { TextStyle } from "react-native";

export type AppTextStyle =
  | "eyebrow"
  | "display"
  | "title"
  | "section"
  | "body"
  | "bodyEmphasis"
  | "detail"
  | "caption"
  | "numeric";

const styles: Record<AppTextStyle, TextStyle> = {
  eyebrow: {
    fontSize: 12,
    lineHeight: 16,
    fontWeight: "600",
    letterSpacing: 0.8,
    textTransform: "uppercase"
  },
  display: {
    fontSize: 34,
    lineHeight: 41,
    fontWeight: "700",
    letterSpacing: 0
  },
  title: {
    fontSize: 22,
    lineHeight: 28,
    fontWeight: "600",
    letterSpacing: 0
  },
  section: {
    fontSize: 17,
    lineHeight: 22,
    fontWeight: "600",
    letterSpacing: 0
  },
  body: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: "400",
    letterSpacing: 0
  },
  bodyEmphasis: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: "600",
    letterSpacing: 0
  },
  detail: {
    fontSize: 16,
    lineHeight: 22,
    fontWeight: "400",
    letterSpacing: 0
  },
  caption: {
    fontSize: 13,
    lineHeight: 18,
    fontWeight: "400",
    letterSpacing: 0
  },
  numeric: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: "500",
    letterSpacing: 0,
    fontVariant: ["tabular-nums"]
  }
};

export function textStyle(style: AppTextStyle): TextStyle {
  return styles[style];
}
```

- [ ] **Step 7: Implement elevation**

Create `packages/react-native/src/foundation/elevation.ts`:

```ts
export const AppElevation = {
  restingOpacity: 0,
  floatingOpacity: 0.12,
  floatingRadius: 28,
  floatingY: 12
} as const;

export type AppElevation = typeof AppElevation;
```

- [ ] **Step 8: Implement motion**

Create `packages/react-native/src/foundation/motion.ts`:

```ts
export const AppMotion = {
  quick: 0.16,
  standard: 0.24,
  emphasis: 0.34,
  duration(reduceMotion: boolean, emphasis = false) {
    if (reduceMotion) {
      return 0.01;
    }
    return emphasis ? this.emphasis : this.standard;
  }
} as const;
```

- [ ] **Step 9: Implement control sizes**

Create `packages/react-native/src/foundation/controls.ts`:

```ts
export type AppControlSize = "compact" | "regular" | "large";

export type AppControlMetrics = {
  minHeight: number;
  horizontalPadding: number;
  iconDimension: number;
};

const sizes: Record<AppControlSize, AppControlMetrics> = {
  compact: {
    minHeight: 44,
    horizontalPadding: 14,
    iconDimension: 15
  },
  regular: {
    minHeight: 50,
    horizontalPadding: 18,
    iconDimension: 17
  },
  large: {
    minHeight: 56,
    horizontalPadding: 22,
    iconDimension: 18
  }
};

export function controlSize(size: AppControlSize): AppControlMetrics {
  return sizes[size];
}
```

- [ ] **Step 10: Export foundation**

Create `packages/react-native/src/foundation/index.ts`:

```ts
export * from "./colors";
export * from "./spacing";
export * from "./radii";
export * from "./typography";
export * from "./elevation";
export * from "./motion";
export * from "./controls";
```

- [ ] **Step 11: Run tests and typecheck**

Run:

```bash
npm test --prefix packages/react-native -- foundation.test.ts
npm run typecheck --prefix packages/react-native
```

Expected: foundation tests PASS. Typecheck may still fail until public exports exist; record exact failure and continue to Task 3.

- [ ] **Step 12: Commit foundation tokens**

Run:

```bash
git add packages/react-native/src/foundation packages/react-native/src/__tests__/foundation.test.ts
git commit -m "Add React Native foundation tokens"
```

---

### Task 3: Theme Provider And Hooks

**Files:**
- Create: `packages/react-native/src/__tests__/theme.test.tsx`
- Create: `packages/react-native/src/theme/theme.ts`
- Create: `packages/react-native/src/theme/ThemeProvider.tsx`
- Create: `packages/react-native/src/theme/index.ts`
- Create: `packages/react-native/src/index.ts`

- [ ] **Step 1: Write theme tests**

Create `packages/react-native/src/__tests__/theme.test.tsx`:

```tsx
import React from "react";
import { Text } from "react-native";
import { render } from "@testing-library/react-native";
import {
  ThemeProvider,
  editorialTheme,
  resolveThemeColor,
  useAppTheme,
  useThemeColor
} from "../theme";
import type { AppColorToken } from "../foundation";

function ThemeProbe() {
  const theme = useAppTheme();
  const color = useThemeColor("accent");
  return <Text testID="probe">{theme.spacing.medium}:{color}</Text>;
}

describe("theme", () => {
  it("resolves default editorial colors", () => {
    const theme = editorialTheme();
    expect(resolveThemeColor(theme, "contentPrimary", "light", "normal")).toBe("#171411");
    expect(resolveThemeColor(theme, "contentPrimary", "dark", "normal")).toBe("#F5F2EB");
  });

  it("accepts accent overrides", () => {
    const accent: AppColorToken = {
      light: "#245CFF",
      dark: "#8EAEFF",
      lightHighContrast: "#103FCC",
      darkHighContrast: "#C7D7FF"
    };
    const theme = editorialTheme({ accent });
    expect(resolveThemeColor(theme, "accent", "light", "increased")).toBe("#103FCC");
  });

  it("provides theme and resolved colors through hooks", () => {
    const screen = render(
      <ThemeProvider scheme="light" contrast="normal">
        <ThemeProbe />
      </ThemeProvider>
    );

    expect(screen.getByTestId("probe")).toHaveTextContent("16:#2A6F62");
  });
});
```

- [ ] **Step 2: Run theme tests to verify failure**

Run:

```bash
npm test --prefix packages/react-native -- theme.test.tsx
```

Expected: FAIL because `../theme` does not exist.

- [ ] **Step 3: Implement theme model**

Create `packages/react-native/src/theme/theme.ts`:

```ts
import {
  AppElevation,
  AppMotion,
  AppRadii,
  AppSpacing,
  resolveColorToken,
  type AppColorContrast,
  type AppColorRole,
  type AppColorScheme,
  type AppColorToken
} from "../foundation";

export type AppThemeColors = Record<AppColorRole, AppColorToken>;

export type AppTheme = {
  colors: AppThemeColors;
  spacing: typeof AppSpacing;
  radii: typeof AppRadii;
  elevation: typeof AppElevation;
  motion: typeof AppMotion;
};

export type EditorialThemeOptions = {
  accent?: AppColorToken;
  accentEmphasis?: AppColorToken;
  accentForeground?: AppColorToken;
};

export function editorialTheme(options: EditorialThemeOptions = {}): AppTheme {
  return {
    colors: {
      canvas: { light: "#F5F2EB", dark: "#111111", lightHighContrast: "#FFFFFF", darkHighContrast: "#000000" },
      surface: { light: "#FEFCF7", dark: "#171717", lightHighContrast: "#FFFFFF", darkHighContrast: "#0E0E0E" },
      surfaceMuted: { light: "#ECE6DA", dark: "#202020", lightHighContrast: "#E2DACD", darkHighContrast: "#262626" },
      surfaceElevated: { light: "#FFFFFF", dark: "#252525", lightHighContrast: "#FFFFFF", darkHighContrast: "#303030" },
      contentPrimary: { light: "#171411", dark: "#F5F2EB", lightHighContrast: "#000000", darkHighContrast: "#FFFFFF" },
      contentSecondary: { light: "#5C5449", dark: "#D6CCBD", lightHighContrast: "#453D35", darkHighContrast: "#F0E7DA" },
      contentTertiary: { light: "#7B7266", dark: "#A79C8B", lightHighContrast: "#5E564A", darkHighContrast: "#D8CEBF" },
      accent: options.accent ?? { light: "#2A6F62", dark: "#73C5B4", lightHighContrast: "#184E43", darkHighContrast: "#A5EBDD" },
      accentSecondary: { light: "#8B5E34", dark: "#D7A46F", lightHighContrast: "#684323", darkHighContrast: "#F4C48F" },
      accentTertiary: { light: "#6F5E87", dark: "#B29FD0", lightHighContrast: "#53436C", darkHighContrast: "#D3C3EC" },
      accentEmphasis: options.accentEmphasis ?? { light: "#184E43", dark: "#8DD8C7", lightHighContrast: "#0D342C", darkHighContrast: "#C2FFF2" },
      accentForeground: options.accentForeground ?? { light: "#F7FFFC", dark: "#081310", lightHighContrast: "#FFFFFF", darkHighContrast: "#000000" },
      success: { light: "#1F6E43", dark: "#76D0A0", lightHighContrast: "#0E5630", darkHighContrast: "#AAE6C1" },
      warning: { light: "#8C650F", dark: "#F0C75B", lightHighContrast: "#6A4B08", darkHighContrast: "#FFDE85" },
      critical: { light: "#9A3732", dark: "#FF9B91", lightHighContrast: "#7E2723", darkHighContrast: "#FFC2BC" },
      border: { light: "#D8D0C4", dark: "#3C3C3C", lightHighContrast: "#BDB3A5", darkHighContrast: "#626262" },
      separator: { light: "#E6DED2", dark: "#2C2C2C", lightHighContrast: "#CBC1B2", darkHighContrast: "#4B4B4B" },
      overlay: { light: "#171411CC", dark: "#000000D9", lightHighContrast: "#000000E6", darkHighContrast: "#000000F2" }
    },
    spacing: AppSpacing,
    radii: AppRadii,
    elevation: AppElevation,
    motion: AppMotion
  };
}

export function resolveThemeColor(
  theme: AppTheme,
  role: AppColorRole,
  scheme: AppColorScheme,
  contrast: AppColorContrast
): string {
  return resolveColorToken(theme.colors[role], scheme, contrast);
}
```

- [ ] **Step 4: Implement provider and hooks**

Create `packages/react-native/src/theme/ThemeProvider.tsx`:

```tsx
import React, { createContext, useContext, useMemo } from "react";
import { useColorScheme } from "react-native";
import type { AppColorContrast, AppColorRole, AppColorScheme } from "../foundation";
import { editorialTheme, resolveThemeColor, type AppTheme } from "./theme";

export type AppThemeContextValue = {
  theme: AppTheme;
  scheme: AppColorScheme;
  contrast: AppColorContrast;
  reduceMotion: boolean;
};

const AppThemeContext = createContext<AppThemeContextValue | null>(null);

export type ThemeProviderProps = {
  children: React.ReactNode;
  theme?: AppTheme;
  scheme?: AppColorScheme;
  contrast?: AppColorContrast;
  reduceMotion?: boolean;
};

export function ThemeProvider({
  children,
  theme = editorialTheme(),
  scheme,
  contrast = "normal",
  reduceMotion = false
}: ThemeProviderProps) {
  const deviceScheme = useColorScheme();
  const resolvedScheme: AppColorScheme = scheme ?? (deviceScheme === "dark" ? "dark" : "light");

  const value = useMemo(
    () => ({
      theme,
      scheme: resolvedScheme,
      contrast,
      reduceMotion
    }),
    [theme, resolvedScheme, contrast, reduceMotion]
  );

  return <AppThemeContext.Provider value={value}>{children}</AppThemeContext.Provider>;
}

export function useAppTheme(): AppTheme {
  return useAppThemeContext().theme;
}

export function useAppThemeContext(): AppThemeContextValue {
  const value = useContext(AppThemeContext);
  if (!value) {
    throw new Error("useAppTheme must be used inside ThemeProvider");
  }
  return value;
}

export function useThemeColor(role: AppColorRole): string {
  const { theme, scheme, contrast } = useAppThemeContext();
  return resolveThemeColor(theme, role, scheme, contrast);
}
```

- [ ] **Step 5: Export theme and package**

Create `packages/react-native/src/theme/index.ts`:

```ts
export * from "./theme";
export * from "./ThemeProvider";
```

Create `packages/react-native/src/index.ts`:

```ts
export * from "./foundation";
export * from "./theme";
```

- [ ] **Step 6: Run theme checks**

Run:

```bash
npm test --prefix packages/react-native -- theme.test.tsx foundation.test.ts
npm run typecheck --prefix packages/react-native
```

Expected: tests PASS and typecheck PASS.

- [ ] **Step 7: Commit theme**

Run:

```bash
git add packages/react-native/src/theme packages/react-native/src/index.ts packages/react-native/src/__tests__/theme.test.tsx
git commit -m "Add React Native theme provider"
```

---

### Task 4: Internal Text And Layout Primitives

**Files:**
- Modify: `packages/react-native/src/__tests__/components.test.tsx`
- Create: `packages/react-native/src/internal/AppText.tsx`
- Create: `packages/react-native/src/internal/styleUtils.ts`
- Create: `packages/react-native/src/layout/AppSurface.tsx`
- Create: `packages/react-native/src/layout/AppPage.tsx`
- Create: `packages/react-native/src/layout/AppSection.tsx`
- Create: `packages/react-native/src/layout/AppSectionHeader.tsx`
- Create: `packages/react-native/src/layout/index.ts`
- Modify: `packages/react-native/src/index.ts`

- [ ] **Step 1: Write layout smoke tests**

Create `packages/react-native/src/__tests__/components.test.tsx` with this initial content:

```tsx
import React from "react";
import { Text } from "react-native";
import { render } from "@testing-library/react-native";
import { ThemeProvider } from "../theme";
import { AppPage, AppSection, AppSectionHeader, AppSurface } from "../layout";

describe("layout primitives", () => {
  it("renders page, section, and header content", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppPage scrolls={false}>
          <AppSection>
            <AppSectionHeader title="Buttons" detail="Reusable actions" />
            <Text>Body</Text>
          </AppSection>
        </AppPage>
      </ThemeProvider>
    );

    expect(screen.getByText("Buttons")).toBeTruthy();
    expect(screen.getByText("Reusable actions")).toBeTruthy();
    expect(screen.getByText("Body")).toBeTruthy();
  });

  it("renders a surface with children", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppSurface tone="elevated">
          <Text>Inside</Text>
        </AppSurface>
      </ThemeProvider>
    );

    expect(screen.getByText("Inside")).toBeTruthy();
  });
});
```

- [ ] **Step 2: Run layout tests to verify failure**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
```

Expected: FAIL because `../layout` does not exist.

- [ ] **Step 3: Implement internal text primitive**

Create `packages/react-native/src/internal/AppText.tsx`:

```tsx
import React from "react";
import { Text, type TextProps } from "react-native";
import { textStyle, type AppColorRole, type AppTextStyle } from "../foundation";
import { useThemeColor } from "../theme";

export type AppTextProps = TextProps & {
  variant?: AppTextStyle;
  colorRole?: AppColorRole;
};

export function AppText({
  variant = "body",
  colorRole = "contentPrimary",
  style,
  ...props
}: AppTextProps) {
  const color = useThemeColor(colorRole);
  return <Text {...props} style={[textStyle(variant), { color }, style]} />;
}
```

- [ ] **Step 4: Implement style utils**

Create `packages/react-native/src/internal/styleUtils.ts`:

```ts
import type { ViewStyle } from "react-native";

export function shadowStyle(
  opacity: number,
  radius: number,
  y: number
): ViewStyle {
  return {
    shadowColor: "#000000",
    shadowOpacity: opacity,
    shadowRadius: radius,
    shadowOffset: { width: 0, height: y },
    elevation: opacity > 0 ? Math.max(1, Math.round(radius / 4)) : 0
  };
}
```

- [ ] **Step 5: Implement AppSurface**

Create `packages/react-native/src/layout/AppSurface.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { useAppTheme, useThemeColor } from "../theme";
import { shadowStyle } from "../internal/styleUtils";

export type AppSurfaceTone = "muted" | "standard" | "elevated" | "accent";

const toneRole: Record<AppSurfaceTone, AppColorRole> = {
  muted: "surfaceMuted",
  standard: "surface",
  elevated: "surfaceElevated",
  accent: "accent"
};

export type AppSurfaceProps = ViewProps & {
  tone?: AppSurfaceTone;
  padded?: boolean;
};

export function AppSurface({
  tone = "standard",
  padded = true,
  style,
  ...props
}: AppSurfaceProps) {
  const theme = useAppTheme();
  const backgroundColor = useThemeColor(toneRole[tone]);
  const borderColor = useThemeColor("border");

  return (
    <View
      {...props}
      style={[
        {
          padding: padded ? theme.spacing.large : 0,
          backgroundColor,
          borderColor,
          borderWidth: 1,
          borderRadius: theme.radii.medium
        },
        tone === "elevated"
          ? shadowStyle(
              theme.elevation.floatingOpacity,
              theme.elevation.floatingRadius,
              theme.elevation.floatingY
            )
          : null,
        style
      ]}
    />
  );
}
```

- [ ] **Step 6: Implement AppPage**

Create `packages/react-native/src/layout/AppPage.tsx`:

```tsx
import React from "react";
import { ScrollView, View, type ViewProps } from "react-native";
import { useAppTheme, useThemeColor } from "../theme";

export type AppPageProps = ViewProps & {
  scrolls?: boolean;
};

export function AppPage({
  scrolls = true,
  style,
  children,
  ...props
}: AppPageProps) {
  const theme = useAppTheme();
  const backgroundColor = useThemeColor("canvas");
  const contentStyle = [
    {
      flexGrow: 1,
      gap: theme.spacing.sectionGap,
      paddingHorizontal: theme.spacing.pageInset,
      paddingVertical: theme.spacing.xLarge,
      backgroundColor
    },
    style
  ];

  if (scrolls) {
    return (
      <ScrollView
        {...props}
        style={{ backgroundColor }}
        contentContainerStyle={contentStyle}
        showsVerticalScrollIndicator={false}
      >
        {children}
      </ScrollView>
    );
  }

  return (
    <View {...props} style={[{ flex: 1, backgroundColor }, ...contentStyle]}>
      {children}
    </View>
  );
}
```

- [ ] **Step 7: Implement AppSection**

Create `packages/react-native/src/layout/AppSection.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import { useAppTheme } from "../theme";
import { AppSurface, type AppSurfaceTone } from "./AppSurface";

export type AppSectionProps = ViewProps & {
  tone?: AppSurfaceTone | "plain";
};

export function AppSection({
  tone = "plain",
  style,
  ...props
}: AppSectionProps) {
  const theme = useAppTheme();
  const contentStyle = [{ gap: theme.spacing.medium }, style];

  if (tone === "plain") {
    return <View {...props} style={contentStyle} />;
  }

  return <AppSurface {...props} tone={tone} style={contentStyle} />;
}
```

- [ ] **Step 8: Implement AppSectionHeader**

Create `packages/react-native/src/layout/AppSectionHeader.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme } from "../theme";

export type AppSectionHeaderProps = ViewProps & {
  title: string;
  detail?: string;
};

export function AppSectionHeader({
  title,
  detail,
  style,
  ...props
}: AppSectionHeaderProps) {
  const theme = useAppTheme();

  return (
    <View {...props} style={[{ gap: theme.spacing.xxSmall }, style]}>
      <AppText variant="section">{title}</AppText>
      {detail ? (
        <AppText variant="detail" colorRole="contentSecondary">
          {detail}
        </AppText>
      ) : null}
    </View>
  );
}
```

- [ ] **Step 9: Export layout**

Create `packages/react-native/src/layout/index.ts`:

```ts
export * from "./AppPage";
export * from "./AppSection";
export * from "./AppSectionHeader";
export * from "./AppSurface";
```

Modify `packages/react-native/src/index.ts`:

```ts
export * from "./foundation";
export * from "./theme";
export * from "./layout";
```

- [ ] **Step 10: Run layout checks**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
npm run typecheck --prefix packages/react-native
```

Expected: tests PASS and typecheck PASS.

- [ ] **Step 11: Commit layout primitives**

Run:

```bash
git add packages/react-native/src/internal packages/react-native/src/layout packages/react-native/src/index.ts packages/react-native/src/__tests__/components.test.tsx
git commit -m "Add React Native layout primitives"
```

---

### Task 5: AppButton

**Files:**
- Modify: `packages/react-native/src/__tests__/components.test.tsx`
- Create: `packages/react-native/src/components/AppButton.tsx`
- Create: `packages/react-native/src/components/index.ts`
- Modify: `packages/react-native/src/index.ts`

- [ ] **Step 1: Add button tests**

Modify the import block at the top of `packages/react-native/src/__tests__/components.test.tsx` so it reads:

```tsx
import React from "react";
import { Text } from "react-native";
import { fireEvent, render } from "@testing-library/react-native";
import { ThemeProvider } from "../theme";
import { AppPage, AppSection, AppSectionHeader, AppSurface } from "../layout";
import { AppButton, resolveAppButtonColors } from "../components";
```

Then append this test block:

```tsx

describe("AppButton", () => {
  it("renders an accessible button and calls onPress", () => {
    const onPress = jest.fn();
    const screen = render(
      <ThemeProvider scheme="light">
        <AppButton title="Continue" onPress={onPress} />
      </ThemeProvider>
    );

    fireEvent.press(screen.getByRole("button", { name: "Continue" }));
    expect(onPress).toHaveBeenCalledTimes(1);
  });

  it("resolves strong primary colors", () => {
    expect(resolveAppButtonColors("primary", "strong")).toEqual({
      backgroundRole: "accent",
      foregroundRole: "accentForeground",
      borderRole: "accent"
    });
  });

  it("resolves subtle critical colors", () => {
    expect(resolveAppButtonColors("critical", "subtle")).toEqual({
      backgroundRole: "surface",
      foregroundRole: "critical",
      borderRole: "critical"
    });
  });
});
```

- [ ] **Step 2: Run button tests to verify failure**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
```

Expected: FAIL because `AppButton` and `resolveAppButtonColors` do not exist.

- [ ] **Step 3: Implement AppButton**

Create `packages/react-native/src/components/AppButton.tsx`:

```tsx
import { Ionicons } from "@expo/vector-icons";
import React from "react";
import {
  ActivityIndicator,
  Pressable,
  type PressableProps,
  View
} from "react-native";
import {
  controlSize,
  type AppColorRole,
  type AppControlSize
} from "../foundation";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppButtonIntent = "primary" | "neutral" | "success" | "warning" | "critical";
export type AppButtonEmphasis = "strong" | "subtle" | "ghost";

export type AppButtonColors = {
  backgroundRole: AppColorRole | null;
  foregroundRole: AppColorRole;
  borderRole: AppColorRole | null;
};

const intentTone: Record<AppButtonIntent, { background: AppColorRole; foreground: AppColorRole }> = {
  primary: { background: "accent", foreground: "accentEmphasis" },
  neutral: { background: "surfaceMuted", foreground: "contentPrimary" },
  success: { background: "success", foreground: "contentPrimary" },
  warning: { background: "warning", foreground: "contentPrimary" },
  critical: { background: "critical", foreground: "critical" }
};

export function resolveAppButtonColors(
  intent: AppButtonIntent,
  emphasis: AppButtonEmphasis
): AppButtonColors {
  const tone = intentTone[intent];
  if (emphasis === "strong") {
    return {
      backgroundRole: tone.background,
      foregroundRole: "accentForeground",
      borderRole: tone.background
    };
  }
  if (emphasis === "subtle") {
    return {
      backgroundRole: "surface",
      foregroundRole: tone.foreground,
      borderRole: tone.background
    };
  }
  return {
    backgroundRole: null,
    foregroundRole: tone.foreground,
    borderRole: null
  };
}

export type AppButtonProps = Omit<PressableProps, "children"> & {
  title: string;
  icon?: keyof typeof Ionicons.glyphMap;
  intent?: AppButtonIntent;
  emphasis?: AppButtonEmphasis;
  size?: AppControlSize;
  isLoading?: boolean;
};

export function AppButton({
  title,
  icon,
  intent = "primary",
  emphasis = "strong",
  size = "regular",
  isLoading = false,
  disabled,
  style,
  accessibilityLabel,
  ...props
}: AppButtonProps) {
  const theme = useAppTheme();
  const metrics = controlSize(size);
  const colors = resolveAppButtonColors(intent, emphasis);
  const fallbackBackground = useThemeColor("surface");
  const backgroundColor = colors.backgroundRole ? useThemeColor(colors.backgroundRole) : "transparent";
  const foregroundColor = useThemeColor(colors.foregroundRole);
  const borderColor = colors.borderRole ? useThemeColor(colors.borderRole) : "transparent";
  const spinnerColor = foregroundColor || fallbackBackground;

  return (
    <Pressable
      {...props}
      accessibilityRole="button"
      accessibilityLabel={accessibilityLabel ?? title}
      disabled={disabled || isLoading}
      style={({ pressed }) => [
        {
          minHeight: metrics.minHeight,
          paddingHorizontal: metrics.horizontalPadding,
          borderRadius: theme.radii.pill,
          borderWidth: colors.borderRole ? 1 : 0,
          borderColor,
          backgroundColor,
          opacity: disabled ? 0.48 : pressed ? 0.82 : 1,
          alignItems: "center",
          justifyContent: "center"
        },
        style
      ]}
    >
      <View style={{ flexDirection: "row", alignItems: "center", gap: theme.spacing.xSmall }}>
        {isLoading ? (
          <ActivityIndicator color={spinnerColor} size="small" />
        ) : icon ? (
          <Ionicons name={icon} size={metrics.iconDimension} color={foregroundColor} />
        ) : null}
        <AppText
          variant="bodyEmphasis"
          colorRole={colors.foregroundRole}
          numberOfLines={1}
          adjustsFontSizeToFit
          minimumFontScale={0.85}
        >
          {title}
        </AppText>
      </View>
    </Pressable>
  );
}
```

- [ ] **Step 4: Export components**

Create `packages/react-native/src/components/index.ts`:

```ts
export * from "./AppButton";
```

Modify `packages/react-native/src/index.ts`:

```ts
export * from "./foundation";
export * from "./theme";
export * from "./layout";
export * from "./components";
```

- [ ] **Step 5: Run button checks**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
npm run typecheck --prefix packages/react-native
```

Expected: tests PASS and typecheck PASS.

- [ ] **Step 6: Commit button**

Run:

```bash
git add packages/react-native/src/components packages/react-native/src/index.ts packages/react-native/src/__tests__/components.test.tsx
git commit -m "Add React Native button"
```

---

### Task 6: Inputs And Selection Controls

**Files:**
- Modify: `packages/react-native/src/__tests__/components.test.tsx`
- Create: `packages/react-native/src/components/AppTextField.tsx`
- Create: `packages/react-native/src/components/AppMultilineField.tsx`
- Create: `packages/react-native/src/components/AppSearchBar.tsx`
- Create: `packages/react-native/src/components/AppToggleRow.tsx`
- Create: `packages/react-native/src/components/AppSegmentedControl.tsx`
- Modify: `packages/react-native/src/components/index.ts`

- [ ] **Step 1: Add control tests**

Modify the import block at the top of `packages/react-native/src/__tests__/components.test.tsx` so it reads:

```tsx
import React from "react";
import { Text } from "react-native";
import { fireEvent, render } from "@testing-library/react-native";
import { ThemeProvider } from "../theme";
import { AppPage, AppSection, AppSectionHeader, AppSurface } from "../layout";
import {
  AppButton,
  AppTextField,
  AppMultilineField,
  AppSearchBar,
  AppToggleRow,
  AppSegmentedControl,
  resolveAppButtonColors
} from "../components";
```

Then append this test block:

```tsx

describe("form and selection controls", () => {
  it("renders text fields with labels and helpers", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppTextField label="Project name" value="" onChangeText={() => {}} helperText="Required" />
      </ThemeProvider>
    );

    expect(screen.getByText("Project name")).toBeTruthy();
    expect(screen.getByText("Required")).toBeTruthy();
  });

  it("renders multiline field and search bar", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <>
          <AppMultilineField label="Notes" value="" onChangeText={() => {}} />
          <AppSearchBar value="" onChangeText={() => {}} placeholder="Search" />
        </>
      </ThemeProvider>
    );

    expect(screen.getByText("Notes")).toBeTruthy();
    expect(screen.getByPlaceholderText("Search")).toBeTruthy();
  });

  it("toggles switch rows", () => {
    const onValueChange = jest.fn();
    const screen = render(
      <ThemeProvider scheme="light">
        <AppToggleRow title="Notifications" value={false} onValueChange={onValueChange} />
      </ThemeProvider>
    );

    fireEvent(screen.getByRole("switch"), "valueChange", true);
    expect(onValueChange).toHaveBeenCalledWith(true);
  });

  it("changes segmented control selection", () => {
    const onChange = jest.fn();
    const screen = render(
      <ThemeProvider scheme="light">
        <AppSegmentedControl
          value="inbox"
          onChange={onChange}
          segments={[
            { value: "inbox", title: "Inbox" },
            { value: "archive", title: "Archive" }
          ]}
        />
      </ThemeProvider>
    );

    fireEvent.press(screen.getByRole("button", { name: "Archive" }));
    expect(onChange).toHaveBeenCalledWith("archive");
  });
});
```

- [ ] **Step 2: Run control tests to verify failure**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
```

Expected: FAIL because the new components do not exist.

- [ ] **Step 3: Implement AppTextField**

Create `packages/react-native/src/components/AppTextField.tsx`:

```tsx
import { Ionicons } from "@expo/vector-icons";
import React, { useState } from "react";
import { TextInput, View, type TextInputProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppFieldState = "normal" | "success" | "warning" | "error";

function fieldRole(state: AppFieldState): AppColorRole {
  if (state === "success") return "success";
  if (state === "warning") return "warning";
  if (state === "error") return "critical";
  return "border";
}

export type AppTextFieldProps = TextInputProps & {
  label: string;
  icon?: keyof typeof Ionicons.glyphMap;
  fieldState?: AppFieldState;
  helperText?: string;
};

export function AppTextField({
  label,
  icon,
  fieldState = "normal",
  helperText,
  accessibilityLabel,
  style,
  onFocus,
  onBlur,
  ...props
}: AppTextFieldProps) {
  const [focused, setFocused] = useState(false);
  const theme = useAppTheme();
  const borderRole = focused ? "accent" : fieldRole(fieldState);
  const borderColor = useThemeColor(borderRole);
  const backgroundColor = useThemeColor("surface");
  const color = useThemeColor("contentPrimary");
  const placeholderTextColor = useThemeColor("contentTertiary");
  const iconColor = useThemeColor(focused ? borderRole : "contentTertiary");

  return (
    <View style={{ gap: theme.spacing.xSmall }}>
      <AppText variant="caption" colorRole="contentSecondary">{label}</AppText>
      <View
        style={{
          minHeight: 52,
          paddingHorizontal: theme.spacing.medium,
          borderRadius: theme.radii.medium,
          borderWidth: focused ? 2 : 1,
          borderColor,
          backgroundColor,
          flexDirection: "row",
          alignItems: "center",
          gap: theme.spacing.small
        }}
      >
        {icon ? <Ionicons name={icon} size={16} color={iconColor} accessibilityElementsHidden /> : null}
        <TextInput
          {...props}
          accessibilityLabel={accessibilityLabel ?? label}
          placeholderTextColor={placeholderTextColor}
          onFocus={(event) => {
            setFocused(true);
            onFocus?.(event);
          }}
          onBlur={(event) => {
            setFocused(false);
            onBlur?.(event);
          }}
          style={[{ flex: 1, color, fontSize: 17, minHeight: 44, paddingVertical: 0 }, style]}
        />
      </View>
      {helperText ? <AppText variant="caption" colorRole={fieldState === "normal" ? "contentSecondary" : fieldRole(fieldState)}>{helperText}</AppText> : null}
    </View>
  );
}
```

- [ ] **Step 4: Implement multiline field**

Create `packages/react-native/src/components/AppMultilineField.tsx`:

```tsx
import React from "react";
import { AppTextField, type AppTextFieldProps } from "./AppTextField";

export type AppMultilineFieldProps = Omit<AppTextFieldProps, "multiline"> & {
  minHeight?: number;
};

export function AppMultilineField({
  minHeight = 120,
  textAlignVertical = "top",
  style,
  ...props
}: AppMultilineFieldProps) {
  return (
    <AppTextField
      {...props}
      multiline
      textAlignVertical={textAlignVertical}
      style={[{ minHeight, paddingVertical: 12 }, style]}
    />
  );
}
```

- [ ] **Step 5: Implement search bar**

Create `packages/react-native/src/components/AppSearchBar.tsx`:

```tsx
import React from "react";
import { AppTextField, type AppTextFieldProps } from "./AppTextField";

export type AppSearchBarProps = Omit<AppTextFieldProps, "label" | "icon"> & {
  label?: string;
};

export function AppSearchBar({
  label = "Search",
  returnKeyType = "search",
  ...props
}: AppSearchBarProps) {
  return (
    <AppTextField
      {...props}
      label={label}
      icon="search"
      returnKeyType={returnKeyType}
    />
  );
}
```

- [ ] **Step 6: Implement toggle row**

Create `packages/react-native/src/components/AppToggleRow.tsx`:

```tsx
import React from "react";
import { Switch, View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppToggleRowProps = ViewProps & {
  title: string;
  subtitle?: string;
  value: boolean;
  onValueChange: (value: boolean) => void;
};

export function AppToggleRow({
  title,
  subtitle,
  value,
  onValueChange,
  style,
  ...props
}: AppToggleRowProps) {
  const theme = useAppTheme();
  const accent = useThemeColor("accent");
  const surfaceMuted = useThemeColor("surfaceMuted");

  return (
    <View
      {...props}
      style={[
        {
          minHeight: 56,
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "space-between",
          gap: theme.spacing.medium
        },
        style
      ]}
    >
      <View style={{ flex: 1, gap: theme.spacing.xxSmall }}>
        <AppText variant="bodyEmphasis">{title}</AppText>
        {subtitle ? <AppText variant="caption" colorRole="contentSecondary">{subtitle}</AppText> : null}
      </View>
      <Switch
        accessibilityLabel={title}
        value={value}
        onValueChange={onValueChange}
        trackColor={{ false: surfaceMuted, true: accent }}
      />
    </View>
  );
}
```

- [ ] **Step 7: Implement segmented control**

Create `packages/react-native/src/components/AppSegmentedControl.tsx`:

```tsx
import { Ionicons } from "@expo/vector-icons";
import React from "react";
import { Pressable, View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppSegment<T extends string> = {
  value: T;
  title: string;
  icon?: keyof typeof Ionicons.glyphMap;
};

export type AppSegmentedControlProps<T extends string> = ViewProps & {
  value: T;
  onChange: (value: T) => void;
  segments: Array<AppSegment<T>>;
};

export function AppSegmentedControl<T extends string>({
  value,
  onChange,
  segments,
  style,
  ...props
}: AppSegmentedControlProps<T>) {
  const theme = useAppTheme();
  const backgroundColor = useThemeColor("surfaceMuted");
  const selectedBackground = useThemeColor("surface");
  const borderColor = useThemeColor("border");
  const accent = useThemeColor("accent");

  return (
    <View
      {...props}
      accessibilityRole="tablist"
      style={[
        {
          flexDirection: "row",
          gap: theme.spacing.xxSmall,
          padding: theme.spacing.xxSmall,
          borderRadius: theme.radii.pill,
          backgroundColor
        },
        style
      ]}
    >
      {segments.map((segment) => {
        const selected = segment.value === value;
        return (
          <Pressable
            key={segment.value}
            accessibilityRole="button"
            accessibilityLabel={segment.title}
            accessibilityState={{ selected }}
            onPress={() => onChange(segment.value)}
            style={{
              flex: 1,
              minHeight: 40,
              borderRadius: theme.radii.pill,
              borderWidth: selected ? 1 : 0,
              borderColor,
              backgroundColor: selected ? selectedBackground : "transparent",
              alignItems: "center",
              justifyContent: "center",
              flexDirection: "row",
              gap: theme.spacing.xSmall,
              paddingHorizontal: theme.spacing.small
            }}
          >
            {segment.icon ? <Ionicons name={segment.icon} size={15} color={accent} /> : null}
            <AppText variant="caption" colorRole={selected ? "contentPrimary" : "contentSecondary"} numberOfLines={1}>
              {segment.title}
            </AppText>
          </Pressable>
        );
      })}
    </View>
  );
}
```

- [ ] **Step 8: Export controls**

Modify `packages/react-native/src/components/index.ts`:

```ts
export * from "./AppButton";
export * from "./AppTextField";
export * from "./AppMultilineField";
export * from "./AppSearchBar";
export * from "./AppToggleRow";
export * from "./AppSegmentedControl";
```

- [ ] **Step 9: Run control checks**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
npm run typecheck --prefix packages/react-native
```

Expected: tests PASS and typecheck PASS.

- [ ] **Step 10: Commit controls**

Run:

```bash
git add packages/react-native/src/components packages/react-native/src/__tests__/components.test.tsx
git commit -m "Add React Native form controls"
```

---

### Task 7: Feedback And Content Components

**Files:**
- Modify: `packages/react-native/src/__tests__/components.test.tsx`
- Create: `packages/react-native/src/components/AppBanner.tsx`
- Create: `packages/react-native/src/components/AppTag.tsx`
- Create: `packages/react-native/src/components/AppListRow.tsx`
- Create: `packages/react-native/src/components/AppKeyValueRow.tsx`
- Create: `packages/react-native/src/components/AppMetric.tsx`
- Create: `packages/react-native/src/components/AppProgressStrip.tsx`
- Create: `packages/react-native/src/components/AppLoadingState.tsx`
- Create: `packages/react-native/src/components/AppEmptyState.tsx`
- Modify: `packages/react-native/src/components/index.ts`

- [ ] **Step 1: Add feedback/content tests**

Modify the import block at the top of `packages/react-native/src/__tests__/components.test.tsx` so it reads:

```tsx
import React from "react";
import { Text } from "react-native";
import { fireEvent, render } from "@testing-library/react-native";
import { ThemeProvider } from "../theme";
import { AppPage, AppSection, AppSectionHeader, AppSurface } from "../layout";
import {
  AppButton,
  AppBanner,
  AppEmptyState,
  AppKeyValueRow,
  AppListRow,
  AppLoadingState,
  AppMetric,
  AppMultilineField,
  AppProgressStrip,
  AppSearchBar,
  AppSegmentedControl,
  AppTag,
  AppTextField,
  AppToggleRow,
  resolveAppButtonColors
} from "../components";
```

Then append this test block:

```tsx

describe("feedback and content components", () => {
  it("renders feedback and content primitives", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <>
          <AppBanner title="Ready" message="Theme aware" tone="accent" />
          <AppTag label="Live" tone="success" />
          <AppListRow title="Onboarding" subtitle="Three steps" />
          <AppKeyValueRow title="Meals" value="18" />
          <AppMetric title="Adoption" value="84%" delta="+12%" tone="success" />
          <AppProgressStrip title="Coverage" value={0.68} detail="Catalog state" />
          <AppLoadingState title="Syncing" message="Refreshing tokens" placeholderRows={2} />
          <AppEmptyState title="No drafts" message="Create a new screen." actionTitle="Create" onAction={() => {}} />
        </>
      </ThemeProvider>
    );

    expect(screen.getByText("Ready")).toBeTruthy();
    expect(screen.getByText("Live")).toBeTruthy();
    expect(screen.getByText("Onboarding")).toBeTruthy();
    expect(screen.getByText("Meals")).toBeTruthy();
    expect(screen.getByText("84%")).toBeTruthy();
    expect(screen.getByText("Coverage")).toBeTruthy();
    expect(screen.getByText("Syncing")).toBeTruthy();
    expect(screen.getByRole("button", { name: "Create" })).toBeTruthy();
  });
});
```

- [ ] **Step 2: Run content tests to verify failure**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
```

Expected: FAIL because content components do not exist.

- [ ] **Step 3: Implement AppBanner**

Create `packages/react-native/src/components/AppBanner.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppTone = "neutral" | "accent" | "success" | "warning" | "critical";

export function toneRole(tone: AppTone): AppColorRole {
  if (tone === "accent") return "accent";
  if (tone === "success") return "success";
  if (tone === "warning") return "warning";
  if (tone === "critical") return "critical";
  return "surfaceMuted";
}

export type AppBannerProps = ViewProps & {
  title: string;
  message: string;
  tone?: AppTone;
};

export function AppBanner({ title, message, tone = "neutral", style, ...props }: AppBannerProps) {
  const theme = useAppTheme();
  const borderColor = useThemeColor(toneRole(tone));
  const backgroundColor = useThemeColor("surface");

  return (
    <View
      {...props}
      style={[
        {
          gap: theme.spacing.xxSmall,
          padding: theme.spacing.medium,
          borderRadius: theme.radii.medium,
          borderWidth: 1,
          borderColor,
          backgroundColor
        },
        style
      ]}
    >
      <AppText variant="bodyEmphasis">{title}</AppText>
      <AppText variant="caption" colorRole="contentSecondary">{message}</AppText>
    </View>
  );
}
```

- [ ] **Step 4: Implement AppTag**

Create `packages/react-native/src/components/AppTag.tsx`:

```tsx
import { Ionicons } from "@expo/vector-icons";
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";
import { toneRole, type AppTone } from "./AppBanner";

export type AppTagProps = ViewProps & {
  label: string;
  icon?: keyof typeof Ionicons.glyphMap;
  tone?: AppTone;
};

export function AppTag({ label, icon, tone = "neutral", style, ...props }: AppTagProps) {
  const theme = useAppTheme();
  const color = useThemeColor(toneRole(tone));
  const backgroundColor = useThemeColor("surface");

  return (
    <View
      {...props}
      style={[
        {
          alignSelf: "flex-start",
          flexDirection: "row",
          alignItems: "center",
          gap: theme.spacing.xxSmall,
          paddingHorizontal: theme.spacing.small,
          minHeight: 30,
          borderRadius: theme.radii.pill,
          borderWidth: 1,
          borderColor: color,
          backgroundColor
        },
        style
      ]}
    >
      {icon ? <Ionicons name={icon} size={13} color={color} /> : null}
      <AppText variant="caption" colorRole={tone === "neutral" ? "contentSecondary" : toneRole(tone)}>
        {label}
      </AppText>
    </View>
  );
}
```

- [ ] **Step 5: Implement row and metric components**

Create `packages/react-native/src/components/AppListRow.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme } from "../theme";

export type AppListRowProps = ViewProps & {
  title: string;
  subtitle?: string;
  trailing?: React.ReactNode;
};

export function AppListRow({ title, subtitle, trailing, style, ...props }: AppListRowProps) {
  const theme = useAppTheme();
  return (
    <View
      {...props}
      style={[
        {
          minHeight: 60,
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "space-between",
          gap: theme.spacing.medium
        },
        style
      ]}
    >
      <View style={{ flex: 1, gap: theme.spacing.xxSmall }}>
        <AppText variant="bodyEmphasis">{title}</AppText>
        {subtitle ? <AppText variant="caption" colorRole="contentSecondary">{subtitle}</AppText> : null}
      </View>
      {trailing}
    </View>
  );
}
```

Create `packages/react-native/src/components/AppKeyValueRow.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { AppText } from "../internal/AppText";

export type AppKeyValueRowProps = ViewProps & {
  title: string;
  value: string;
  valueRole?: AppColorRole;
};

export function AppKeyValueRow({ title, value, valueRole = "contentPrimary", style, ...props }: AppKeyValueRowProps) {
  return (
    <View {...props} style={[{ minHeight: 44, flexDirection: "row", alignItems: "center", justifyContent: "space-between", gap: 16 }, style]}>
      <AppText variant="body" colorRole="contentSecondary">{title}</AppText>
      <AppText variant="bodyEmphasis" colorRole={valueRole}>{value}</AppText>
    </View>
  );
}
```

Create `packages/react-native/src/components/AppMetric.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme } from "../theme";
import { toneRole, type AppTone } from "./AppBanner";

export type AppMetricProps = ViewProps & {
  title: string;
  value: string;
  delta?: string;
  tone?: AppTone;
};

export function AppMetric({ title, value, delta, tone = "neutral", style, ...props }: AppMetricProps) {
  const theme = useAppTheme();
  return (
    <View {...props} style={[{ flex: 1, gap: theme.spacing.xxSmall }, style]}>
      <AppText variant="caption" colorRole="contentSecondary">{title}</AppText>
      <AppText variant="title" colorRole="contentPrimary">{value}</AppText>
      {delta ? <AppText variant="caption" colorRole={toneRole(tone)}>{delta}</AppText> : null}
    </View>
  );
}
```

- [ ] **Step 6: Implement progress and states**

Create `packages/react-native/src/components/AppProgressStrip.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppProgressStripProps = ViewProps & {
  title: string;
  value: number;
  detail?: string;
};

export function AppProgressStrip({ title, value, detail, style, ...props }: AppProgressStripProps) {
  const theme = useAppTheme();
  const track = useThemeColor("surfaceMuted");
  const fill = useThemeColor("accent");
  const clamped = Math.max(0, Math.min(1, value));

  return (
    <View {...props} style={[{ gap: theme.spacing.xSmall }, style]}>
      <View style={{ flexDirection: "row", justifyContent: "space-between", gap: theme.spacing.medium }}>
        <AppText variant="bodyEmphasis">{title}</AppText>
        <AppText variant="numeric" colorRole="contentSecondary">{Math.round(clamped * 100)}%</AppText>
      </View>
      <View style={{ height: 8, borderRadius: theme.radii.pill, backgroundColor: track, overflow: "hidden" }}>
        <View style={{ width: `${clamped * 100}%`, height: "100%", backgroundColor: fill }} />
      </View>
      {detail ? <AppText variant="caption" colorRole="contentSecondary">{detail}</AppText> : null}
    </View>
  );
}
```

Create `packages/react-native/src/components/AppLoadingState.tsx`:

```tsx
import React from "react";
import { ActivityIndicator, View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppLoadingStateProps = ViewProps & {
  title: string;
  message?: string;
  placeholderRows?: number;
};

export function AppLoadingState({ title, message, placeholderRows = 3, style, ...props }: AppLoadingStateProps) {
  const theme = useAppTheme();
  const accent = useThemeColor("accent");
  const muted = useThemeColor("surfaceMuted");

  return (
    <View {...props} style={[{ gap: theme.spacing.medium }, style]}>
      <ActivityIndicator color={accent} />
      <View style={{ gap: theme.spacing.xxSmall }}>
        <AppText variant="bodyEmphasis">{title}</AppText>
        {message ? <AppText variant="caption" colorRole="contentSecondary">{message}</AppText> : null}
      </View>
      <View style={{ gap: theme.spacing.xSmall }}>
        {Array.from({ length: placeholderRows }).map((_, index) => (
          <View key={index} style={{ height: 12, width: `${90 - index * 12}%`, borderRadius: theme.radii.pill, backgroundColor: muted }} />
        ))}
      </View>
    </View>
  );
}
```

Create `packages/react-native/src/components/AppEmptyState.tsx`:

```tsx
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme } from "../theme";
import { AppButton } from "./AppButton";

export type AppEmptyStateProps = ViewProps & {
  title: string;
  message: string;
  actionTitle?: string;
  onAction?: () => void;
};

export function AppEmptyState({ title, message, actionTitle, onAction, style, ...props }: AppEmptyStateProps) {
  const theme = useAppTheme();
  return (
    <View {...props} style={[{ alignItems: "center", gap: theme.spacing.medium, paddingVertical: theme.spacing.xLarge }, style]}>
      <View style={{ alignItems: "center", gap: theme.spacing.xSmall }}>
        <AppText variant="section" style={{ textAlign: "center" }}>{title}</AppText>
        <AppText variant="detail" colorRole="contentSecondary" style={{ textAlign: "center" }}>{message}</AppText>
      </View>
      {actionTitle && onAction ? <AppButton title={actionTitle} onPress={onAction} /> : null}
    </View>
  );
}
```

- [ ] **Step 7: Export content components**

Modify `packages/react-native/src/components/index.ts`:

```ts
export * from "./AppButton";
export * from "./AppTextField";
export * from "./AppMultilineField";
export * from "./AppSearchBar";
export * from "./AppToggleRow";
export * from "./AppSegmentedControl";
export * from "./AppBanner";
export * from "./AppTag";
export * from "./AppListRow";
export * from "./AppKeyValueRow";
export * from "./AppMetric";
export * from "./AppProgressStrip";
export * from "./AppLoadingState";
export * from "./AppEmptyState";
```

- [ ] **Step 8: Run content checks**

Run:

```bash
npm test --prefix packages/react-native -- components.test.tsx
npm run typecheck --prefix packages/react-native
```

Expected: tests PASS and typecheck PASS.

- [ ] **Step 9: Commit content components**

Run:

```bash
git add packages/react-native/src/components packages/react-native/src/__tests__/components.test.tsx
git commit -m "Add React Native content components"
```

---

### Task 8: Expo Catalog App

**Files:**
- Create: `packages/react-native/example/package.json`
- Create: `packages/react-native/example/app.json`
- Create: `packages/react-native/example/App.tsx`

- [ ] **Step 1: Create Expo catalog package**

Create `packages/react-native/example/package.json`:

```json
{
  "name": "app-design-system-react-native-catalog",
  "version": "0.1.0",
  "private": true,
  "main": "expo/AppEntry.js",
  "scripts": {
    "start": "expo start",
    "ios": "expo start --ios",
    "android": "expo start --android",
    "web": "expo start --web"
  },
  "dependencies": {
    "@app-design-system/react-native": "file:..",
    "@expo/vector-icons": "*",
    "expo": "^53.0.0",
    "react": "^19.0.0",
    "react-native": "^0.79.0"
  }
}
```

- [ ] **Step 2: Create Expo config**

Create `packages/react-native/example/app.json`:

```json
{
  "expo": {
    "name": "Design System Catalog",
    "slug": "design-system-catalog",
    "scheme": "designsystemcatalog",
    "version": "0.1.0",
    "orientation": "portrait",
    "userInterfaceStyle": "automatic",
    "assetBundlePatterns": ["**/*"]
  }
}
```

- [ ] **Step 3: Create catalog screen**

Create `packages/react-native/example/App.tsx`:

```tsx
import React, { useState } from "react";
import {
  AppBanner,
  AppButton,
  AppEmptyState,
  AppKeyValueRow,
  AppListRow,
  AppMetric,
  AppMultilineField,
  AppPage,
  AppProgressStrip,
  AppSearchBar,
  AppSection,
  AppSectionHeader,
  AppSegmentedControl,
  AppTag,
  AppTextField,
  AppToggleRow,
  ThemeProvider
} from "@app-design-system/react-native";

type CatalogTab = "inbox" | "projects" | "archive";

export default function App() {
  const [search, setSearch] = useState("");
  const [notes, setNotes] = useState("Focus on reusable screens and calm defaults.");
  const [enabled, setEnabled] = useState(true);
  const [tab, setTab] = useState<CatalogTab>("inbox");

  return (
    <ThemeProvider>
      <AppPage>
        <AppSection>
          <AppSectionHeader
            title="AppDesignSystem RN"
            detail="Expo-first primitives for product screens."
          />
          <AppButton title="Primary action" icon="arrow-forward" onPress={() => {}} />
          <AppButton title="Secondary action" intent="neutral" emphasis="subtle" onPress={() => {}} />
        </AppSection>

        <AppSection tone="standard">
          <AppSectionHeader title="Inputs" detail="Labels, helpers, states, and selection." />
          <AppSearchBar value={search} onChangeText={setSearch} placeholder="Search components" />
          <AppSegmentedControl
            value={tab}
            onChange={setTab}
            segments={[
              { value: "inbox", title: "Inbox", icon: "file-tray" },
              { value: "projects", title: "Projects", icon: "grid" },
              { value: "archive", title: "Archive", icon: "archive" }
            ]}
          />
          <AppTextField label="Project name" value={search} onChangeText={setSearch} helperText="Reusable field shell." />
          <AppMultilineField label="Notes" value={notes} onChangeText={setNotes} />
          <AppToggleRow title="Priority notifications" subtitle="Keep important updates visible." value={enabled} onValueChange={setEnabled} />
        </AppSection>

        <AppSection tone="standard">
          <AppSectionHeader title="Feedback" detail="Semantic tone and compact content primitives." />
          <AppBanner title="Theme aware" message="Components resolve color through semantic roles." tone="accent" />
          <AppTag label="Live" tone="success" icon="checkmark-circle" />
          <AppListRow title="Onboarding flow" subtitle="Three-step task flow" trailing={<AppTag label="Ready" tone="success" />} />
          <AppKeyValueRow title="Meals planned" value="18" valueRole="accent" />
          <AppMetric title="Adoption" value="84%" delta="+12%" tone="success" />
          <AppProgressStrip title="Catalog coverage" value={0.68} detail="Core primitives represented." />
        </AppSection>

        <AppEmptyState
          title="Build a new screen from the package."
          message="Start with AppPage, layer sections, then drop in semantic components."
          actionTitle="Create Layout"
          onAction={() => {}}
        />
      </AppPage>
    </ThemeProvider>
  );
}
```

- [ ] **Step 4: Install example dependencies**

Run:

```bash
npm install --prefix packages/react-native/example
```

Expected: dependencies install and `packages/react-native/example/package-lock.json` is created.

- [ ] **Step 5: Start the catalog**

Run:

```bash
npm run catalog --prefix packages/react-native
```

Expected: Expo starts and prints a local URL or QR code. Stop the server after confirming it starts.

- [ ] **Step 6: Commit catalog**

Run:

```bash
git add packages/react-native/example
git commit -m "Add React Native catalog app"
```

---

### Task 9: Documentation And Final Verification

**Files:**
- Create: `packages/react-native/README.md`
- Modify: `README.md`

- [ ] **Step 1: Create React Native package README**

Create `packages/react-native/README.md`:

```md
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

Run:

```bash
npm run catalog --prefix packages/react-native
```
```

- [ ] **Step 2: Update root README**

Add this section to the root `README.md` after the Swift installation section:

```md
## React Native Package

This repo also includes an Expo-first React Native sibling package at `packages/react-native`.

```bash
npm install --prefix packages/react-native
npm test --prefix packages/react-native
npm run catalog --prefix packages/react-native
```

The React Native package mirrors the Swift design system's semantic theme model and first-pass core components while keeping React Native-specific APIs idiomatic.
```

- [ ] **Step 3: Run final tests**

Run:

```bash
npm test --prefix packages/react-native
npm run typecheck --prefix packages/react-native
```

Expected: all tests PASS and typecheck PASS.

- [ ] **Step 4: Run Swift tests to confirm no regression**

Run:

```bash
swift test
```

Expected: Swift package tests PASS.

- [ ] **Step 5: Check git status**

Run:

```bash
git status --short
```

Expected: only intended README and package files are modified or staged.

- [ ] **Step 6: Commit documentation and verification**

Run:

```bash
git add README.md packages/react-native/README.md
git commit -m "Document React Native design system package"
```

---

## Self-Review Notes

- Spec coverage: The plan covers sibling package creation, Expo-first tooling, foundation tokens, theme provider and hooks, layout primitives, approved v1 components, accessibility-focused smoke tests, catalog app, and documentation.
- Deferred scope: tab bar, sidebar, modal scaffold, date picker, menu field, radio group, timeline, media/hero components, and bottom action bar remain outside v1, matching the approved spec.
- Type consistency: `AppColorRole`, `AppControlSize`, `AppFieldState`, `AppButtonIntent`, `AppButtonEmphasis`, `AppTone`, and hook names are defined before downstream use.
- Execution risk: dependency versions may need alignment with the currently installed Expo SDK when executing. If `npm install` reports peer-version conflicts, prefer Expo's suggested compatible versions while preserving the package architecture and public API in this plan.
