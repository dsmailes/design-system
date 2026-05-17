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
