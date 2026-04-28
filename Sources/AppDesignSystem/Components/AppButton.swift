import SwiftUI

public enum AppButtonIntent: Sendable {
    case primary
    case neutral
    case success
    case warning
    case critical
}

public enum AppButtonEmphasis: Sendable {
    case strong
    case subtle
    case ghost
}

public enum AppControlSize: Sendable {
    case compact
    case regular
    case large

    var minHeight: CGFloat {
        switch self {
        case .compact:
            44
        case .regular:
            50
        case .large:
            56
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .compact:
            14
        case .regular:
            18
        case .large:
            22
        }
    }

    var iconDimension: CGFloat {
        switch self {
        case .compact:
            15
        case .regular:
            17
        case .large:
            18
        }
    }
}

public struct AppButton: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled

    private let title: String
    private let systemImage: String?
    private let intent: AppButtonIntent
    private let emphasis: AppButtonEmphasis
    private let size: AppControlSize
    private let isLoading: Bool
    private let action: () -> Void

    public init(
        _ title: String,
        systemImage: String? = nil,
        intent: AppButtonIntent = .primary,
        emphasis: AppButtonEmphasis = .strong,
        size: AppControlSize = .regular,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.intent = intent
        self.emphasis = emphasis
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: theme.spacing.xSmall) {
                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                } else if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: size.iconDimension, weight: .semibold))
                        .symbolRenderingMode(.hierarchical)
                }

                Text(title)
                    .appTextStyle(.bodyEmphasis, color: foregroundRole)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: size.minHeight)
            .padding(.horizontal, size.horizontalPadding)
            .background(backgroundShape)
            .overlay(borderShape)
            .contentShape(RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous))
            .opacity(isEnabled ? 1 : 0.48)
        }
        .buttonStyle(AppPressableButtonStyle(theme: theme, reduceMotion: reduceMotion))
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }

    private var foregroundRole: AppColorRole {
        switch emphasis {
        case .strong:
            .accentForeground
        case .subtle, .ghost:
            resolvedTone.foreground
        }
    }

    private var backgroundShape: some View {
        RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous)
            .fill(backgroundRole.map(AppThemeColor.init) ?? AppThemeColor(.surface))
    }

    private var borderShape: some View {
        RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous)
            .stroke(borderRole.map(AppThemeColor.init) ?? AppThemeColor(.border), lineWidth: 1)
    }

    private var backgroundRole: AppColorRole? {
        switch emphasis {
        case .strong:
            resolvedTone.background
        case .subtle:
            .surface
        case .ghost:
            nil
        }
    }

    private var borderRole: AppColorRole? {
        switch emphasis {
        case .ghost:
            nil
        case .subtle:
            resolvedTone.background
        case .strong:
            resolvedTone.background
        }
    }

    private var resolvedTone: (background: AppColorRole, foreground: AppColorRole) {
        switch intent {
        case .primary:
            (.accent, .accentEmphasis)
        case .neutral:
            (.surfaceMuted, .contentPrimary)
        case .success:
            (.success, .contentPrimary)
        case .warning:
            (.warning, .contentPrimary)
        case .critical:
            (.critical, .critical)
        }
    }
}

private struct AppPressableButtonStyle: ButtonStyle {
    let theme: AppTheme
    let reduceMotion: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.985 : 1)
            .animation(
                .easeOut(duration: theme.motion.duration(reduceMotion: reduceMotion)),
                value: configuration.isPressed
            )
    }
}
