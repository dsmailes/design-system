import SwiftUI

public struct AppPage<Content: View>: View {
    @Environment(\.appTheme) private var theme

    private let alignment: HorizontalAlignment
    private let scrolls: Bool
    private let content: Content

    public init(
        alignment: HorizontalAlignment = .leading,
        scrolls: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.scrolls = scrolls
        self.content = content()
    }

    public var body: some View {
        Group {
            if scrolls {
                ScrollView {
                    contentStack
                }
                .scrollIndicators(.hidden)
            } else {
                contentStack
            }
        }
        .background {
            Rectangle()
                .fill(AppThemeColor(.canvas))
                .ignoresSafeArea()
        }
    }

    private var contentStack: some View {
        VStack(alignment: alignment, spacing: theme.spacing.sectionGap) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, theme.spacing.pageInset)
        .padding(.vertical, theme.spacing.xLarge)
    }
}
