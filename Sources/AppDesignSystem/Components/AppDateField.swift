import SwiftUI

public struct AppDateField: View {
    @Binding private var selection: Date
    @Environment(\.appTheme) private var theme

    private let title: String
    private let helperText: String?
    private let displayedComponents: DatePickerComponents

    public init(
        _ title: String,
        selection: Binding<Date>,
        displayedComponents: DatePickerComponents = .date,
        helperText: String? = nil
    ) {
        self.title = title
        _selection = selection
        self.displayedComponents = displayedComponents
        self.helperText = helperText
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            Text(title)
                .appTextStyle(.caption, color: .contentSecondary)

            DatePicker(
                "",
                selection: $selection,
                displayedComponents: displayedComponents
            )
            .labelsHidden()
            .datePickerStyle(.compact)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, theme.spacing.medium)
            .frame(minHeight: 52)
            .background(
                RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                    .fill(AppThemeColor(.surface))
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radii.medium, style: .continuous)
                    .stroke(AppThemeColor(.border), lineWidth: 1)
            )

            if let helperText {
                Text(helperText)
                    .appTextStyle(.caption, color: .contentSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title)
    }
}
