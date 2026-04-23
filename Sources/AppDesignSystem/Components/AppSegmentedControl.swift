import SwiftUI

public struct AppSegment<Value: Hashable & Sendable>: Identifiable, Equatable, Sendable {
    public let value: Value
    public let title: String
    public let systemImage: String?

    public var id: Value { value }

    public init(
        value: Value,
        title: String,
        systemImage: String? = nil
    ) {
        self.value = value
        self.title = title
        self.systemImage = systemImage
    }
}

public struct AppSegmentedControl<Value: Hashable & Sendable>: View {
    @Binding private var selection: Value
    @Environment(\.appTheme) private var theme
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let segments: [AppSegment<Value>]

    public init(
        selection: Binding<Value>,
        segments: [AppSegment<Value>]
    ) {
        _selection = selection
        self.segments = segments
    }

    public var body: some View {
        layout {
            ForEach(segments) { segment in
                Button {
                    selection = segment.value
                } label: {
                    HStack(spacing: theme.spacing.xSmall) {
                        if let systemImage = segment.systemImage {
                            Image(systemName: systemImage)
                                .font(.system(size: 14, weight: .semibold))
                                .symbolRenderingMode(.hierarchical)
                                .accessibilityHidden(true)
                        }

                        Text(segment.title)
                            .appTextStyle(
                                .caption,
                                color: selection == segment.value ? .accentForeground : .contentSecondary
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 44)
                    .padding(.horizontal, theme.spacing.small)
                    .background(
                        Capsule(style: .continuous)
                            .fill(
                                selection == segment.value
                                    ? AppThemeColor(.accent)
                                    : AppThemeColor(.surface)
                            )
                    )
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(
                                selection == segment.value
                                    ? AppThemeColor(.accentEmphasis)
                                    : AppThemeColor(.border),
                                lineWidth: 1
                            )
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(segment.title)
                .accessibilityAddTraits(selection == segment.value ? [.isButton, .isSelected] : .isButton)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous)
                .fill(AppThemeColor(.surfaceMuted))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.pill, style: .continuous)
                .stroke(AppThemeColor(.border), lineWidth: 1)
        )
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder
    private func layout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(spacing: theme.spacing.xSmall) {
                content()
            }
        } else {
            HStack(spacing: theme.spacing.xSmall) {
                content()
            }
        }
    }
}
