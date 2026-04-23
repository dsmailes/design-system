import SwiftUI

public struct AppModalScaffold<Content: View>: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let detail: String?
    private let primaryTitle: String
    private let secondaryTitle: String?
    private let primaryIntent: AppButtonIntent
    private let isPrimaryLoading: Bool
    private let primaryAction: () -> Void
    private let secondaryAction: (() -> Void)?
    private let content: Content

    public init(
        title: String,
        detail: String? = nil,
        primaryTitle: String,
        secondaryTitle: String? = nil,
        primaryIntent: AppButtonIntent = .primary,
        isPrimaryLoading: Bool = false,
        primaryAction: @escaping () -> Void,
        secondaryAction: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.detail = detail
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.primaryIntent = primaryIntent
        self.isPrimaryLoading = isPrimaryLoading
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.large) {
            Capsule(style: .continuous)
                .fill(AppThemeColor(.separator))
                .frame(width: 42, height: 5)
                .frame(maxWidth: .infinity)
                .accessibilityHidden(true)

            AppScreenHeader(
                title: title,
                detail: detail
            )

            content
                .frame(maxWidth: .infinity, alignment: .leading)

            AppBottomActionBar(
                primaryTitle: primaryTitle,
                secondaryTitle: secondaryTitle,
                primaryIntent: primaryIntent,
                isPrimaryLoading: isPrimaryLoading,
                primaryAction: primaryAction,
                secondaryAction: secondaryAction
            )
        }
        .padding(.horizontal, theme.spacing.pageInset)
        .padding(.top, theme.spacing.medium)
        .padding(.bottom, theme.spacing.medium)
        .background(AppThemeColor(.canvas))
    }
}
