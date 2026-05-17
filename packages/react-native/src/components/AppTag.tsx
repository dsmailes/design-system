import { Ionicons } from "@expo/vector-icons";
import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";
import { toneRole, type AppTone } from "./AppBanner";

export type AppTagProps = ViewProps & {
  label: string;
  icon?: keyof typeof Ionicons.glyphMap;
  tone?: AppTone;
};

export function AppTag({ label, icon, tone = "neutral", style, ...props }: AppTagProps) {
  const theme = useAppTheme();
  const color = useThemeColor(toneRole(tone));
  const backgroundColor = useThemeColor("surface");

  return (
    <View
      {...props}
      style={[
        {
          alignSelf: "flex-start",
          flexDirection: "row",
          alignItems: "center",
          gap: theme.spacing.xxSmall,
          paddingHorizontal: theme.spacing.small,
          minHeight: 30,
          borderRadius: theme.radii.pill,
          borderWidth: 1,
          borderColor: color,
          backgroundColor
        },
        style
      ]}
    >
      {icon ? <Ionicons name={icon} size={13} color={color} /> : null}
      <AppText variant="caption" colorRole={tone === "neutral" ? "contentSecondary" : toneRole(tone)}>
        {label}
      </AppText>
    </View>
  );
}
