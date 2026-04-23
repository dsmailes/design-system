import SwiftUI

public struct AppActionPanel: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let message: String
    private let primaryTitle: String
    private let secondaryTitle: String?
    private let primaryIntent: AppButtonIntent
    private let primaryAction: () -> Void
    private let secondaryAction: (() -> Void)?

    public init(
        title: String,
        message: String,
        primaryTitle: String,
        secondaryTitle: String? = nil,
        primaryIntent: AppButtonIntent = .primary,
        primaryAction: @escaping () -> Void,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.primaryIntent = primaryIntent
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            Text(title)
                .appTextStyle(.section)

            Text(message)
                .appTextStyle(.detail, color: .contentSecondary)
                .fixedSize(horizontal: false, vertical: true)

            ViewThatFits {
                HStack(spacing: theme.spacing.small) {
                    buttons
                }

                VStack(spacing: theme.spacing.small) {
                    buttons
                }
            }
        }
        .appSurface(.standard)
    }

    @ViewBuilder
    private var buttons: some View {
        AppButton(primaryTitle, intent: primaryIntent, action: primaryAction)

        if let secondaryTitle, let secondaryAction {
            AppButton(
                secondaryTitle,
                intent: .neutral,
                emphasis: .subtle,
                action: secondaryAction
            )
        }
    }
}
