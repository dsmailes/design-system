import SwiftUI

public struct AppGroupedListSection<Content: View>: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let detail: String?
    private let content: Content

    public init(
        title: String,
        detail: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.detail = detail
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            AppSectionHeader(title: title, detail: detail)

            VStack(spacing: 0) {
                content
            }
            .appSurface(.standard)
        }
    }
}
