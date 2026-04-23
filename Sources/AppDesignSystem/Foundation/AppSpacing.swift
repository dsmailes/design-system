import CoreGraphics

public struct AppSpacing: Sendable, Equatable {
    public let xxSmall: CGFloat
    public let xSmall: CGFloat
    public let small: CGFloat
    public let medium: CGFloat
    public let large: CGFloat
    public let xLarge: CGFloat
    public let xxLarge: CGFloat
    public let pageInset: CGFloat
    public let sectionGap: CGFloat

    public init(
        xxSmall: CGFloat = 4,
        xSmall: CGFloat = 8,
        small: CGFloat = 12,
        medium: CGFloat = 16,
        large: CGFloat = 24,
        xLarge: CGFloat = 32,
        xxLarge: CGFloat = 48,
        pageInset: CGFloat = 20,
        sectionGap: CGFloat = 28
    ) {
        self.xxSmall = xxSmall
        self.xSmall = xSmall
        self.small = small
        self.medium = medium
        self.large = large
        self.xLarge = xLarge
        self.xxLarge = xxLarge
        self.pageInset = pageInset
        self.sectionGap = sectionGap
    }
}
