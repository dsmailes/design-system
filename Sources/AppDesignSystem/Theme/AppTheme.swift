import SwiftUI

public struct AppTheme: Sendable {
    public struct Colors: Sendable {
        public let canvas: AppColorToken
        public let surface: AppColorToken
        public let surfaceMuted: AppColorToken
        public let surfaceElevated: AppColorToken
        public let contentPrimary: AppColorToken
        public let contentSecondary: AppColorToken
        public let contentTertiary: AppColorToken
        public let accent: AppColorToken
        public let accentSecondary: AppColorToken
        public let accentTertiary: AppColorToken
        public let accentEmphasis: AppColorToken
        public let accentForeground: AppColorToken
        public let success: AppColorToken
        public let warning: AppColorToken
        public let critical: AppColorToken
        public let border: AppColorToken
        public let separator: AppColorToken
        public let overlay: AppColorToken

        public init(
            canvas: AppColorToken,
            surface: AppColorToken,
            surfaceMuted: AppColorToken,
            surfaceElevated: AppColorToken,
            contentPrimary: AppColorToken,
            contentSecondary: AppColorToken,
            contentTertiary: AppColorToken,
            accent: AppColorToken,
            accentSecondary: AppColorToken,
            accentTertiary: AppColorToken,
            accentEmphasis: AppColorToken,
            accentForeground: AppColorToken,
            success: AppColorToken,
            warning: AppColorToken,
            critical: AppColorToken,
            border: AppColorToken,
            separator: AppColorToken,
            overlay: AppColorToken
        ) {
            self.canvas = canvas
            self.surface = surface
            self.surfaceMuted = surfaceMuted
            self.surfaceElevated = surfaceElevated
            self.contentPrimary = contentPrimary
            self.contentSecondary = contentSecondary
            self.contentTertiary = contentTertiary
            self.accent = accent
            self.accentSecondary = accentSecondary
            self.accentTertiary = accentTertiary
            self.accentEmphasis = accentEmphasis
            self.accentForeground = accentForeground
            self.success = success
            self.warning = warning
            self.critical = critical
            self.border = border
            self.separator = separator
            self.overlay = overlay
        }
    }

    public let colors: Colors
    public let typography: AppTypography
    public let spacing: AppSpacing
    public let radii: AppRadii
    public let elevation: AppElevation
    public let motion: AppMotion

    public init(
        colors: Colors,
        typography: AppTypography = AppTypography(),
        spacing: AppSpacing = AppSpacing(),
        radii: AppRadii = AppRadii(),
        elevation: AppElevation = AppElevation(),
        motion: AppMotion = AppMotion()
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.radii = radii
        self.elevation = elevation
        self.motion = motion
    }

    public func token(for role: AppColorRole) -> AppColorToken {
        switch role {
        case .canvas:
            colors.canvas
        case .surface:
            colors.surface
        case .surfaceMuted:
            colors.surfaceMuted
        case .surfaceElevated:
            colors.surfaceElevated
        case .contentPrimary:
            colors.contentPrimary
        case .contentSecondary:
            colors.contentSecondary
        case .contentTertiary:
            colors.contentTertiary
        case .accent:
            colors.accent
        case .accentSecondary:
            colors.accentSecondary
        case .accentTertiary:
            colors.accentTertiary
        case .accentEmphasis:
            colors.accentEmphasis
        case .accentForeground:
            colors.accentForeground
        case .success:
            colors.success
        case .warning:
            colors.warning
        case .critical:
            colors.critical
        case .border:
            colors.border
        case .separator:
            colors.separator
        case .overlay:
            colors.overlay
        }
    }

    public func color(
        _ role: AppColorRole,
        scheme: ColorScheme,
        contrast: ColorSchemeContrast
    ) -> Color {
        token(for: role).resolve(for: scheme, contrast: contrast)
    }

    public func withAccent(
        accent: AppColorToken,
        accentEmphasis: AppColorToken? = nil,
        accentForeground: AppColorToken? = nil
    ) -> AppTheme {
        AppTheme(
            colors: .init(
                canvas: colors.canvas,
                surface: colors.surface,
                surfaceMuted: colors.surfaceMuted,
                surfaceElevated: colors.surfaceElevated,
                contentPrimary: colors.contentPrimary,
                contentSecondary: colors.contentSecondary,
                contentTertiary: colors.contentTertiary,
                accent: accent,
                accentSecondary: colors.accentSecondary,
                accentTertiary: colors.accentTertiary,
                accentEmphasis: accentEmphasis ?? colors.accentEmphasis,
                accentForeground: accentForeground ?? colors.accentForeground,
                success: colors.success,
                warning: colors.warning,
                critical: colors.critical,
                border: colors.border,
                separator: colors.separator,
                overlay: colors.overlay
            ),
            typography: typography,
            spacing: spacing,
            radii: radii,
            elevation: elevation,
            motion: motion
        )
    }

