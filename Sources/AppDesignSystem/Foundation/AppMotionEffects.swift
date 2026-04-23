import SwiftUI

public enum AppEntranceDirection: Sendable {
    case none
    case bottom
    case leading
    case trailing
}

public struct AppEntranceReveal: ViewModifier {
    @Environment(\.appTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isVisible = false

    private let direction: AppEntranceDirection
    private let distance: CGFloat
    private let delay: Double

    public init(
        direction: AppEntranceDirection = .bottom,
        distance: CGFloat = 20,
        delay: Double = 0
    ) {
        self.direction = direction
        self.distance = distance
        self.delay = delay
    }

    public func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(offset)
            .onAppear {
                let animation = theme.motion.animation(reduceMotion: reduceMotion, emphasis: true)
                if delay > 0, !reduceMotion {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        withAnimation(animation) {
                            isVisible = true
                        }
                    }
                } else {
                    withAnimation(animation) {
                        isVisible = true
                    }
                }
            }
    }

    private var offset: CGSize {
        guard !reduceMotion, !isVisible else { return .zero }

        switch direction {
        case .none:
            return .zero
        case .bottom:
            return CGSize(width: 0, height: distance)
        case .leading:
            return CGSize(width: -distance, height: 0)
        case .trailing:
            return CGSize(width: distance, height: 0)
        }
    }
}

public extension View {
    func appEntranceReveal(
        direction: AppEntranceDirection = .bottom,
        distance: CGFloat = 20,
        delay: Double = 0
    ) -> some View {
        modifier(AppEntranceReveal(direction: direction, distance: distance, delay: delay))
    }
}
