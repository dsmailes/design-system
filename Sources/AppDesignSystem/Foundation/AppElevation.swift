import CoreGraphics

public struct AppElevation: Sendable, Equatable {
    public let restingOpacity: CGFloat
    public let floatingOpacity: CGFloat
    public let floatingRadius: CGFloat
    public let floatingY: CGFloat

    public init(
        restingOpacity: CGFloat = 0,
        floatingOpacity: CGFloat = 0.12,
        floatingRadius: CGFloat = 28,
        floatingY: CGFloat = 12
    ) {
        self.restingOpacity = restingOpacity
        self.floatingOpacity = floatingOpacity
        self.floatingRadius = floatingRadius
        self.floatingY = floatingY
    }
}
