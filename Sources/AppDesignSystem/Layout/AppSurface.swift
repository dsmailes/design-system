import SwiftUI

public enum AppSurfaceTone: Sendable {
    case muted
    case standard
    case elevated
    case accent
}

public struct AppSurfaceModifier: ViewModifier {
    @Environment(\.appTheme) private var theme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private let tone: AppSurfaceTone
    private let padded: Bool

    public init(tone: AppSurfaceTone = .standard, padded: Bool = true) {
        self.tone = tone
        self.padded = padded
    }

    public func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
        content
            .padding(padded ? theme.spacing.large : 0)
            .background(backgroundShape(shape: shape))
            .overlay(shape.stroke(AppThemeColor(.border), lineWidth: 1))
            .shadow(
                color: Color.black.opacity(tone == .elevated ? theme.elevation.floatingOpacity : theme.elevation.restingOpacity),
                radius: tone == .elevated ? theme.elevation.floatingRadius : 0,
                y: tone == .elevated ? theme.elevation.floatingY : 0
            )
    }

    @ViewBuilder
    private func backgroundShape(shape: RoundedRectangle) -> some View {
        switch tone {
        case .muted:
            shape.fill(AppThemeColor(.surfaceMuted))
        case .standard:
            shape.fill(AppThemeColor(.surface))
        case .elevated:
            shape.fill(AppThemeColor(.surfaceElevated))
        case .accent:
            if reduceTransparency {
                shape.fill(AppThemeColor(.accentEmphasis))
            } else {
                shape.fill(AppThemeColor(.accent))
            }
        }
    }
}

public extension View {
    func appSurface(
        _ tone: AppSurfaceTone = .standard,
        padded: Bool = true
    ) -> some View {
        modifier(AppSurfaceModifier(tone: tone, padded: padded))
    }
}
