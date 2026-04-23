import SwiftUI

public struct AppToggleRow: View {
    @Binding private var isOn: Bool
    @Environment(\.appTheme) private var theme

    private let title: String
    private let subtitle: String?

    public init(
        title: String,
        subtitle: String? = nil,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.subtitle = subtitle
        _isOn = isOn
    }

    public var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .appTextStyle(.bodyEmphasis)

                if let subtitle {
                    Text(subtitle)
                        .appTextStyle(.caption, color: .contentSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.trailing, theme.spacing.medium)
        }
        .toggleStyle(.switch)
        .frame(minHeight: 52)
        .accessibilityElement(children: .combine)
    }
}
