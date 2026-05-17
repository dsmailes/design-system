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
