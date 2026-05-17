import React from "react";
import { View, type ViewProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppTone = "neutral" | "accent" | "success" | "warning" | "critical";

export function toneRole(tone: AppTone): AppColorRole {
  if (tone === "accent") return "accent";
  if (tone === "success") return "success";
  if (tone === "warning") return "warning";
  if (tone === "critical") return "critical";
  return "surfaceMuted";
}

export type AppBannerProps = ViewProps & {
  title: string;
  message: string;
  tone?: AppTone;
};

export function AppBanner({ title, message, tone = "neutral", style, ...props }: AppBannerProps) {
  const theme = useAppTheme();
  const borderColor = useThemeColor(toneRole(tone));
  const backgroundColor = useThemeColor("surface");

  return (
    <View
      {...props}
      style={[
        {
          gap: theme.spacing.xxSmall,
          padding: theme.spacing.medium,
          borderRadius: theme.radii.medium,
          borderWidth: 1,
          borderColor,
          backgroundColor
        },
        style
      ]}
    >
      <AppText variant="bodyEmphasis">{title}</AppText>
      <AppText variant="caption" colorRole="contentSecondary">{message}</AppText>
    </View>
  );
}
