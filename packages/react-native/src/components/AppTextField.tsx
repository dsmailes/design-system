import { Ionicons } from "@expo/vector-icons";
import React, { useState } from "react";
import { TextInput, View, type TextInputProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppFieldState = "normal" | "success" | "warning" | "error";

function fieldRole(state: AppFieldState): AppColorRole {
  if (state === "success") return "success";
  if (state === "warning") return "warning";
  if (state === "error") return "critical";
  return "border";
}

export type AppTextFieldProps = TextInputProps & {
  label: string;
  icon?: keyof typeof Ionicons.glyphMap;
  fieldState?: AppFieldState;
  helperText?: string;
};

export function AppTextField({
  label,
  icon,
  fieldState = "normal",
  helperText,
  accessibilityLabel,
  placeholderTextColor,
  style,
  onFocus,
  onBlur,
  ...props
}: AppTextFieldProps) {
  const [focused, setFocused] = useState(false);
  const theme = useAppTheme();
  const borderRole = focused ? "accent" : fieldRole(fieldState);
  const borderColor = useThemeColor(borderRole);
  const backgroundColor = useThemeColor("surface");
  const color = useThemeColor("contentPrimary");
  const defaultPlaceholderTextColor = useThemeColor("contentTertiary");
  const iconColor = useThemeColor(focused ? borderRole : "contentTertiary");

  return (
    <View style={{ gap: theme.spacing.xSmall }}>
      <AppText variant="caption" colorRole="contentSecondary">{label}</AppText>
      <View
        style={{
          minHeight: 52,
          paddingHorizontal: theme.spacing.medium,
          borderRadius: theme.radii.medium,
          borderWidth: focused ? 2 : 1,
          borderColor,
          backgroundColor,
          flexDirection: "row",
          alignItems: "center",
          gap: theme.spacing.small
        }}
      >
        {icon ? <Ionicons name={icon} size={16} color={iconColor} accessibilityElementsHidden /> : null}
        <TextInput
          {...props}
          accessibilityLabel={accessibilityLabel ?? label}
          placeholderTextColor={placeholderTextColor ?? defaultPlaceholderTextColor}
          onFocus={(event) => {
            setFocused(true);
            onFocus?.(event);
          }}
          onBlur={(event) => {
            setFocused(false);
            onBlur?.(event);
          }}
          style={[{ flex: 1, color, fontSize: 17, minHeight: 44, paddingVertical: 0 }, style]}
        />
      </View>
      {helperText ? <AppText variant="caption" colorRole={fieldState === "normal" ? "contentSecondary" : fieldRole(fieldState)}>{helperText}</AppText> : null}
    </View>
  );
}
