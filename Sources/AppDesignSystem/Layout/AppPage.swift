import SwiftUI

public struct AppPageStyle: @unchecked Sendable {
    public var alignment: HorizontalAlignment
    public var scrolls: Bool

    public init(
        alignment: HorizontalAlignment = .leading,
        scrolls: Bool = true
    ) {
        self.alignment = alignment
        self.scrolls = scrolls
    }

    public static let standard = AppPageStyle()
}

private struct AppPageStyleKey: EnvironmentKey {
    static let defaultValue = AppPageStyle.standard
}

public extension EnvironmentValues {
    var appPageStyle: AppPageStyle {
        get { self[AppPageStyleKey.self] }
        set { self[AppPageStyleKey.self] = newValue }
    }
}

public struct AppPage<Content: View>: View {
    private let alignment: HorizontalAlignment?
    private let scrolls: Bool?
    private let content: AnyView

    public init(
        alignment: HorizontalAlignment = .leading,
        scrolls: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.scrolls = scrolls
        self.content = AnyView(content())
    }

    public var body: some View {
        AppPageContainer(
            alignment: alignment,
            scrolls: scrolls,
            content: content
        )
    }
}

private struct AppPageContainer: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.appPageStyle) private var environmentStyle

    private let alignment: HorizontalAlignment?
    private let scrolls: Bool?
    private let content: AnyView

    init(
        alignment: HorizontalAlignment?,
        scrolls: Bool?,
        content: AnyView
    ) {
        self.alignment = alignment
        self.scrolls = scrolls
        self.content = content
    }

    var body: some View {
        let resolvedStyle = AppPageStyle(
            alignment: alignment ?? environmentStyle.alignment,
            scrolls: scrolls ?? environmentStyle.scrolls
        )

        Group {
            if resolvedStyle.scrolls {
                ScrollView {
                    contentStack(alignment: resolvedStyle.alignment)
                }
                .scrollIndicators(.hidden)
            } else {
                contentStack(alignment: resolvedStyle.alignment)
            }
        }
        .background {
            Rectangle()
                .fill(AppThemeColor(.canvas))
                .ignoresSafeArea()
        }
    }

    private func contentStack(alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: theme.spacing.sectionGap) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, theme.spacing.pageInset)
        .padding(.vertical, theme.spacing.xLarge)
    }
}

public extension View {
    func appPage(
        alignment: HorizontalAlignment? = nil,
        scrolls: Bool? = nil
    ) -> some View {
        AppPageContainer(
            alignment: alignment,
            scrolls: scrolls,
            content: AnyView(self)
        )
    }

    func appPageStyle(_ style: AppPageStyle) -> some View {
        environment(\.appPageStyle, style)
    }
}
