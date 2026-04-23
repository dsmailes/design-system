import CoreGraphics
import SwiftUI

public struct AppMotion: Sendable, Equatable {
    public let quick: CGFloat
    public let standard: CGFloat
    public let emphasis: CGFloat

    public init(
        quick: CGFloat = 0.16,
        standard: CGFloat = 0.24,
        emphasis: CGFloat = 0.34
    ) {
        self.quick = quick
        self.standard = standard
        self.emphasis = emphasis
    }

    public func duration(
        reduceMotion: Bool,
        emphasis: Bool = false
    ) -> CGFloat {
        if reduceMotion {
            return 0.01
        }
        return emphasis ? self.emphasis : standard
    }

    public func animation(
        reduceMotion: Bool,
        emphasis: Bool = false
    ) -> Animation {
        .easeOut(duration: duration(reduceMotion: reduceMotion, emphasis: emphasis))
    }
}
