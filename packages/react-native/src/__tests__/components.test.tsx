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
