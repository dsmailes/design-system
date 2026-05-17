import React from "react";
import { ActivityIndicator, View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

const maxPlaceholderRows = 8;

export type AppLoadingStateProps = ViewProps & {
  title: string;
  message?: string;
  placeholderRows?: number;
};

export function AppLoadingState({ title, message, placeholderRows = 3, style, ...props }: AppLoadingStateProps) {
  const theme = useAppTheme();
  const accent = useThemeColor("accent");
  const muted = useThemeColor("surfaceMuted");
  const rowCount = Number.isFinite(placeholderRows)
    ? Math.max(0, Math.min(maxPlaceholderRows, Math.floor(placeholderRows)))
    : maxPlaceholderRows;

  return (
    <View {...props} style={[{ gap: theme.spacing.medium }, style]}>
      <ActivityIndicator color={accent} />
      <View style={{ gap: theme.spacing.xxSmall }}>
        <AppText variant="bodyEmphasis">{title}</AppText>
        {message ? <AppText variant="caption" colorRole="contentSecondary">{message}</AppText> : null}
      </View>
      <View style={{ gap: theme.spacing.xSmall }}>
        {Array.from({ length: rowCount }).map((_, index) => (
          <View key={index} testID="loading-placeholder-row" style={{ height: 12, width: `${90 - index * 12}%`, borderRadius: theme.radii.pill, backgroundColor: muted }} />
        ))}
      </View>
    </View>
  );
}
