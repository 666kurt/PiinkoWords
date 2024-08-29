import SwiftUI

struct GameScreen: View {
    
    @ObservedObject var gameLogic: GameLogic
    @StateObject private var audioManager = AudioManager.shared
    @State private var timeRemaining = 60
    @State private var showLosePopup = false
    @State private var showWinPopup = false
    @State private var showCompletionPopup = false
    @State private var showExitPopup = false
    @State private var finalTime: Int? = nil
    
    init(category: Category) {
        self.gameLogic = GameLogic(category: category)
    }
    
    var body: some View {
        
        if gameLogic.currentWordIndex < gameLogic.category.words.count {
            let currentWord = gameLogic.category.words[gameLogic.currentWordIndex]
            
            VStack(spacing: 15) {
                
                GameToolBarView(category: gameLogic.category,
                                timeRemaining: $timeRemaining,
                                showWinPopup: $showWinPopup,
                                showLosePopup: $showLosePopup,
                                showExitPopup: $showExitPopup)
                
                Image(currentWord.image)
                    .backgroundCardModifier()
                
                GameLettersView(selectedLetters: gameLogic.selectedLetters.map { $0.letter },
                                totalLetters: currentWord.text.count)
                
                GameLetterCircleView(gameLogic: gameLogic)
                
                nextButtonView
                    .disabled(!gameLogic.canProceedToNextWord)
                
            }
            .customVStack()
            .onAppear {
                gameLogic.shuffledLetters = currentWord.text.shuffled()
                startTimer()
                
                audioManager.loadSound(named: "bgSound", withExtension: "mp3")
                audioManager.playSound(named: "bgSound", loop: true)
            }
            .overlay(
                Group {
                    if showLosePopup {
                        GameLosePopUpView(showPopUp: $showLosePopup)
//                        audioManager.loadSound(named: "loseSound", withExtension: "wav")
//                        audioManager.playSound(named: "loseSound")
                    }
                    if showCompletionPopup, let finalTime = finalTime {
                        GameWinPopUpView(showPopUp: $showCompletionPopup,
                                         elapsedTime: finalTime)
                    }
                    if showExitPopup {
                        GameExitPopUpView(showPopUp: $showExitPopup,
                                          elapsedTime: 60 - timeRemaining)
                    }
                }
            )
        }
    }
    
    private var nextButtonView: some View {
        Button {
            if gameLogic.currentWordIndex == gameLogic.category.words.count - 1 {
                finalTime = 60 - timeRemaining
                showCompletionPopup = true
                GameToolBarView(category: gameLogic.category, timeRemaining: $timeRemaining, showWinPopup: $showWinPopup, showLosePopup: $showLosePopup, showExitPopup: $showExitPopup).stopTimer(didWin: true)
            } else {
                gameLogic.nextWord()
            }
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
    
    
    // Сброс игры после поражения
    private func resetGameAfterLoss() {
        gameLogic.currentWordIndex = 0
        gameLogic.resetSelection()
        timeRemaining = 60
        showLosePopup = false
        gameLogic.shuffledLetters = gameLogic.category.words[gameLogic.currentWordIndex].text.shuffled()
        
        // Перезапуск таймера
        startTimer()
    }
    
    private func startTimer() {
        stopTimer()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                showLosePopup = true
                timer.invalidate()
            }
        }
    }
    
    private func stopTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.0, repeats: false) { timer in
            timer.invalidate()
        }
    }
    
    private func resumeTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                showLosePopup = true
                timer.invalidate()
            }
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

