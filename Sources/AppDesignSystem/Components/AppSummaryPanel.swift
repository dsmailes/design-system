import SwiftUI

public struct AppSummaryPanel<Content: View>: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let detail: String?
    private let tone: AppSurfaceTone
    private let content: Content

    public init(
        title: String,
        detail: String? = nil,
        tone: AppSurfaceTone = .standard,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.detail = detail
        self.tone = tone
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            AppSectionHeader(title: title, detail: detail)
            content
        }
        .appSurface(tone)
    }
}
