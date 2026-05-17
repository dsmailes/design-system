import { Ionicons } from "@expo/vector-icons";
import React from "react";
import {
  ActivityIndicator,
  Pressable,
  type PressableProps,
  View
} from "react-native";
import {
  controlSize,
  type AppColorRole,
  type AppControlSize
} from "../foundation";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppButtonIntent = "primary" | "neutral" | "success" | "warning" | "critical";
export type AppButtonEmphasis = "strong" | "subtle" | "ghost";

export type AppButtonColors = {
  backgroundRole: AppColorRole | null;
  foregroundRole: AppColorRole;
  borderRole: AppColorRole | null;
};

const intentTone: Record<AppButtonIntent, { background: AppColorRole; foreground: AppColorRole }> = {
  primary: { background: "accent", foreground: "accentEmphasis" },
  neutral: { background: "surfaceMuted", foreground: "contentPrimary" },
  success: { background: "success", foreground: "contentPrimary" },
  warning: { background: "warning", foreground: "contentPrimary" },
  critical: { background: "critical", foreground: "critical" }
};

export function resolveAppButtonColors(
  intent: AppButtonIntent,
  emphasis: AppButtonEmphasis
): AppButtonColors {
  const tone = intentTone[intent];
  if (emphasis === "strong") {
    return {
      backgroundRole: tone.background,
      foregroundRole: "accentForeground",
      borderRole: tone.background
    };
  }
  if (emphasis === "subtle") {
    return {
      backgroundRole: "surface",
      foregroundRole: tone.foreground,
      borderRole: tone.background
    };
  }
  return {
    backgroundRole: null,
    foregroundRole: tone.foreground,
    borderRole: null
  };
}

export type AppButtonProps = Omit<PressableProps, "children"> & {
  title: string;
  icon?: keyof typeof Ionicons.glyphMap;
  intent?: AppButtonIntent;
  emphasis?: AppButtonEmphasis;
  size?: AppControlSize;
  isLoading?: boolean;
};

export function AppButton({
  title,
  icon,
  intent = "primary",
  emphasis = "strong",
  size = "regular",
  isLoading = false,
  disabled,
  style,
  accessibilityLabel,
  ...props
}: AppButtonProps) {
  const theme = useAppTheme();
  const metrics = controlSize(size);
  const colors = resolveAppButtonColors(intent, emphasis);
  const fallbackBackground = useThemeColor("surface");
  const backgroundColor = colors.backgroundRole ? useThemeColor(colors.backgroundRole) : "transparent";
  const foregroundColor = useThemeColor(colors.foregroundRole);
  const borderColor = colors.borderRole ? useThemeColor(colors.borderRole) : "transparent";
  const spinnerColor = foregroundColor || fallbackBackground;

  return (
    <Pressable
      {...props}
      accessibilityRole="button"
      accessibilityLabel={accessibilityLabel ?? title}
      disabled={disabled || isLoading}
      style={(state) => [
        {
          minHeight: metrics.minHeight,
          paddingHorizontal: metrics.horizontalPadding,
          borderRadius: theme.radii.pill,
          borderWidth: colors.borderRole ? 1 : 0,
          borderColor,
          backgroundColor,
          opacity: disabled ? 0.48 : state.pressed ? 0.82 : 1,
          alignItems: "center",
          justifyContent: "center"
        },
        typeof style === "function" ? style(state) : style
      ]}
    >
      <View style={{ flexDirection: "row", alignItems: "center", gap: theme.spacing.xSmall }}>
        {isLoading ? (
          <ActivityIndicator color={spinnerColor} size="small" />
        ) : icon ? (
          <Ionicons name={icon} size={metrics.iconDimension} color={foregroundColor} />
        ) : null}
        <AppText
          variant="bodyEmphasis"
          colorRole={colors.foregroundRole}
          numberOfLines={1}
          adjustsFontSizeToFit
          minimumFontScale={0.85}
        >
          {title}
        </AppText>
      </View>
    </Pressable>
  );
}
