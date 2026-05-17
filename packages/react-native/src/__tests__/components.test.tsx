import React from "react";
import { StyleSheet, Text } from "react-native";
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
  AppToggleRow,
  AppSegmentedControl,
  AppTag,
  AppTextField,
  resolveAppButtonColors
} from "../components";

jest.mock("@expo/vector-icons", () => {
  const React = require("react");
  const { Text } = require("react-native");

  return {
    Ionicons: Object.assign(
      ({ name }: { name: string }) => React.createElement(Text, null, name),
      { glyphMap: { search: 0 } }
    )
  };
});

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
    const contentContainerStyle = StyleSheet.flatten(page.props.contentContainerStyle);
    expect(contentContainerStyle).toMatchObject({
      flexGrow: 1,
      gap: 28,
      paddingHorizontal: 20,
      paddingVertical: 32,
      paddingBottom: 99,
      backgroundColor: "#F5F2EB"
    });
    expect(contentContainerStyle.marginTop).toBeUndefined();
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

  it("keeps hook order stable when emphasis changes to ghost", () => {
    const consoleError = jest.spyOn(console, "error").mockImplementation(() => {});
    try {
      const screen = render(
        <ThemeProvider scheme="light">
          <AppButton title="Continue" emphasis="strong" onPress={() => {}} />
        </ThemeProvider>
      );

      screen.rerender(
        <ThemeProvider scheme="light">
          <AppButton title="Continue" emphasis="ghost" onPress={() => {}} />
        </ThemeProvider>
      );

      const messages = consoleError.mock.calls.flat().map(String);
      expect(
        messages.some((message) => message.includes("React has detected a change in the order of Hooks"))
      ).toBe(false);
    } finally {
      consoleError.mockRestore();
    }
  });

  it("sets accessibility state for disabled and loading states", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppButton
          title="Saving"
          accessibilityState={{ expanded: true }}
          isLoading
          onPress={() => {}}
        />
      </ThemeProvider>
    );

    expect(screen.getByRole("button", { name: "Saving" }).props.accessibilityState).toEqual(
      expect.objectContaining({
        expanded: true,
        disabled: true,
        busy: true
      })
    );
  });

  it("resolves strong primary colors", () => {
    expect(resolveAppButtonColors("primary", "strong")).toEqual({
      backgroundRole: "accent",
      foregroundRole: "accentForeground",
      borderRole: "accent"
    });
  });

  it("resolves strong neutral colors with readable foreground", () => {
    expect(resolveAppButtonColors("neutral", "strong")).toEqual({
      backgroundRole: "surfaceMuted",
      foregroundRole: "contentPrimary",
      borderRole: "surfaceMuted"
    });
  });

  it("renders strong neutral label with content primary color", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppButton title="Neutral" intent="neutral" emphasis="strong" onPress={() => {}} />
      </ThemeProvider>
    );

    expect(StyleSheet.flatten(screen.getByText("Neutral").props.style)).toMatchObject({
      color: "#171411"
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

  it("allows text fields to override placeholder color", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppTextField
          label="Project name"
          value=""
          onChangeText={() => {}}
          placeholder="Project"
          placeholderTextColor="#123456"
        />
      </ThemeProvider>
    );

    expect(screen.getByPlaceholderText("Project").props.placeholderTextColor).toBe("#123456");
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

    fireEvent.press(screen.getByRole("tab", { name: "Archive" }));
    expect(onChange).toHaveBeenCalledWith("archive");
  });

  it("uses tab semantics for segmented control selection", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppSegmentedControl
          testID="segments"
          value="inbox"
          onChange={() => {}}
          segments={[
            { value: "inbox", title: "Inbox" },
            { value: "archive", title: "Archive" }
          ]}
        />
      </ThemeProvider>
    );

    expect(screen.getByTestId("segments").props.accessibilityRole).toBe("tablist");
    expect(screen.getByRole("tab", { name: "Inbox" }).props.accessibilityState).toEqual({
      selected: true
    });
    expect(screen.getByRole("tab", { name: "Archive" }).props.accessibilityState).toEqual({
      selected: false
    });
  });
});

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

  it("normalizes non-finite progress values to zero", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppProgressStrip title="Coverage" value={NaN} detail="Catalog state" />
      </ThemeProvider>
    );

    expect(screen.getByText("0%")).toBeTruthy();
    expect(screen.queryByText("NaN%")).toBeNull();
    expect(StyleSheet.flatten(screen.getByTestId("progress-strip-fill").props.style)).toMatchObject({
      width: "0%"
    });
  });

  it("exposes progressbar accessibility semantics", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppProgressStrip title="Coverage" value={0.68} detail="Catalog state" />
      </ThemeProvider>
    );

    expect(screen.getByRole("progressbar").props.accessibilityValue).toEqual({
      min: 0,
      max: 100,
      now: 68
    });
  });

  it("caps loading placeholder rows for unbounded input", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppLoadingState title="Syncing" message="Refreshing tokens" placeholderRows={Infinity} />
      </ThemeProvider>
    );

    expect(screen.queryAllByTestId("loading-placeholder-row")).toHaveLength(8);
  });

  it("does not render an empty state button without action props", () => {
    const screen = render(
      <ThemeProvider scheme="light">
        <AppEmptyState title="No drafts" message="Create a new screen." />
      </ThemeProvider>
    );

    expect(screen.queryByRole("button")).toBeNull();
  });
});
