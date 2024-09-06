import SwiftUI

struct CustomVStackModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 28)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white.ignoresSafeArea())
            .navigationBarBackButtonHidden()
    }
}

extension View {
    func customVStack() -> some View {
        self.modifier(CustomVStackModifier())
    }
}
