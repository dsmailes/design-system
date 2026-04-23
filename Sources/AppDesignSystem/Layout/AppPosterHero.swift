import SwiftUI

public struct AppPosterHero<Actions: View, Visual: View>: View {
    @Environment(\.appTheme) private var theme

    private let eyebrow: String?
    private let brand: String?
    private let title: String
    private let detail: String?
    private let minHeight: CGFloat
    private let actions: Actions
    private let visual: Visual

    public init(
        eyebrow: String? = nil,
        brand: String? = nil,
        title: String,
        detail: String? = nil,
        minHeight: CGFloat = 420,
        @ViewBuilder actions: () -> Actions,
        @ViewBuilder visual: () -> Visual
    ) {
        self.eyebrow = eyebrow
        self.brand = brand
        self.title = title
        self.detail = detail
        self.minHeight = minHeight
        self.actions = actions()
        self.visual = visual()
    }

    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            visual
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            LinearGradient(
                colors: [
                    Color.clear,
                    Color.black.opacity(0.16),
                    Color.black.opacity(0.34)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: theme.spacing.large) {
                VStack(alignment: .leading, spacing: theme.spacing.small) {
                    if let brand {
                        Text(brand)
                            .appTextStyle(.title, color: .accentForeground)
                    }

                    if let eyebrow {
                        Text(eyebrow.uppercased())
                            .appTextStyle(.eyebrow, color: .accentForeground)
                    }

                    Text(title)
                        .appTextStyle(.display, color: .accentForeground)
                        .fixedSize(horizontal: false, vertical: true)

                    if let detail {
                        Text(detail)
                            .appTextStyle(.detail, color: .accentForeground)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                actions
            }
            .frame(maxWidth: 540, alignment: .leading)
            .padding(.horizontal, theme.spacing.pageInset)
            .padding(.vertical, theme.spacing.xxLarge)
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .background(AppThemeColor(.surfaceMuted))
        .padding(.horizontal, -theme.spacing.pageInset)
    }
}

public extension AppPosterHero where Actions == EmptyView {
    init(
        eyebrow: String? = nil,
        brand: String? = nil,
        title: String,
        detail: String? = nil,
        minHeight: CGFloat = 420,
        @ViewBuilder visual: () -> Visual
    ) {
        self.init(
            eyebrow: eyebrow,
            brand: brand,
            title: title,
            detail: detail,
            minHeight: minHeight,
            actions: { EmptyView() },
            visual: visual
        )
    }
}
