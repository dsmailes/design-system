import React from "react";
import { Switch, View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppToggleRowProps = ViewProps & {
  title: string;
  subtitle?: string;
  value: boolean;
  onValueChange: (value: boolean) => void;
};

export function AppToggleRow({
  title,
  subtitle,
  value,
  onValueChange,
  style,
  ...props
}: AppToggleRowProps) {
  const theme = useAppTheme();
  const accent = useThemeColor("accent");
  const surfaceMuted = useThemeColor("surfaceMuted");

  return (
    <View
      {...props}
      style={[
        {
          minHeight: 56,
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
      <Switch
        accessibilityLabel={title}
        value={value}
        onValueChange={onValueChange}
        trackColor={{ false: surfaceMuted, true: accent }}
      />
    </View>
  );
}
