import SwiftUI

public struct AppMetric: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let value: String
    private let delta: String?
    private let tone: AppTagTone

    public init(
        title: String,
        value: String,
        delta: String? = nil,
        tone: AppTagTone = .neutral
    ) {
        self.title = title
        self.value = value
        self.delta = delta
        self.tone = tone
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            Text(title)
                .appTextStyle(.caption, color: .contentSecondary)

            Text(value)
                .appTextStyle(.title)

            if let delta {
                AppTag(delta, tone: tone)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .appSurface(.muted)
    }
}
