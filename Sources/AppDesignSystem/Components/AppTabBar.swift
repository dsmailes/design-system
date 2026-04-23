import SwiftUI

public struct AppTabItem<Value: Hashable & Sendable>: Identifiable, Equatable, Sendable {
    public let value: Value
    public let title: String
    public let systemImage: String
    public let badge: String?

    public var id: Value { value }

    public init(
        value: Value,
        title: String,
        systemImage: String,
        badge: String? = nil
    ) {
        self.value = value
        self.title = title
        self.systemImage = systemImage
        self.badge = badge
    }
}

public struct AppTabBar<Value: Hashable & Sendable>: View {
    @Binding private var selection: Value
    @Environment(\.appTheme) private var theme
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let items: [AppTabItem<Value>]

    public init(
        selection: Binding<Value>,
        items: [AppTabItem<Value>]
    ) {
        _selection = selection
        self.items = items
    }

    public var body: some View {
        layout {
            ForEach(items) { item in
                tabButton(for: item)
            }
        }
        .padding(.horizontal, theme.spacing.small)
        .padding(.vertical, theme.spacing.small)
        .background(
            RoundedRectangle(cornerRadius: theme.radii.large, style: .continuous)
                .fill(AppThemeColor(.surface))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.large, style: .continuous)
                .stroke(AppThemeColor(.border), lineWidth: 1)
        )
    }

    @ViewBuilder
    private func layout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(spacing: theme.spacing.xSmall) {
                content()
            }
        } else {
            HStack(spacing: theme.spacing.xSmall) {
                content()
            }
        }
    }

    private func tabButton(for item: AppTabItem<Value>) -> some View {
        Button {
            selection = item.value
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: item.systemImage)
                        .font(.system(size: 16, weight: .semibold))
                        .symbolRenderingMode(selection == item.value ? .hierarchical : .monochrome)

                    if let badge = item.badge {
                        Text(badge)
                            .appTextStyle(.caption, color: .accentForeground)
                            .padding(.horizontal, 6)
                            .frame(minHeight: 18)
                            .background(
                                Capsule(style: .continuous)
                                    .fill(AppThemeColor(.accent))
                            )
                            .offset(x: 12, y: -8)
                    }
                }

                Text(item.title)
                    .appTextStyle(
                        .caption,
                        color: selection == item.value ? .contentPrimary : .contentSecondary
                    )
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 52)
            .padding(.horizontal, theme.spacing.small)
            .background {
                if selection == item.value {
                    RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                        .fill(AppThemeColor(.surfaceMuted))
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(item.title)
        .accessibilityValue(selection == item.value ? "Selected" : "")
        .accessibilityAddTraits(selection == item.value ? [.isButton, .isSelected] : .isButton)
    }
}
