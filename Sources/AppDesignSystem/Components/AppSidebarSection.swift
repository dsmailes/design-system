import SwiftUI

public struct AppSidebarSection<Content: View>: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let detail: String?
    private let content: Content

    public init(
        title: String,
        detail: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.detail = detail
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .appTextStyle(.section)

                if let detail {
                    Text(detail)
                        .appTextStyle(.caption, color: .contentSecondary)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                content
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, theme.spacing.xSmall)
    }
}

public struct AppSidebarItem<Value: Hashable & Sendable>: View {
    @Binding private var selection: Value
    @Environment(\.appTheme) private var theme

    private let value: Value
    private let title: String
    private let subtitle: String?
    private let systemImage: String

    public init(
        value: Value,
        selection: Binding<Value>,
        title: String,
        subtitle: String? = nil,
        systemImage: String
    ) {
        self.value = value
        _selection = selection
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
    }

    public var body: some View {
        Button {
            selection = value
        } label: {
            HStack(spacing: theme.spacing.small) {
                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 20)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .appTextStyle(.bodyEmphasis)

                    if let subtitle {
                        Text(subtitle)
                            .appTextStyle(.caption, color: .contentSecondary)
                    }
                }

                Spacer(minLength: theme.spacing.small)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, theme.spacing.medium)
            .padding(.vertical, theme.spacing.small)
            .background {
                if selection == value {
                    RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                        .fill(AppThemeColor(.surfaceMuted))
                }
            }
            .overlay {
                if selection == value {
                    RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                        .stroke(AppThemeColor(.accent), lineWidth: 1.5)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityHint(subtitle ?? "")
        .accessibilityAddTraits(selection == value ? [.isButton, .isSelected] : .isButton)
    }
}
