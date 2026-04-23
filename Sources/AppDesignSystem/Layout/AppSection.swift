import SwiftUI

public struct AppSection<Content: View>: View {
    @Environment(\.appTheme) private var theme

    private let tone: AppSurfaceTone?
    private let content: Content

    public init(
        tone: AppSurfaceTone? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.tone = tone
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .modifier(OptionalSurfaceModifier(tone: tone))
    }
}

private struct OptionalSurfaceModifier: ViewModifier {
    let tone: AppSurfaceTone?

    func body(content: Content) -> some View {
        if let tone {
            content.appSurface(tone)
        } else {
            content
        }
    }
}
