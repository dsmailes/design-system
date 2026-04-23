import SwiftUI

public struct AppEmptyState: View {
    @Environment(\.appTheme) private var theme

    private let systemImage: String
    private let title: String
    private let message: String
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(
        systemImage: String,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.systemImage = systemImage
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            Image(systemName: systemImage)
                .font(.system(size: 28, weight: .regular))
                .foregroundStyle(AppThemeColor(.accentEmphasis))
                .accessibilityHidden(true)

            Text(title)
                .appTextStyle(.title)

            Text(message)
                .appTextStyle(.detail, color: .contentSecondary)
                .fixedSize(horizontal: false, vertical: true)

            if let actionTitle, let action {
                AppButton(actionTitle, systemImage: "plus", action: action)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .appSurface(.muted)
        .accessibilityElement(children: .contain)
    }
}
