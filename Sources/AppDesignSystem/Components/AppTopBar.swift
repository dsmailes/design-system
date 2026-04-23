import SwiftUI

public struct AppTopBar: View {
    private let eyebrow: String?
    private let title: String
    private let detail: String?

    public init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil
    ) {
        self.eyebrow = eyebrow
        self.title = title
        self.detail = detail
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let eyebrow {
                Text(eyebrow.uppercased())
                    .appTextStyle(.eyebrow, color: .contentSecondary)
            }

            Text(title)
                .appTextStyle(.display)
                .fixedSize(horizontal: false, vertical: true)

            if let detail {
                Text(detail)
                    .appTextStyle(.detail, color: .contentSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
