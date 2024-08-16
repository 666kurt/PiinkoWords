import SwiftUI

struct WelcomeCardView: View {
    
    let title: String
    let image: String
    let onTap: () -> Void
    
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
        .padding(.top, 10)
        .padding(.bottom, 20)
        .padding(.horizontal, 46)
        .background(
            LinearGradient(colors: [
            Color(hex: "#0D00A1"),
            Color(hex: "#320083"),
            ],
                           startPoint: .leading,
                           endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            onTap()
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    WelcomeCardView(title: "Animals",
                    image: "lion",
                    onTap: {})
    .padding()
}
