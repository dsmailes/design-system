import Testing
@testable import AppDesignSystem

struct AppDesignSystemTests {
    @Test
    func highContrastColorFallbackUsesOverride() {
        let token = AppColorToken(
            light: "#111111",
            dark: "#EEEEEE",
            lightHighContrast: "#000000",
            darkHighContrast: "#FFFFFF"
        )

        #expect(token.hex(for: .light, contrast: .increased) == "#000000")
        #expect(token.hex(for: .dark, contrast: .increased) == "#FFFFFF")
    }

    @Test
    func reducedMotionCollapsesDuration() {
        let motion = AppMotion(quick: 0.12, standard: 0.2, emphasis: 0.32)

        #expect(motion.duration(reduceMotion: true) == 0.01)
        #expect(motion.duration(reduceMotion: false, emphasis: true) == 0.32)
    }

    @Test
    func spacingScaleStaysOrdered() {
        let spacing = AppSpacing()

        #expect(spacing.xxSmall < spacing.small)
        #expect(spacing.small < spacing.large)
        #expect(spacing.large < spacing.xxLarge)
        #expect(spacing.pageInset <= spacing.sectionGap)
    }

    @Test
    func editorialThemeAcceptsAccentOverride() {
        let customAccent = AppColorToken(
            light: "#245CFF",
            dark: "#8EAEFF",
            lightHighContrast: "#103FCC",
            darkHighContrast: "#C7D7FF"
        )

        let theme = AppTheme.editorial().withAccent(accent: customAccent)

        #expect(theme.token(for: .accent) == customAccent)
        #expect(theme.token(for: .contentPrimary).light == "#171411")
    }

    @Test
    func editorialThemeAcceptsFeatureAccentOverrides() {
        let secondary = AppColorToken(
            light: "#BC7C38",
            dark: "#E8B476",
            lightHighContrast: "#8B5B26",
            darkHighContrast: "#FFD3A0"
        )
        let tertiary = AppColorToken(
            light: "#4F7A8A",
            dark: "#9AC4D3",
            lightHighContrast: "#355562",
            darkHighContrast: "#C7E7F2"
        )

        let theme = AppTheme.editorial().withFeatureAccents(secondary: secondary, tertiary: tertiary)

        #expect(theme.token(for: .accentSecondary) == secondary)
        #expect(theme.token(for: .accentTertiary) == tertiary)
    }
}
