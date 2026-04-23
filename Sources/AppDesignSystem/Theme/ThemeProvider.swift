import SwiftUI

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme.editorial()
}

public extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

public struct ThemeProvider<Content: View>: View {
    private let theme: AppTheme
    private let content: Content

    public init(
        theme: AppTheme = .editorial(),
        @ViewBuilder content: () -> Content
    ) {
        self.theme = theme
        self.content = content()
    }

    public var body: some View {
        ResolvedThemeProvider(theme: theme, content: content)
    }
}

private struct ResolvedThemeProvider<Content: View>: View {
    @Environment(\.colorScheme) private var scheme
    @Environment(\.colorSchemeContrast) private var contrast

    let theme: AppTheme
    let content: Content

    var body: some View {
        content
            .environment(\.appTheme, theme)
            .tint(theme.color(.accent, scheme: scheme, contrast: contrast))
            .background(theme.color(.canvas, scheme: scheme, contrast: contrast))
    }
}

public struct AppThemeColor: ShapeStyle {
    private let role: AppColorRole

    public init(_ role: AppColorRole) {
        self.role = role
    }

    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        environment.appTheme.color(
            role,
            scheme: environment.colorScheme,
            contrast: environment.colorSchemeContrast
        )
    }
}
