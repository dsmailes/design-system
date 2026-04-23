import SwiftUI

public enum AppBannerTone: Sendable {
    case accent
    case success
    case warning
    case critical
    case neutral
}

public struct AppBanner: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let message: String
    private let tone: AppBannerTone
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(
        title: String,
        message: String,
        tone: AppBannerTone = .neutral,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.tone = tone
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            HStack(spacing: theme.spacing.small) {
                Image(systemName: symbolName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppThemeColor(iconRole))

                Text(title)
                    .appTextStyle(.bodyEmphasis)
            }

            Text(message)
                .appTextStyle(.detail, color: .contentSecondary)
                .fixedSize(horizontal: false, vertical: true)

            if let actionTitle, let action {
                AppButton(
                    actionTitle,
                    intent: buttonIntent,
                    emphasis: .ghost,
                    size: .compact,
                    action: action
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .appSurface(surfaceTone)
        .accessibilityElement(children: .contain)
    }

    private var surfaceTone: AppSurfaceTone {
        switch tone {
        case .neutral:
            .standard
        case .accent, .success, .warning, .critical:
            .muted
        }
    }

    private var buttonIntent: AppButtonIntent {
        switch tone {
        case .accent:
            .primary
        case .success:
            .success
        case .warning:
            .warning
        case .critical:
            .critical
        case .neutral:
            .neutral
        }
    }

    private var iconRole: AppColorRole {
        switch tone {
        case .accent:
            .accentEmphasis
        case .success:
            .success
        case .warning:
            .warning
        case .critical:
            .critical
        case .neutral:
            .contentSecondary
        }
    }

    private var symbolName: String {
        switch tone {
        case .accent:
            "sparkles"
        case .success:
            "checkmark.seal.fill"
        case .warning:
            "exclamationmark.triangle.fill"
        case .critical:
            "xmark.octagon.fill"
        case .neutral:
            "info.circle.fill"
        }
    }
}
