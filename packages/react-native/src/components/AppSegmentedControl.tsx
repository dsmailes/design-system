import { Ionicons } from "@expo/vector-icons";
import React from "react";
import { Pressable, View, type ViewProps } from "react-native";
import { AppText } from "../internal/AppText";
import { useAppTheme, useThemeColor } from "../theme";

export type AppSegment<T extends string> = {
  value: T;
  title: string;
  icon?: keyof typeof Ionicons.glyphMap;
};

export type AppSegmentedControlProps<T extends string> = ViewProps & {
  value: T;
  onChange: (value: T) => void;
  segments: Array<AppSegment<T>>;
};

export function AppSegmentedControl<T extends string>({
  value,
  onChange,
  segments,
  style,
  ...props
}: AppSegmentedControlProps<T>) {
  const theme = useAppTheme();
  const backgroundColor = useThemeColor("surfaceMuted");
  const selectedBackground = useThemeColor("surface");
  const borderColor = useThemeColor("border");
  const accent = useThemeColor("accent");

  return (
    <View
      {...props}
      accessibilityRole="tablist"
      style={[
        {
          flexDirection: "row",
          gap: theme.spacing.xxSmall,
          padding: theme.spacing.xxSmall,
          borderRadius: theme.radii.pill,
          backgroundColor
        },
        style
      ]}
    >
      {segments.map((segment) => {
        const selected = segment.value === value;
        return (
          <Pressable
            key={segment.value}
            accessibilityRole="tab"
            accessibilityLabel={segment.title}
            accessibilityState={{ selected }}
            onPress={() => onChange(segment.value)}
            style={{
              flex: 1,
              minHeight: 40,
              borderRadius: theme.radii.pill,
              borderWidth: selected ? 1 : 0,
              borderColor,
              backgroundColor: selected ? selectedBackground : "transparent",
              alignItems: "center",
              justifyContent: "center",
              flexDirection: "row",
              gap: theme.spacing.xSmall,
              paddingHorizontal: theme.spacing.small
            }}
          >
            {segment.icon ? <Ionicons name={segment.icon} size={15} color={accent} /> : null}
            <AppText variant="caption" colorRole={selected ? "contentPrimary" : "contentSecondary"} numberOfLines={1}>
              {segment.title}
            </AppText>
          </Pressable>
        );
      })}
    </View>
  );
}
