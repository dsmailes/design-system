import CoreGraphics

public struct AppRadii: Sendable, Equatable {
    public let small: CGFloat
    public let medium: CGFloat
    public let large: CGFloat
    public let pill: CGFloat

    public init(
        small: CGFloat = 12,
        medium: CGFloat = 18,
        large: CGFloat = 28,
        pill: CGFloat = 999
    ) {
        self.small = small
        self.medium = medium
        self.large = large
        self.pill = pill
    }
}
