import SwiftUI

public struct AppMenuField<Value: Hashable & Sendable>: View {
    @Binding private var selection: Value
    @Environment(\.appTheme) private var theme

    private let title: String
    private let options: [AppSelectionOption<Value>]
    private let helperText: String?
    private let accessibilityLabel: String?

    public init(
        _ title: String,
        selection: Binding<Value>,
        options: [AppSelectionOption<Value>],
        helperText: String? = nil,
        accessibilityLabel: String? = nil
    ) {
        self.title = title
        _selection = selection
        self.options = options
        self.helperText = helperText
        self.accessibilityLabel = accessibilityLabel
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            Text(title)
                .appTextStyle(.caption, color: .contentSecondary)

            Menu {
                ForEach(options) { option in
                    Button {
                        selection = option.value
                    } label: {
                        HStack {
                            if let systemImage = option.systemImage {
                                Image(systemName: systemImage)
                                    .accessibilityHidden(true)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(option.title)

                                if let detail = option.detail {
                                    Text(detail)
                                }
                            }

                            if selection == option.value {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: theme.spacing.small) {
                    if let systemImage = selectedOption?.systemImage {
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(AppThemeColor(.contentTertiary))
                            .accessibilityHidden(true)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(selectedOption?.title ?? "Select")
                            .appTextStyle(.body)

                        if let detail = selectedOption?.detail {
                            Text(detail)
                                .appTextStyle(.caption, color: .contentSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    Spacer(minLength: theme.spacing.small)

                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppThemeColor(.contentTertiary))
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, theme.spacing.medium)
                .frame(minHeight: 52)
                .background(
                    RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                        .fill(AppThemeColor(.surface))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                        .stroke(AppThemeColor(.border), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            if let helperText {
                Text(helperText)
                    .appTextStyle(.caption, color: .contentSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel ?? title)
        .accessibilityValue(selectedOption?.title ?? "")
    }

    private var selectedOption: AppSelectionOption<Value>? {
        options.first { $0.value == selection }
    }
}
