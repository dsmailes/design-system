import SwiftUI

public struct AppValidationSummary: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let messages: [String]
    private let tone: AppStatePanelTone

    public init(
        title: String = "Check this before continuing",
        messages: [String],
        tone: AppStatePanelTone = .critical
    ) {
        self.title = title
        self.messages = messages
        self.tone = tone
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            HStack(spacing: theme.spacing.small) {
                Image(systemName: symbolName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppThemeColor(iconRole))
                    .accessibilityHidden(true)

                Text(title)
                    .appTextStyle(.bodyEmphasis)
            }

            VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
                ForEach(messages, id: \.self) { message in
                    HStack(alignment: .top, spacing: theme.spacing.xSmall) {
                        Text("•")
                            .appTextStyle(.detail, color: .contentSecondary)
                        Text(message)
                            .appTextStyle(.detail, color: .contentSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .appSurface(.muted)
        .accessibilityElement(children: .contain)
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

    private var symbolName: String {
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
