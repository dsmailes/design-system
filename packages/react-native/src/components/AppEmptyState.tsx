import React from "react";
import { View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme } from "../theme";
import { AppButton } from "./AppButton";

export type AppEmptyStateProps = ViewProps & {
  title: string;
  message: string;
  actionTitle?: string;
  onAction?: () => void;
};

export function AppEmptyState({ title, message, actionTitle, onAction, style, ...props }: AppEmptyStateProps) {
  const theme = useAppTheme();
  return (
    <View {...props} style={[{ alignItems: "center", gap: theme.spacing.medium, paddingVertical: theme.spacing.xLarge }, style]}>
      <View style={{ alignItems: "center", gap: theme.spacing.xSmall }}>
        <AppText variant="section" style={{ textAlign: "center" }}>{title}</AppText>
        <AppText variant="detail" colorRole="contentSecondary" style={{ textAlign: "center" }}>{message}</AppText>
      </View>
      {actionTitle && onAction ? <AppButton title={actionTitle} onPress={onAction} /> : null}
    </View>
  );
}
