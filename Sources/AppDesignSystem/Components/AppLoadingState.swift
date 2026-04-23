import SwiftUI

public struct AppLoadingState: View {
    @Environment(\.appTheme) private var theme

    private let title: String
    private let message: String?
    private let placeholderRows: Int

    public init(
        title: String = "Loading",
        message: String? = nil,
        placeholderRows: Int = 3
    ) {
        self.title = title
        self.message = message
        self.placeholderRows = placeholderRows
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            HStack(spacing: theme.spacing.small) {
                ProgressView()
                    .controlSize(.small)

                Text(title)
                    .appTextStyle(.bodyEmphasis)
            }

            if let message {
                Text(message)
                    .appTextStyle(.detail, color: .contentSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            VStack(alignment: .leading, spacing: theme.spacing.small) {
                ForEach(0..<placeholderRows, id: \.self) { index in
                    RoundedRectangle(cornerRadius: theme.radii.small, style: .continuous)
                        .fill(AppThemeColor(.surfaceMuted))
                        .frame(
                            maxWidth: index == placeholderRows - 1 ? 180 : .infinity,
                            minHeight: 12,
                            maxHeight: 12
                        )
                }
            }
            .redacted(reason: .placeholder)
        }
        .appSurface(.muted)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message.map { "\(title). \($0)" } ?? title)
    }
}
