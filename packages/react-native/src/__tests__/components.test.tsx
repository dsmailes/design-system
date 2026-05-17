import React from "react";
import { StyleSheet, Text } from "react-native";
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

  it("applies scroll props and content container spacing in scroll mode", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppPage
          testID="page"
          keyboardShouldPersistTaps="handled"
          style={{ marginTop: 7 }}
          contentContainerStyle={{ paddingBottom: 99 }}
        >
          <Text>Scrollable body</Text>
        </AppPage>
      </ThemeProvider>
    );

    const page = screen.getByTestId("page");
    expect(page.props.keyboardShouldPersistTaps).toBe("handled");
    expect(StyleSheet.flatten(page.props.style)).toMatchObject({
      backgroundColor: "#F5F2EB",
      marginTop: 7
    });
    expect(StyleSheet.flatten(page.props.contentContainerStyle)).toMatchObject({
      flexGrow: 1,
      gap: 28,
      paddingHorizontal: 20,
      paddingVertical: 32,
      paddingBottom: 99,
      backgroundColor: "#F5F2EB"
    });
  });

  it("renders content in non-scroll mode", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppPage scrolls={false}>
          <Text>Static body</Text>
        </AppPage>
      </ThemeProvider>
    );

    expect(screen.getByText("Static body")).toBeTruthy();
  });

  it("applies elevated surface styling", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppSurface testID="surface" tone="elevated">
          <Text>Inside</Text>
        </AppSurface>
      </ThemeProvider>
    );

    expect(screen.getByText("Inside")).toBeTruthy();
    expect(StyleSheet.flatten(screen.getByTestId("surface").props.style)).toMatchObject({
      padding: 24,
      backgroundColor: "#FFFFFF",
      borderColor: "#D8D0C4",
      borderWidth: 1,
      borderRadius: 18,
      shadowOpacity: 0.12,
      shadowRadius: 28,
      shadowOffset: { width: 0, height: 12 },
      elevation: 7
    });
  });
});
