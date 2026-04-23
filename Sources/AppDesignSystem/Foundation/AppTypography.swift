import SwiftUI

public enum AppTextStyle: String, CaseIterable, Sendable {
    case eyebrow
    case display
    case title
    case section
    case body
    case bodyEmphasis
    case detail
    case caption
    case numeric
}

public struct AppTypography: Sendable, Equatable {
    public init() { }

    public func font(for style: AppTextStyle) -> Font {
        switch style {
        case .eyebrow:
            .system(.caption, design: .rounded, weight: .semibold)
        case .display:
            .system(.largeTitle, design: .default, weight: .bold)
        case .title:
            .system(.title2, design: .default, weight: .semibold)
        case .section:
            .system(.headline, design: .default, weight: .semibold)
        case .body:
            .system(.body, design: .default)
        case .bodyEmphasis:
            .system(.body, design: .default, weight: .semibold)
        case .detail:
            .system(.callout, design: .default)
        case .caption:
            .system(.footnote, design: .default)
        case .numeric:
            .system(.body, design: .monospaced, weight: .medium)
        }
    }

    public func tracking(for style: AppTextStyle) -> CGFloat {
        switch style {
        case .eyebrow:
            0.8
        case .display:
            -0.4
        case .title:
            -0.2
        case .section:
            -0.15
        case .body, .bodyEmphasis, .detail, .caption, .numeric:
            0
        }
    }

    public func lineSpacing(for style: AppTextStyle) -> CGFloat {
        switch style {
        case .display:
            2
        case .title:
            1
        case .body, .bodyEmphasis:
            3
        default:
            0
        }
    }
}

public struct AppTextStyleModifier: ViewModifier {
    @Environment(\.appTheme) private var theme

    private let style: AppTextStyle
    private let role: AppColorRole

    public init(style: AppTextStyle, role: AppColorRole = .contentPrimary) {
        self.style = style
        self.role = role
    }

    public func body(content: Content) -> some View {
        content
            .font(theme.typography.font(for: style))
            .tracking(theme.typography.tracking(for: style))
            .lineSpacing(theme.typography.lineSpacing(for: style))
            .foregroundStyle(AppThemeColor(role))
    }
}

public extension View {
    func appTextStyle(
        _ style: AppTextStyle,
        color role: AppColorRole = .contentPrimary
    ) -> some View {
        modifier(AppTextStyleModifier(style: style, role: role))
    }
}
