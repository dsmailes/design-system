import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme } from "../theme";
import { toneRole, type AppTone } from "./AppBanner";

export type AppMetricProps = ViewProps & {
  title: string;
  value: string;
  delta?: string;
  tone?: AppTone;
};

export function AppMetric({ title, value, delta, tone = "neutral", style, ...props }: AppMetricProps) {
  const theme = useAppTheme();
  return (
    <View {...props} style={[{ flex: 1, gap: theme.spacing.xxSmall }, style]}>
      <AppText variant="caption" colorRole="contentSecondary">{title}</AppText>
      <AppText variant="title" colorRole="contentPrimary">{value}</AppText>
      {delta ? <AppText variant="caption" colorRole={toneRole(tone)}>{delta}</AppText> : null}
    </View>
  );
}
