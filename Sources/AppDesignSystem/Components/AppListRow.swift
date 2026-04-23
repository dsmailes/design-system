import SwiftUI

public struct AppListRow<Trailing: View>: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let subtitle: String?
    private let systemImage: String?
    private let trailing: Trailing

    public init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(alignment: .center, spacing: theme.spacing.medium) {
            if let systemImage {
                ZStack {
                    Circle()
                        .fill(AppThemeColor(.surfaceMuted))
                    Image(systemName: systemImage)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(AppThemeColor(.contentPrimary))
                }
                .frame(width: 40, height: 40)
                .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .appTextStyle(.bodyEmphasis)

                if let subtitle {
                    Text(subtitle)
                        .appTextStyle(.caption, color: .contentSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer(minLength: theme.spacing.medium)

            trailing
        }
        .padding(.vertical, theme.spacing.small)
        .accessibilityElement(children: .contain)
    }
}

public extension AppListRow where Trailing == EmptyView {
    init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil
    ) {
        self.init(
            title: title,
            subtitle: subtitle,
            systemImage: systemImage
        ) {
            EmptyView()
        }
    }
}
