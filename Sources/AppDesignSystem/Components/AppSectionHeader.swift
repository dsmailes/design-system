import SwiftUI

public struct AppSectionHeader: View {
    private let title: String
    private let detail: String?
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(
        title: String,
        detail: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.detail = detail
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .appTextStyle(.section)

                if let detail {
                    Text(detail)
                        .appTextStyle(.detail, color: .contentSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer(minLength: 12)

            if let actionTitle, let action {
                AppButton(
                    actionTitle,
                    intent: .neutral,
                    emphasis: .ghost,
                    size: .compact,
                    action: action
                )
                .fixedSize()
            }
        }
        .accessibilityElement(children: .contain)
    }
}
