import SwiftUI

public struct AppSelectionOption<Value: Hashable & Sendable>: Identifiable, Equatable, Sendable {
    public let value: Value
    public let title: String
    public let detail: String?
    public let systemImage: String?

    public var id: Value { value }

    public init(
        value: Value,
        title: String,
        detail: String? = nil,
        systemImage: String? = nil
    ) {
        self.value = value
        self.title = title
        self.detail = detail
        self.systemImage = systemImage
    }
}
