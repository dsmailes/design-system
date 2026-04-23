import SwiftUI

public enum AppFieldState: Sendable {
    case normal
    case success
    case warning
    case error
}

public struct AppTextField: View {
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    @Environment(\.appTheme) private var theme

    private let title: String
    private let prompt: String
    private let systemImage: String?
    private let fieldState: AppFieldState
    private let helperText: String?
    private let accessibilityLabel: String?

    public init(
        _ title: String,
        text: Binding<String>,
        prompt: String = "",
        systemImage: String? = nil,
        state: AppFieldState = .normal,
        helperText: String? = nil,
        accessibilityLabel: String? = nil
    ) {
        self.title = title
        _text = text
        self.prompt = prompt
        self.systemImage = systemImage
        self.fieldState = state
        self.helperText = helperText
        self.accessibilityLabel = accessibilityLabel
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            Text(title)
                .appTextStyle(.caption, color: .contentSecondary)

            HStack(spacing: theme.spacing.small) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(AppThemeColor(isFocused ? borderRole : .contentTertiary))
                        .accessibilityHidden(true)
                }

                TextField(
                    "",
                    text: $text,
                    prompt: Text(prompt).foregroundStyle(AppThemeColor(.contentTertiary))
                )
                .focused($isFocused)
                .appPlatformTextInputBehavior()
                .appTextStyle(.body)
            }
            .padding(.horizontal, theme.spacing.medium)
            .frame(minHeight: 52)
            .background(
                RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                    .fill(AppThemeColor(.surface))
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                    .stroke(AppThemeColor(borderRole), lineWidth: isFocused ? 2 : 1)
            )

            if let helperText {
                Text(helperText)
                    .appTextStyle(.caption, color: helperRole)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel ?? title)
    }

    private var borderRole: AppColorRole {
        if isFocused {
            return .accent
        }

        switch fieldState {
        case .normal:
            return .border
        case .success:
            return .success
        case .warning:
            return .warning
        case .error:
            return .critical
        }
    }

    private var helperRole: AppColorRole {
        switch fieldState {
        case .normal:
            .contentSecondary
        case .success:
            .success
        case .warning:
            .warning
        case .error:
            .critical
        }
    }
}
