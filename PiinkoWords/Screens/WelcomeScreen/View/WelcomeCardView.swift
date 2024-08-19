import SwiftUI

struct WelcomeCardView: View {
    
    let title: String
    let image: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Image(image)
                .resizable()
                .frame(width: 114, height: 114)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hex: "#2F19C8"))
                .frame(height: 12)
        }
        .padding(.horizontal, 46)
        .backgroundCardModifier()
    }
}

#Preview {
    WelcomeCardView(title: "Animals",
                    image: "lion")
    .padding()
}
