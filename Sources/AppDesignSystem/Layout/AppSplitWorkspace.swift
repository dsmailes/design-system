import SwiftUI

public struct AppSplitWorkspace<Primary: View, Secondary: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.appTheme) private var theme

    private let primary: Primary
    private let secondary: Secondary

    public init(
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary
    ) {
        self.primary = primary()
        self.secondary = secondary()
    }

    public var body: some View {
        layout {
            primary
                .frame(maxWidth: .infinity, alignment: .leading)

            secondary
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var layout: AnyLayout {
        if dynamicTypeSize.isAccessibilitySize {
            AnyLayout(VStackLayout(spacing: theme.spacing.large))
        } else {
            AnyLayout(HStackLayout(alignment: .top, spacing: theme.spacing.large))
        }
    }
}
