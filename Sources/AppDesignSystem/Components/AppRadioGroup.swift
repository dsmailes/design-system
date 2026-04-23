import SwiftUI

public struct AppRadioGroup<Value: Hashable & Sendable>: View {
    @Binding private var selection: Value
    @Environment(\.appTheme) private var theme

    private let title: String?
    private let options: [AppSelectionOption<Value>]

    public init(
        title: String? = nil,
        selection: Binding<Value>,
        options: [AppSelectionOption<Value>]
    ) {
        self.title = title
        _selection = selection
        self.options = options
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            if let title {
                Text(title)
                    .appTextStyle(.caption, color: .contentSecondary)
            }

            ForEach(options) { option in
                Button {
                    selection = option.value
                } label: {
                    HStack(alignment: .top, spacing: theme.spacing.small) {
                        Image(systemName: selection == option.value ? "largecircle.fill.circle" : "circle")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(
                                AppThemeColor(selection == option.value ? .accent : .contentTertiary)
                            )
                            .padding(.top, 2)
                            .accessibilityHidden(true)

                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: theme.spacing.xSmall) {
                                if let systemImage = option.systemImage {
                                    Image(systemName: systemImage)
                                        .font(.system(size: 14, weight: .medium))
                                        .symbolRenderingMode(.hierarchical)
                                        .accessibilityHidden(true)
                                }

                                Text(option.title)
                                    .appTextStyle(.bodyEmphasis)
                            }

                            if let detail = option.detail {
                                Text(detail)
                                    .appTextStyle(.caption, color: .contentSecondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        Spacer(minLength: theme.spacing.small)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, theme.spacing.medium)
                    .padding(.vertical, theme.spacing.small)
                    .background(
                        RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                            .fill(selection == option.value ? AppThemeColor(.surfaceMuted) : AppThemeColor(.surface))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                            .stroke(
                                selection == option.value ? AppThemeColor(.accent) : AppThemeColor(.border),
                                lineWidth: selection == option.value ? 2 : 1
                            )
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(option.title)
                .accessibilityHint(option.detail ?? "")
                .accessibilityAddTraits(selection == option.value ? [.isButton, .isSelected] : .isButton)
            }
        }
        .accessibilityElement(children: .contain)
    }
}
