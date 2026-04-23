import SwiftUI

public struct AppSearchBar: View {
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    @Environment(\.appTheme) private var theme

    private let prompt: String
    private let accessibilityLabel: String
    private let isBusy: Bool

    public init(
        text: Binding<String>,
        prompt: String = "Search",
        accessibilityLabel: String = "Search",
        isBusy: Bool = false
    ) {
        _text = text
        self.prompt = prompt
        self.accessibilityLabel = accessibilityLabel
        self.isBusy = isBusy
    }

    public var body: some View {
        HStack(spacing: theme.spacing.small) {
            Group {
                if isBusy {
                    ProgressView()
                        .controlSize(.small)
                } else {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16, weight: .medium))
                        .symbolRenderingMode(.hierarchical)
                }
            }
            .foregroundStyle(AppThemeColor(isFocused ? .accent : .contentTertiary))
            .accessibilityHidden(true)

            TextField(
                "",
                text: $text,
                prompt: Text(prompt).foregroundStyle(AppThemeColor(.contentTertiary))
            )
            .focused($isFocused)
            .appPlatformTextInputBehavior()
            .appTextStyle(.body)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppThemeColor(.contentTertiary))
                        .frame(width: 28, height: 28)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, theme.spacing.medium)
        .frame(minHeight: 52)
        .background(
            RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous)
                .fill(AppThemeColor(.surface))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous)
                .stroke(AppThemeColor(isFocused ? .accent : .border), lineWidth: isFocused ? 2 : 1)
        )
        .accessibilityLabel(accessibilityLabel)
    }
}
