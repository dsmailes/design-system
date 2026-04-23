import SwiftUI

public struct AppTimelineRow: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let detail: String
    private let timestamp: String
    private let isComplete: Bool

    public init(
        title: String,
        detail: String,
        timestamp: String,
        isComplete: Bool = true
    ) {
        self.title = title
        self.detail = detail
        self.timestamp = timestamp
        self.isComplete = isComplete
    }

    public var body: some View {
        HStack(alignment: .top, spacing: theme.spacing.small) {
            VStack(spacing: 4) {
                Circle()
                    .fill(AppThemeColor(isComplete ? .accent : .surfaceMuted))
                    .frame(width: 12, height: 12)

                Rectangle()
                    .fill(AppThemeColor(.separator))
                    .frame(width: 1)
            }
            .padding(.top, 4)
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .appTextStyle(.bodyEmphasis)

                    Spacer(minLength: theme.spacing.small)

                    Text(timestamp)
                        .appTextStyle(.caption, color: .contentSecondary)
                }

                Text(detail)
                    .appTextStyle(.caption, color: .contentSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
