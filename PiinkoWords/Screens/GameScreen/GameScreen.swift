import SwiftUI

struct GameScreen: View {
    
    @ObservedObject var gameLogic: GameLogic
    
    init(category: Category) {
        self.gameLogic = GameLogic(category: category)
    }

    var body: some View {
        
        let currentWord = gameLogic.category.words[gameLogic.currentWordIndex]
        
        VStack {
            
            GameToolBarView(category: gameLogic.category)
            
            Image(currentWord.image)
                .backgroundCardModifier()
            
            GameLettersView(selectedLetters: gameLogic.selectedLetters,
                            totalLetters: currentWord.text.count)
            
            GameLetterCircleView(gameLogic: gameLogic)
            
            nextButtonView
                .disabled(!gameLogic.canProceedToNextWord)
            
        }
        .customVStack()
        .onAppear {
            gameLogic.shuffledLetters = currentWord.text.shuffled()
        }
    }
    
    private var nextButtonView: some View {
        Button {
            gameLogic.nextWord()
        } label: {
            Text("Next")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(hex: "#1800AE"))
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold))
                .clipShape(Capsule())
        }
    }
}





#Preview {
    GameScreen(category: Category(name: "Animals",
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
}
