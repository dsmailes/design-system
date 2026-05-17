export type AppColorScheme = "light" | "dark";
export type AppColorContrast = "normal" | "increased";

export type AppColorToken = {
  light: string;
  dark: string;
  lightHighContrast?: string;
  darkHighContrast?: string;
};

export type AppColorRole =
  | "canvas"
  | "surface"
  | "surfaceMuted"
  | "surfaceElevated"
  | "contentPrimary"
  | "contentSecondary"
  | "contentTertiary"
  | "accent"
  | "accentSecondary"
  | "accentTertiary"
  | "accentEmphasis"
  | "accentForeground"
  | "success"
  | "warning"
  | "critical"
  | "border"
  | "separator"
  | "overlay";

export function colorToken(token: AppColorToken): Required<AppColorToken> {
  return {
    light: token.light,
    dark: token.dark,
    lightHighContrast: token.lightHighContrast ?? token.light,
    darkHighContrast: token.darkHighContrast ?? token.dark
  };
}

export function resolveColorToken(
  token: AppColorToken,
  scheme: AppColorScheme,
  contrast: AppColorContrast = "normal"
): string {
  const resolved = colorToken(token);
  if (scheme === "light" && contrast === "increased") {
    return resolved.lightHighContrast;
  }
  if (scheme === "dark" && contrast === "increased") {
    return resolved.darkHighContrast;
  }
  return scheme === "dark" ? resolved.dark : resolved.light;
}
