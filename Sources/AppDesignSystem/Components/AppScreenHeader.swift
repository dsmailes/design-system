import SwiftUI

public struct AppScreenHeader<Leading: View, Trailing: View>: View {
    @Environment(\.appTheme) private var theme

    private let eyebrow: String?
    private let title: String
    private let detail: String?
    private let leading: Leading
    private let trailing: Trailing

    public init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.eyebrow = eyebrow
        self.title = title
        self.detail = detail
        self.leading = leading()
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(alignment: .top, spacing: theme.spacing.medium) {
            HStack(spacing: theme.spacing.small) {
                leading

                VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
                    if let eyebrow {
                        Text(eyebrow.uppercased())
                            .appTextStyle(.eyebrow, color: .contentSecondary)
                    }

                    Text(title)
                        .appTextStyle(.title)
                        .fixedSize(horizontal: false, vertical: true)

                    if let detail {
                        Text(detail)
                            .appTextStyle(.detail, color: .contentSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            Spacer(minLength: theme.spacing.medium)

            trailing
        }
        .accessibilityElement(children: .contain)
    }
}

public extension AppScreenHeader where Leading == EmptyView, Trailing == EmptyView {
    init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil
    ) {
        self.init(
            eyebrow: eyebrow,
            title: title,
            detail: detail,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }
}

public extension AppScreenHeader where Leading == EmptyView {
    init(
        eyebrow: String? = nil,
        title: String,
        detail: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.init(
            eyebrow: eyebrow,
            title: title,
            detail: detail,
            leading: { EmptyView() },
            trailing: trailing
        )
    }
}
