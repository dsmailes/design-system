import SwiftUI

public enum AppTagTone: Sendable {
    case neutral
    case accent
    case success
    case warning
    case critical
}

public struct AppTag: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let systemImage: String?
    private let tone: AppTagTone

    public init(
        _ title: String,
        systemImage: String? = nil,
        tone: AppTagTone = .neutral
    ) {
        self.title = title
        self.systemImage = systemImage
        self.tone = tone
    }

    public var body: some View {
        HStack(spacing: theme.spacing.xSmall) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: 13, weight: .semibold))
            }
            Text(title)
                .appTextStyle(.caption, color: foregroundRole)
        }
        .padding(.horizontal, theme.spacing.small)
        .frame(minHeight: 32)
        .background(
            Capsule(style: .continuous)
                .fill(AppThemeColor(backgroundRole))
        )
        .overlay(
            Capsule(style: .continuous)
                .stroke(AppThemeColor(borderRole), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }

    private var backgroundRole: AppColorRole {
        switch tone {
        case .neutral:
            .surfaceMuted
        case .accent:
            .accent
        case .success:
            .success
        case .warning:
            .warning
        case .critical:
            .critical
        }
    }

    private var borderRole: AppColorRole {
        switch tone {
        case .neutral:
            .border
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

    private var foregroundRole: AppColorRole {
        switch tone {
        case .neutral:
            .contentPrimary
        case .accent, .critical:
            .accentForeground
        case .success, .warning:
            .contentPrimary
        }
    }
}
