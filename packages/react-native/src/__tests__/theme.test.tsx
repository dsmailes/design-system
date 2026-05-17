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

function ThemeIdentityProbe({ onTheme }: { onTheme: (theme: ReturnType<typeof useAppTheme>) => void }) {
  const theme = useAppTheme();
  onTheme(theme);
  return null;
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

  it("reuses the default theme across provider rerenders", () => {
    const themes: Array<ReturnType<typeof useAppTheme>> = [];
    const screen = render(
      <ThemeProvider scheme="light" contrast="normal">
        <ThemeIdentityProbe onTheme={(theme) => themes.push(theme)} />
      </ThemeProvider>
    );

    screen.rerender(
      <ThemeProvider scheme="light" contrast="normal">
        <ThemeIdentityProbe onTheme={(theme) => themes.push(theme)} />
      </ThemeProvider>
    );

    expect(themes).toHaveLength(2);
    expect(themes[1]).toBe(themes[0]);
  });
});
