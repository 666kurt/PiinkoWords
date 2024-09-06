import SwiftUI

struct BackgroundCardModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        VStack {
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(
            LinearGradient(colors: [
            Color(hex: "#FFFFFF"),
            Color(hex: "#FFA0FB"),
            ],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
}

extension View {
    func backgroundCardModifier() -> some View {
        self.modifier(BackgroundCardModifier())
    }
}
