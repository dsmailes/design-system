import SwiftUI

public struct AppStepperRow: View {
    @Binding private var value: Int
    @Environment(\.appTheme) private var theme

    private let title: String
    private let detail: String?
    private let range: ClosedRange<Int>
    private let step: Int
    private let valueFormatter: (Int) -> String
    private let tintRole: AppColorRole

    public init(
        title: String,
        detail: String? = nil,
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1,
        tintRole: AppColorRole = .accent,
        valueFormatter: @escaping (Int) -> String = { "\($0)" }
    ) {
        self.title = title
        self.detail = detail
        _value = value
        self.range = range
        self.step = step
        self.valueFormatter = valueFormatter
        self.tintRole = tintRole
    }

    public var body: some View {
        HStack(spacing: theme.spacing.medium) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .appTextStyle(.bodyEmphasis)

                if let detail {
                    Text(detail)
                        .appTextStyle(.caption, color: .contentSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer(minLength: theme.spacing.small)

            HStack(spacing: theme.spacing.small) {
                controlButton(systemImage: "minus") {
                    value = max(range.lowerBound, value - step)
                }
                .disabled(value <= range.lowerBound)

                Text(valueFormatter(value))
                    .appTextStyle(.section)
                    .frame(minWidth: 40)

                controlButton(systemImage: "plus") {
                    value = min(range.upperBound, value + step)
                }
                .disabled(value >= range.upperBound)
            }
        }
        .padding(.horizontal, theme.spacing.medium)
        .padding(.vertical, theme.spacing.small)
        .frame(minHeight: 60)
        .background(
            RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                .fill(AppThemeColor(.surface))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                .stroke(AppThemeColor(.border), lineWidth: 1)
        )
        .accessibilityElement(children: .contain)
        .accessibilityValue(valueFormatter(value))
    }

    private func controlButton(systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 14, weight: .semibold))
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill(AppThemeColor(.surfaceMuted))
                )
                .foregroundStyle(AppThemeColor(tintRole))
        }
        .buttonStyle(.plain)
    }
}
