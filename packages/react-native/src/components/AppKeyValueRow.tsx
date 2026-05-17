import React from "react";
import { View, type ViewProps } from "react-native";
import type { AppColorRole } from "../foundation";
import { AppText } from "../internal/AppText";

export type AppKeyValueRowProps = ViewProps & {
  title: string;
  value: string;
  valueRole?: AppColorRole;
};

export function AppKeyValueRow({ title, value, valueRole = "contentPrimary", style, ...props }: AppKeyValueRowProps) {
  return (
    <View {...props} style={[{ minHeight: 44, flexDirection: "row", alignItems: "center", justifyContent: "space-between", gap: 16 }, style]}>
      <AppText variant="body" colorRole="contentSecondary">{title}</AppText>
      <AppText variant="bodyEmphasis" colorRole={valueRole}>{value}</AppText>
    </View>
  );
}
