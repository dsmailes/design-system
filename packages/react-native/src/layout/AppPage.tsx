import React from "react";
import { ScrollView, View, type ScrollViewProps } from "react-native";
import { useAppTheme, useThemeColor } from "../theme";

export type AppPageProps = ScrollViewProps & {
  scrolls?: boolean;
};

export function AppPage({
  scrolls = true,
  style,
  contentContainerStyle,
  children,
  ...props
}: AppPageProps) {
  const theme = useAppTheme();
  const backgroundColor = useThemeColor("canvas");
  const pageContentStyle = [
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
        style={[{ backgroundColor }, style]}
        contentContainerStyle={[...pageContentStyle, contentContainerStyle]}
        showsVerticalScrollIndicator={false}
      >
        {children}
      </ScrollView>
    );
  }

  return (
    <View {...props} style={[{ flex: 1, backgroundColor }, ...pageContentStyle]}>
      {children}
    </View>
  );
}
