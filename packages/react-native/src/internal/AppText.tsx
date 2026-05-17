import React from "react";
import { Text, type TextProps } from "react-native";
import { textStyle, type AppColorRole, type AppTextStyle } from "../foundation";
import { useThemeColor } from "../theme";

export type AppTextProps = TextProps & {
  variant?: AppTextStyle;
  colorRole?: AppColorRole;
};

export function AppText({
  variant = "body",
  colorRole = "contentPrimary",
  style,
  ...props
}: AppTextProps) {
  const color = useThemeColor(colorRole);
  return <Text {...props} style={[textStyle(variant), { color }, style]} />;
}
