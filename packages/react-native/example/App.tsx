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
          <AppButton
            title="Secondary action"
            intent="neutral"
            emphasis="subtle"
            onPress={() => {}}
          />
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
          <AppTextField
            label="Project name"
            value={search}
            onChangeText={setSearch}
            helperText="Reusable field shell."
          />
          <AppMultilineField label="Notes" value={notes} onChangeText={setNotes} />
          <AppToggleRow
            title="Priority notifications"
            subtitle="Keep important updates visible."
            value={enabled}
            onValueChange={setEnabled}
          />
        </AppSection>

        <AppSection tone="standard">
          <AppSectionHeader
            title="Feedback"
            detail="Semantic tone and compact content primitives."
          />
          <AppBanner
            title="Theme aware"
            message="Components resolve color through semantic roles."
            tone="accent"
          />
          <AppTag label="Live" tone="success" icon="checkmark-circle" />
          <AppListRow
            title="Onboarding flow"
            subtitle="Three-step task flow"
            trailing={<AppTag label="Ready" tone="success" />}
          />
          <AppKeyValueRow title="Meals planned" value="18" valueRole="accent" />
          <AppMetric title="Adoption" value="84%" delta="+12%" tone="success" />
          <AppProgressStrip
            title="Catalog coverage"
            value={0.68}
            detail="Core primitives represented."
          />
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
