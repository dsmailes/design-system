export const AppSpacing = {
  xxSmall: 4,
  xSmall: 8,
  small: 12,
  medium: 16,
  large: 24,
  xLarge: 32,
  xxLarge: 48,
  pageInset: 20,
  sectionGap: 28
} as const;

export type AppSpacing = typeof AppSpacing;
