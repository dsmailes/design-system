import {
  AppElevation,
  AppMotion,
  AppRadii,
  AppSpacing,
  resolveColorToken,
  type AppColorContrast,
  type AppColorRole,
  type AppColorScheme,
  type AppColorToken
} from "../foundation";

export type AppThemeColors = Record<AppColorRole, AppColorToken>;

export type AppTheme = {
  colors: AppThemeColors;
  spacing: typeof AppSpacing;
  radii: typeof AppRadii;
  elevation: typeof AppElevation;
  motion: typeof AppMotion;
};

export type EditorialThemeOptions = {
  accent?: AppColorToken;
  accentEmphasis?: AppColorToken;
  accentForeground?: AppColorToken;
};

export function editorialTheme(options: EditorialThemeOptions = {}): AppTheme {
  return {
    colors: {
      canvas: { light: "#F5F2EB", dark: "#111111", lightHighContrast: "#FFFFFF", darkHighContrast: "#000000" },
      surface: { light: "#FEFCF7", dark: "#171717", lightHighContrast: "#FFFFFF", darkHighContrast: "#0E0E0E" },
      surfaceMuted: { light: "#ECE6DA", dark: "#202020", lightHighContrast: "#E2DACD", darkHighContrast: "#262626" },
      surfaceElevated: { light: "#FFFFFF", dark: "#252525", lightHighContrast: "#FFFFFF", darkHighContrast: "#303030" },
      contentPrimary: { light: "#171411", dark: "#F5F2EB", lightHighContrast: "#000000", darkHighContrast: "#FFFFFF" },
      contentSecondary: { light: "#5C5449", dark: "#D6CCBD", lightHighContrast: "#453D35", darkHighContrast: "#F0E7DA" },
      contentTertiary: { light: "#7B7266", dark: "#A79C8B", lightHighContrast: "#5E564A", darkHighContrast: "#D8CEBF" },
      accent: options.accent ?? { light: "#2A6F62", dark: "#73C5B4", lightHighContrast: "#184E43", darkHighContrast: "#A5EBDD" },
      accentSecondary: { light: "#8B5E34", dark: "#D7A46F", lightHighContrast: "#684323", darkHighContrast: "#F4C48F" },
      accentTertiary: { light: "#6F5E87", dark: "#B29FD0", lightHighContrast: "#53436C", darkHighContrast: "#D3C3EC" },
      accentEmphasis: options.accentEmphasis ?? { light: "#184E43", dark: "#8DD8C7", lightHighContrast: "#0D342C", darkHighContrast: "#C2FFF2" },
      accentForeground: options.accentForeground ?? { light: "#F7FFFC", dark: "#081310", lightHighContrast: "#FFFFFF", darkHighContrast: "#000000" },
      success: { light: "#1F6E43", dark: "#76D0A0", lightHighContrast: "#0E5630", darkHighContrast: "#AAE6C1" },
      warning: { light: "#8C650F", dark: "#F0C75B", lightHighContrast: "#6A4B08", darkHighContrast: "#FFDE85" },
      critical: { light: "#9A3732", dark: "#FF9B91", lightHighContrast: "#7E2723", darkHighContrast: "#FFC2BC" },
      border: { light: "#D8D0C4", dark: "#3C3C3C", lightHighContrast: "#BDB3A5", darkHighContrast: "#626262" },
      separator: { light: "#E6DED2", dark: "#2C2C2C", lightHighContrast: "#CBC1B2", darkHighContrast: "#4B4B4B" },
      overlay: { light: "#171411CC", dark: "#000000D9", lightHighContrast: "#000000E6", darkHighContrast: "#000000F2" }
    },
    spacing: AppSpacing,
    radii: AppRadii,
    elevation: AppElevation,
    motion: AppMotion
  };
}

export function resolveThemeColor(
  theme: AppTheme,
  role: AppColorRole,
  scheme: AppColorScheme,
  contrast: AppColorContrast
): string {
  return resolveColorToken(theme.colors[role], scheme, contrast);
}
