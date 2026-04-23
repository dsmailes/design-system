import SwiftUI

public struct AppMultilineField: View {
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    @Environment(\.appTheme) private var theme

    private let title: String
    private let prompt: String
    private let minHeight: CGFloat
    private let helperText: String?
    private let fieldState: AppFieldState

    public init(
        _ title: String,
        text: Binding<String>,
        prompt: String = "",
        minHeight: CGFloat = 120,
        state: AppFieldState = .normal,
        helperText: String? = nil
    ) {
        self.title = title
        _text = text
        self.prompt = prompt
        self.minHeight = minHeight
        self.fieldState = state
        self.helperText = helperText
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            Text(title)
                .appTextStyle(.caption, color: .contentSecondary)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                    .fill(AppThemeColor(.surface))

                if text.isEmpty, !prompt.isEmpty {
                    Text(prompt)
                        .appTextStyle(.body, color: .contentTertiary)
                        .padding(.horizontal, theme.spacing.medium)
                        .padding(.vertical, theme.spacing.small)
                        .accessibilityHidden(true)
                }

                TextEditor(text: $text)
                    .focused($isFocused)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, theme.spacing.small)
                    .padding(.vertical, theme.spacing.xSmall)
                    .frame(minHeight: minHeight)
                    .appTextStyle(.body)
                    .background(Color.clear)
            }
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
    }

    private var borderRole: AppColorRole {
        if isFocused { return .accent }
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
