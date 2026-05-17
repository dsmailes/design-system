import React, { createContext, useContext, useMemo } from "react";
import { useColorScheme } from "react-native";
import type { AppColorContrast, AppColorRole, AppColorScheme } from "../foundation";
import { editorialTheme, resolveThemeColor, type AppTheme } from "./theme";

export type AppThemeContextValue = {
  theme: AppTheme;
  scheme: AppColorScheme;
  contrast: AppColorContrast;
  reduceMotion: boolean;
};

const AppThemeContext = createContext<AppThemeContextValue | null>(null);

export type ThemeProviderProps = {
  children: React.ReactNode;
  theme?: AppTheme;
  scheme?: AppColorScheme;
  contrast?: AppColorContrast;
  reduceMotion?: boolean;
};

export function ThemeProvider({
  children,
  theme = editorialTheme(),
  scheme,
  contrast = "normal",
  reduceMotion = false
}: ThemeProviderProps) {
  const deviceScheme = useColorScheme();
  const resolvedScheme: AppColorScheme = scheme ?? (deviceScheme === "dark" ? "dark" : "light");

  const value = useMemo(
    () => ({
      theme,
      scheme: resolvedScheme,
      contrast,
      reduceMotion
    }),
    [theme, resolvedScheme, contrast, reduceMotion]
  );

  return <AppThemeContext.Provider value={value}>{children}</AppThemeContext.Provider>;
}

export function useAppTheme(): AppTheme {
  return useAppThemeContext().theme;
}

export function useAppThemeContext(): AppThemeContextValue {
  const value = useContext(AppThemeContext);
  if (!value) {
    throw new Error("useAppTheme must be used inside ThemeProvider");
  }
  return value;
}

export function useThemeColor(role: AppColorRole): string {
  const { theme, scheme, contrast } = useAppThemeContext();
  return resolveThemeColor(theme, role, scheme, contrast);
}
