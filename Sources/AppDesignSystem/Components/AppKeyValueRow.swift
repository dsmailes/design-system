import SwiftUI

public struct AppKeyValueRow: View {
    private let title: String
    private let value: String
    private let valueRole: AppColorRole

    public init(
        title: String,
        value: String,
        valueRole: AppColorRole = .contentPrimary
    ) {
        self.title = title
        self.value = value
        self.valueRole = valueRole
    }

    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(title)
                .appTextStyle(.detail, color: .contentSecondary)

            Spacer()

            Text(value)
                .appTextStyle(.bodyEmphasis, color: valueRole)
        }
        .accessibilityElement(children: .combine)
    }
}
