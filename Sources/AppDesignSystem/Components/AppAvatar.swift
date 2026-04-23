import SwiftUI

public enum AppAvatarSize: Sendable {
    case small
    case medium
    case large

    var dimension: CGFloat {
        switch self {
        case .small:
            32
        case .medium:
            44
        case .large:
            64
        }
    }
}

public struct AppAvatar: View {
    @Environment(\.appTheme) private var theme

    private let initials: String?
    private let systemImage: String?
    private let size: AppAvatarSize

    public init(
        initials: String? = nil,
        systemImage: String? = nil,
        size: AppAvatarSize = .medium
    ) {
        self.initials = initials
        self.systemImage = systemImage
        self.size = size
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(AppThemeColor(.surfaceMuted))

            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: size.dimension * 0.38, weight: .semibold))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(AppThemeColor(.contentPrimary))
                    .accessibilityHidden(true)
            } else if let initials {
                Text(initials)
                    .appTextStyle(.caption)
                    .fontWeight(.semibold)
            }
        }
        .frame(width: size.dimension, height: size.dimension)
        .overlay(
            Circle()
                .stroke(AppThemeColor(.border), lineWidth: 1)
        )
        .accessibilityLabel(initials.map { "Avatar \($0)" } ?? "Avatar")
    }
}
