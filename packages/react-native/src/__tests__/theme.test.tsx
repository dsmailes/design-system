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
