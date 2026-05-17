import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppProgressStripProps = ViewProps & {
  title: string;
  value: number;
  detail?: string;
};

export function AppProgressStrip({
  title,
  value,
  detail,
  style,
  accessible,
  accessibilityRole,
  accessibilityValue,
  ...props
}: AppProgressStripProps) {
  const theme = useAppTheme();
  const track = useThemeColor("surfaceMuted");
  const fill = useThemeColor("accent");
  const finiteValue = Number.isFinite(value) ? value : 0;
  const clamped = Math.max(0, Math.min(1, finiteValue));
  const percent = Math.round(clamped * 100);

  return (
    <View
      {...props}
      accessible={accessible ?? true}
      accessibilityRole={accessibilityRole ?? "progressbar"}
      accessibilityValue={{ ...accessibilityValue, min: 0, max: 100, now: percent }}
      style={[{ gap: theme.spacing.xSmall }, style]}
    >
      <View style={{ flexDirection: "row", justifyContent: "space-between", gap: theme.spacing.medium }}>
        <AppText variant="bodyEmphasis">{title}</AppText>
        <AppText variant="numeric" colorRole="contentSecondary">{percent}%</AppText>
      </View>
      <View style={{ height: 8, borderRadius: theme.radii.pill, backgroundColor: track, overflow: "hidden" }}>
        <View testID="progress-strip-fill" style={{ width: `${percent}%`, height: "100%", backgroundColor: fill }} />
      </View>
      {detail ? <AppText variant="caption" colorRole="contentSecondary">{detail}</AppText> : null}
    </View>
  );
}
