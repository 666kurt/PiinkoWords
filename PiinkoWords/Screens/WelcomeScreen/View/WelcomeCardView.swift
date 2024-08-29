import SwiftUI

struct WelcomeCardView: View {
    
    @ObservedObject var category: Category
    
    var body: some View {
        VStack(spacing: 12) {
            Text(category.name)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Image(category.image)
                .resizable()
                .frame(width: 114, height: 114)
    
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hex: "#2F19C8"))
                    .frame(height: 12)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hex: "#E81895"))
                    .frame(maxWidth: .infinity)
                    .frame(width: progressBarWidth, height: 12)
                    .animation(.linear(duration: 0.5))
            }
        }
        .padding(.horizontal, 46)
        .backgroundCardModifier()
        .padding(.bottom, 20)
    }
    
    private var progressBarWidth: CGFloat {
        guard category.words.count > 0 else { return 0 }
        return UIScreen.main.bounds.width * 0.8 * (CGFloat(category.guessedWordsCount) / CGFloat(category.words.count))
    }
}

#Preview {
    WelcomeCardView(category: Category(name: "Animals",
                                       image: "lion",
                                       words: [
                                         Word(text: "horse", image: "pony"),
                                         Word(text: "dog", image: "dog"),
                                         Word(text: "lion", image: "lion"),
                                         Word(text: "fish", image: "fish"),
                                         Word(text: "bear", image: "bear"),
                                         Word(text: "koala", image: "koala"),
                                         Word(text: "bunny", image: "bunny"),
                                       ]))
    .padding()
}
