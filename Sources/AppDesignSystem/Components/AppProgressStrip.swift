import SwiftUI

public struct AppProgressStrip: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let value: Double
    private let detail: String?

    public init(
        title: String,
        value: Double,
        detail: String? = nil
    ) {
        self.title = title
        self.value = min(max(value, 0), 1)
        self.detail = detail
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            HStack {
                Text(title)
                    .appTextStyle(.bodyEmphasis)

                Spacer()

                Text("\(Int(value * 100))%")
                    .appTextStyle(.caption, color: .contentSecondary)
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule(style: .continuous)
                        .fill(AppThemeColor(.surfaceMuted))

                    Capsule(style: .continuous)
                        .fill(AppThemeColor(.accent))
                        .frame(width: proxy.size.width * value)
                }
            }
            .frame(height: 10)

            if let detail {
                Text(detail)
                    .appTextStyle(.caption, color: .contentSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityValue("\(Int(value * 100)) percent")
    }
}
