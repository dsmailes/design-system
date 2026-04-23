import SwiftUI

public enum AppStatePanelTone: Sendable {
    case neutral
    case accent
    case success
    case warning
    case critical
}

public struct AppStatePanel: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let message: String
    private let tone: AppStatePanelTone
    private let systemImage: String
    private let primaryTitle: String?
    private let secondaryTitle: String?
    private let primaryAction: (() -> Void)?
    private let secondaryAction: (() -> Void)?

    public init(
        title: String,
        message: String,
        tone: AppStatePanelTone = .neutral,
        systemImage: String? = nil,
        primaryTitle: String? = nil,
        secondaryTitle: String? = nil,
        primaryAction: (() -> Void)? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.tone = tone
        self.systemImage = systemImage ?? AppStatePanel.defaultSymbol(for: tone)
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            HStack(alignment: .top, spacing: theme.spacing.small) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppThemeColor(iconRole))
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
                    Text(title)
                        .appTextStyle(.section)

                    Text(message)
                        .appTextStyle(.detail, color: .contentSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            if primaryTitle != nil || secondaryTitle != nil {
                ViewThatFits {
                    HStack(spacing: theme.spacing.small) {
                        buttons
                    }

                    VStack(spacing: theme.spacing.small) {
                        buttons
                    }
                }
            }
        }
        .appSurface(surfaceTone)
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder
    private var buttons: some View {
        if let primaryTitle, let primaryAction {
            AppButton(
                primaryTitle,
                intent: primaryIntent,
                emphasis: .strong,
                action: primaryAction
            )
        }

        if let secondaryTitle, let secondaryAction {
            AppButton(
                secondaryTitle,
                intent: .neutral,
                emphasis: .subtle,
                action: secondaryAction
            )
        }
    }

    private var surfaceTone: AppSurfaceTone {
        switch tone {
        case .neutral:
            .standard
        case .accent, .success, .warning, .critical:
            .muted
        }
    }

    private var iconRole: AppColorRole {
        switch tone {
        case .neutral:
            .contentSecondary
        case .accent:
            .accentEmphasis
        case .success:
            .success
        case .warning:
            .warning
        case .critical:
            .critical
        }
    }

    private var primaryIntent: AppButtonIntent {
        switch tone {
        case .neutral:
            .neutral
        case .accent:
            .primary
        case .success:
            .success
        case .warning:
            .warning
        case .critical:
            .critical
        }
    }

    private static func defaultSymbol(for tone: AppStatePanelTone) -> String {
        switch tone {
        case .neutral:
            "info.circle.fill"
        case .accent:
            "sparkles"
        case .success:
            "checkmark.seal.fill"
        case .warning:
            "exclamationmark.triangle.fill"
        case .critical:
            "xmark.octagon.fill"
        }
    }
}
