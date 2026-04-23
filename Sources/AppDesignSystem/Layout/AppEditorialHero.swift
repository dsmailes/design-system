import SwiftUI

public struct AppEditorialHero<Actions: View, Media: View>: View {
    @Environment(\.appTheme) private var theme

    private let eyebrow: String?
    private let title: String
    private let detail: String?
    private let actions: Actions
    private let media: Media

    public init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil,
        @ViewBuilder actions: () -> Actions,
        @ViewBuilder media: () -> Media
    ) {
        self.eyebrow = eyebrow
        self.title = title
        self.detail = detail
        self.actions = actions()
        self.media = media()
    }

    public var body: some View {
        AppSplitWorkspace {
            VStack(alignment: .leading, spacing: theme.spacing.large) {
                VStack(alignment: .leading, spacing: theme.spacing.small) {
                    if let eyebrow {
                        Text(eyebrow.uppercased())
                            .appTextStyle(.eyebrow, color: .contentSecondary)
                    }

                    Text(title)
                        .appTextStyle(.display)
                        .fixedSize(horizontal: false, vertical: true)

                    if let detail {
                        Text(detail)
                            .appTextStyle(.detail, color: .contentSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                actions
            }
        } secondary: {
            media
        }
    }
}

public extension AppEditorialHero where Actions == EmptyView {
    init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil,
        @ViewBuilder media: () -> Media
    ) {
        self.init(
            eyebrow: eyebrow,
            title: title,
            detail: detail,
            actions: { EmptyView() },
            media: media
        )
    }
}
