import SwiftUI

extension View {
    @ViewBuilder
    func appPlatformTextInputBehavior() -> some View {
        #if os(iOS)
        textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        #else
        self
        #endif
    }
}
