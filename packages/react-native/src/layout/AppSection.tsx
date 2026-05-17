import React from "react";
import { View, type ViewProps } from "react-native";
import { useAppTheme } from "../theme";
import { AppSurface, type AppSurfaceTone } from "./AppSurface";

export type AppSectionProps = ViewProps & {
  tone?: AppSurfaceTone | "plain";
};

export function AppSection({
  tone = "plain",
  style,
  ...props
}: AppSectionProps) {
  const theme = useAppTheme();
  const contentStyle = [{ gap: theme.spacing.medium }, style];

  if (tone === "plain") {
    return <View {...props} style={contentStyle} />;
  }

  return <AppSurface {...props} tone={tone} style={contentStyle} />;
}
