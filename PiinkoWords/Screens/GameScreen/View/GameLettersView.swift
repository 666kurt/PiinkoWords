import SwiftUI

struct GameLettersView: View {
    
    let selectedLetters: [String]
    let totalLetters: Int
    
    var body: some View {
        HStack {
            ForEach(0..<totalLetters, id: \.self) { index in
                Image(index < selectedLetters.count
                      ? "circlePink"
                      : "circleBlue")
                .resizable()
                .frame(width: 60, height: 60)
                .overlay(
                    Text(selectedLetters.indices.contains(index) ? selectedLetters[index] : "")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Color(hex: "#5B41FF"))
                )
            }
        }
        .padding(7)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#5B41FF"))
        .clipShape(Capsule())
    }
}

#Preview {
    GameLettersView(selectedLetters: ["a", "b"], totalLetters: 5)
}
