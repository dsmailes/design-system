import SwiftUI

public struct AppMediaBlock<Media: View>: View {
    @Environment(\.appTheme) private var theme

    private let eyebrow: String?
    private let title: String
    private let detail: String?
    private let media: Media

    public init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil,
        @ViewBuilder media: () -> Media
    ) {
        self.eyebrow = eyebrow
        self.title = title
        self.detail = detail
        self.media = media()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            media

            VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
                if let eyebrow {
                    Text(eyebrow.uppercased())
                        .appTextStyle(.eyebrow, color: .contentSecondary)
                }

                Text(title)
                    .appTextStyle(.section)

                if let detail {
                    Text(detail)
                        .appTextStyle(.detail, color: .contentSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
