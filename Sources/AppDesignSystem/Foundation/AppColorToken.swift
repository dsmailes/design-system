import SwiftUI

public struct AppColorToken: Sendable, Equatable {
    public let light: String
    public let dark: String
    public let lightHighContrast: String
    public let darkHighContrast: String

    public init(
        light: String,
        dark: String,
        lightHighContrast: String? = nil,
        darkHighContrast: String? = nil
    ) {
        self.light = light
        self.dark = dark
        self.lightHighContrast = lightHighContrast ?? light
        self.darkHighContrast = darkHighContrast ?? dark
    }

    public func hex(
        for scheme: ColorScheme,
        contrast: ColorSchemeContrast
    ) -> String {
        switch (scheme, contrast) {
        case (.light, .increased):
            lightHighContrast
        case (.dark, .increased):
            darkHighContrast
        case (.dark, _):
            dark
        default:
            light
        }
    }

    public func resolve(
        for scheme: ColorScheme,
        contrast: ColorSchemeContrast
    ) -> Color {
        Color(hex: hex(for: scheme, contrast: contrast))
    }
}

extension Color {
    fileprivate init(hex: String) {
        let sanitized = hex
            .trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            .uppercased()

        var value: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&value)

        let components: (Double, Double, Double, Double)
        switch sanitized.count {
        case 6:
            components = (
                Double((value & 0xFF0000) >> 16) / 255.0,
                Double((value & 0x00FF00) >> 8) / 255.0,
                Double(value & 0x0000FF) / 255.0,
                1.0
            )
        case 8:
            components = (
                Double((value & 0xFF000000) >> 24) / 255.0,
                Double((value & 0x00FF0000) >> 16) / 255.0,
                Double((value & 0x0000FF00) >> 8) / 255.0,
                Double(value & 0x000000FF) / 255.0
            )
        default:
            components = (0, 0, 0, 1)
        }

        self.init(
            .sRGB,
            red: components.0,
            green: components.1,
            blue: components.2,
            opacity: components.3
        )
    }
}