    public func withFeatureAccents(
        secondary: AppColorToken? = nil,
        tertiary: AppColorToken? = nil
    ) -> AppTheme {
        AppTheme(
            colors: .init(
                canvas: colors.canvas,
                surface: colors.surface,
                surfaceMuted: colors.surfaceMuted,
                surfaceElevated: colors.surfaceElevated,
                contentPrimary: colors.contentPrimary,
                contentSecondary: colors.contentSecondary,
                contentTertiary: colors.contentTertiary,
                accent: colors.accent,
                accentSecondary: secondary ?? colors.accentSecondary,
                accentTertiary: tertiary ?? colors.accentTertiary,
                accentEmphasis: colors.accentEmphasis,
                accentForeground: colors.accentForeground,
                success: colors.success,
                warning: colors.warning,
                critical: colors.critical,
                border: colors.border,
                separator: colors.separator,
                overlay: colors.overlay
            ),
            typography: typography,
            spacing: spacing,
            radii: radii,
            elevation: elevation,
            motion: motion
        )
    }

    public static func editorial(
        accent: AppColorToken = AppColorToken(
            light: "#2A6F62",
            dark: "#73C5B4",
            lightHighContrast: "#184E43",
            darkHighContrast: "#A5EBDD"
        ),
        accentEmphasis: AppColorToken = AppColorToken(
            light: "#184E43",
            dark: "#8DD8C7",
            lightHighContrast: "#0D342C",
            darkHighContrast: "#C2FFF2"
        ),
        accentForeground: AppColorToken = AppColorToken(
            light: "#F7FFFC",
            dark: "#081310",
            lightHighContrast: "#FFFFFF",
            darkHighContrast: "#000000"
        )
    ) -> AppTheme {
        AppTheme(
            colors: .init(
                canvas: AppColorToken(
                    light: "#F5F2EB",
                    dark: "#111111",
                    lightHighContrast: "#FFFFFF",
                    darkHighContrast: "#000000"
                ),
                surface: AppColorToken(
                    light: "#FEFCF7",
                    dark: "#171717",
                    lightHighContrast: "#FFFFFF",
                    darkHighContrast: "#0E0E0E"
                ),
                surfaceMuted: AppColorToken(
                    light: "#ECE6DA",
                    dark: "#202020",
                    lightHighContrast: "#E2DACD",
                    darkHighContrast: "#262626"
                ),
                surfaceElevated: AppColorToken(
                    light: "#FFFFFF",
                    dark: "#252525",
                    lightHighContrast: "#FFFFFF",
                    darkHighContrast: "#303030"
                ),
                contentPrimary: AppColorToken(
                    light: "#171411",
                    dark: "#F5F2EB",
                    lightHighContrast: "#000000",
                    darkHighContrast: "#FFFFFF"
                ),
                contentSecondary: AppColorToken(
                    light: "#5C5449",
                    dark: "#D6CCBD",
                    lightHighContrast: "#453D35",
                    darkHighContrast: "#F0E7DA"
                ),
                contentTertiary: AppColorToken(
                    light: "#7B7266",
                    dark: "#A79C8B",
                    lightHighContrast: "#5E564A",
                    darkHighContrast: "#D8CEBF"
                ),
                accent: accent,
                accentSecondary: AppColorToken(
                    light: "#8B5E34",
                    dark: "#D7A46F",
                    lightHighContrast: "#684323",
                    darkHighContrast: "#F4C48F"
                ),
                accentTertiary: AppColorToken(
                    light: "#6F5E87",
                    dark: "#B29FD0",
                    lightHighContrast: "#53436C",
                    darkHighContrast: "#D3C3EC"
                ),
                accentEmphasis: accentEmphasis,
                accentForeground: accentForeground,
                success: AppColorToken(
                    light: "#1F6E43",
                    dark: "#76D0A0",
                    lightHighContrast: "#0E5630",
                    darkHighContrast: "#AAE6C1"
                ),
                warning: AppColorToken(
                    light: "#8C650F",
                    dark: "#F0C75B",
                    lightHighContrast: "#6A4B08",
                    darkHighContrast: "#FFDE85"
                ),
                critical: AppColorToken(
                    light: "#9A3732",
                    dark: "#FF9B91",
                    lightHighContrast: "#7E2723",
                    darkHighContrast: "#FFC2BC"
                ),
                border: AppColorToken(
                    light: "#D8D0C4",
                    dark: "#3C3C3C",
                    lightHighContrast: "#BDB3A5",
                    darkHighContrast: "#626262"
                ),
                separator: AppColorToken(
                    light: "#E6DED2",
                    dark: "#2C2C2C",
                    lightHighContrast: "#CBC1B2",
                    darkHighContrast: "#4B4B4B"
                ),
                overlay: AppColorToken(
                    light: "#171411CC",
                    dark: "#000000D9",
                    lightHighContrast: "#000000E6",
                    darkHighContrast: "#000000F2"
                )
            )
        )
    }
}
