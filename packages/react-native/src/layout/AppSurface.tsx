import React from "react";
import { View, type ViewProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { useAppTheme, useThemeColor } from "../theme";
import { shadowStyle } from "../internal/styleUtils";

export type AppSurfaceTone = "muted" | "standard" | "elevated" | "accent";

const toneRole: Record<AppSurfaceTone, AppColorRole> = {
  muted: "surfaceMuted",
  standard: "surface",
  elevated: "surfaceElevated",
  accent: "accent"
};

export type AppSurfaceProps = ViewProps & {
  tone?: AppSurfaceTone;
  padded?: boolean;
};

export function AppSurface({
  tone = "standard",
  padded = true,
  style,
  ...props
}: AppSurfaceProps) {
  const theme = useAppTheme();
  const backgroundColor = useThemeColor(toneRole[tone]);
  const borderColor = useThemeColor("border");

  return (
    <View
      {...props}
      style={[
        {
          padding: padded ? theme.spacing.large : 0,
          backgroundColor,
          borderColor,
          borderWidth: 1,
          borderRadius: theme.radii.medium
        },
        tone === "elevated"
          ? shadowStyle(
              theme.elevation.floatingOpacity,
              theme.elevation.floatingRadius,
              theme.elevation.floatingY
            )
          : null,
        style
      ]}
    />
  );
}
