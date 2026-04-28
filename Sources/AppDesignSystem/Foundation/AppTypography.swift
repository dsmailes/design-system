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
    public let displayDesign: Font.Design
    public let titleDesign: Font.Design
    public let bodyDesign: Font.Design
    public let eyebrowTracking: CGFloat
    public let headingTracking: CGFloat

    public init(
        displayDesign: Font.Design = .default,
        titleDesign: Font.Design = .default,
        bodyDesign: Font.Design = .default,
        eyebrowTracking: CGFloat = 0.8,
        headingTracking: CGFloat = -0.2
    ) {
        self.displayDesign = displayDesign
        self.titleDesign = titleDesign
        self.bodyDesign = bodyDesign
        self.eyebrowTracking = eyebrowTracking
        self.headingTracking = headingTracking
    }

    public static let rounded = AppTypography(
        displayDesign: .rounded,
        titleDesign: .rounded,
        bodyDesign: .rounded,
        eyebrowTracking: 0.6,
        headingTracking: 0
    )

    public func font(for style: AppTextStyle) -> Font {
        switch style {
        case .eyebrow:
            .system(.caption, design: .rounded, weight: .semibold)
        case .display:
            .system(.largeTitle, design: displayDesign, weight: .bold)
        case .title:
            .system(.title2, design: titleDesign, weight: .semibold)
        case .section:
            .system(.headline, design: titleDesign, weight: .semibold)
        case .body:
            .system(.body, design: bodyDesign)
        case .bodyEmphasis:
            .system(.body, design: bodyDesign, weight: .semibold)
        case .detail:
            .system(.callout, design: bodyDesign)
        case .caption:
            .system(.footnote, design: bodyDesign)
        case .numeric:
            .system(.body, design: .monospaced, weight: .medium)
        }
    }

    public func tracking(for style: AppTextStyle) -> CGFloat {
        switch style {
        case .eyebrow:
            eyebrowTracking
        case .display, .title, .section:
            headingTracking
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
