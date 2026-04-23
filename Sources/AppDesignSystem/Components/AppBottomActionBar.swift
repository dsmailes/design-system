import SwiftUI

public struct AppBottomActionBar: View {
    @Environment(\.appTheme) private var theme

    private let primaryTitle: String
    private let secondaryTitle: String?
    private let primaryAction: () -> Void
    private let secondaryAction: (() -> Void)?
    private let primaryIntent: AppButtonIntent
    private let isPrimaryLoading: Bool

    public init(
        primaryTitle: String,
        secondaryTitle: String? = nil,
        primaryIntent: AppButtonIntent = .primary,
        isPrimaryLoading: Bool = false,
        primaryAction: @escaping () -> Void,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.primaryIntent = primaryIntent
        self.isPrimaryLoading = isPrimaryLoading
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    public var body: some View {
        VStack(spacing: theme.spacing.medium) {
            Divider()

            ViewThatFits {
                HStack(spacing: theme.spacing.small) {
                    secondaryButton
                    primaryButton
                }

                VStack(spacing: theme.spacing.small) {
                    primaryButton
                    secondaryButton
                }
            }
        }
        .padding(.top, theme.spacing.medium)
        .padding(.bottom, theme.spacing.small)
        .background(AppThemeColor(.canvas))
    }

    @ViewBuilder
    private var secondaryButton: some View {
        if let secondaryTitle, let secondaryAction {
            AppButton(
                secondaryTitle,
                intent: .neutral,
                emphasis: .subtle,
                action: secondaryAction
            )
        }
    }

    private var primaryButton: some View {
        AppButton(
            primaryTitle,
            intent: primaryIntent,
            isLoading: isPrimaryLoading,
            action: primaryAction
        )
    }
}
