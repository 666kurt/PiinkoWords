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
            Color(hex: "#0D00A1"),
            Color(hex: "#320083"),
            ],
                           startPoint: .leading,
                           endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.bottom, 20)
        
    }
    
}

extension View {
    func backgroundCardModifier() -> some View {
        self.modifier(BackgroundCardModifier())
    }
}
