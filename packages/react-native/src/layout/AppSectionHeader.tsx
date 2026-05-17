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
