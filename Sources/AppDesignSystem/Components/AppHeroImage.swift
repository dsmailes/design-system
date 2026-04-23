import SwiftUI

public struct AppHeroImage<Overlay: View>: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let systemImage: String
    private let tintRole: AppColorRole
    private let animateSymbol: Bool
    private let overlay: Overlay

    public init(
        systemImage: String,
        tintRole: AppColorRole = .accent,
        animateSymbol: Bool = false,
        @ViewBuilder overlay: () -> Overlay
    ) {
        self.systemImage = systemImage
        self.tintRole = tintRole
        self.animateSymbol = animateSymbol
        self.overlay = overlay()
    }

    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: theme.radii.large, style: .continuous)
                .fill(AppThemeColor(.surfaceMuted))
                .overlay(
                    LinearGradient(
                        colors: [
                            .clear,
                            Color.black.opacity(0.08)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            Image(systemName: systemImage)
                .font(.system(size: 92, weight: .regular))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(AppThemeColor(tintRole))
                .symbolEffect(.pulse, isActive: animateSymbol && !reduceMotion)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(24)
                .accessibilityHidden(true)

            overlay
                .padding(20)
        }
        .frame(minHeight: 220)
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.large, style: .continuous)
                .stroke(AppThemeColor(.border), lineWidth: 1)
        )
    }
}

public extension AppHeroImage where Overlay == EmptyView {
    init(
        systemImage: String,
        tintRole: AppColorRole = .accent,
        animateSymbol: Bool = false
    ) {
        self.init(systemImage: systemImage, tintRole: tintRole, animateSymbol: animateSymbol) {
            EmptyView()
        }
    }
}
