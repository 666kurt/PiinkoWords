import SwiftUI
import ConfettiSwiftUI

struct GameScreen: View {

    @ObservedObject var gameLogic: GameLogic
    @StateObject private var audioManager = AudioManager.shared
    @State private var timeRemaining = 60
    @State private var activePopUp: PopUpType = .none
    @State private var finalTime: Int? = nil
    @State private var gameTimer: Timer? = nil
    @State private var confettiCounter = 0


    init(category: Category) {
        self.gameLogic = GameLogic(category: category)
    }

    var body: some View {
        if gameLogic.currentWordIndex < gameLogic.category.words.count {
            let currentWord = gameLogic.category.words[gameLogic.currentWordIndex]

            VStack(spacing: 15) {

                GameToolBarView(category: gameLogic.category,
                                timeRemaining: $timeRemaining,
                                showWinPopup: .constant(false),
                                showLosePopup: .constant(false),
                                showExitPopup: $activePopUp,
                                stopGameTimer: stopTimer)

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
            }
            .overlay(
                Group {
                    if activePopUp == .lose {
                        GameLosePopUpView(showPopUp: Binding(
                            get: { activePopUp == .lose },
                            set: { if !$0 { activePopUp = .none } }
                        ))
                    }
                    if activePopUp == .win, let finalTime = finalTime {
                        ZStack {
                            GameWinPopUpView(showPopUp: Binding(
                                get: { activePopUp == .win },
                                set: { if !$0 { activePopUp = .none } }
                            ), elapsedTime: finalTime)
                            
                            ConfettiCannon(counter: $confettiCounter, num: 100, radius: 300.0)
                        }
                        .onAppear {
                            confettiCounter += 1
                        }
                    }
                    if activePopUp == .exit {
                        GameExitPopUpView(showPopUp: Binding(
                            get: { activePopUp == .exit },
                            set: { if !$0 { activePopUp = .none } }
                        ), elapsedTime: 60 - timeRemaining, onContinue: resumeGame)
                    }
                }
            )
        }
    }

    private var nextButtonView: some View {
        Button {
            if gameLogic.currentWordIndex == gameLogic.category.words.count - 1 {
                finalTime = 60 - timeRemaining
                activePopUp = .win
                stopTimer()
                confettiCounter += 1
            } else {
                gameLogic.nextWord()
            }
        } label: {
            Text("Next")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(hex: "#A80079"))
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold))
                .clipShape(Capsule())
        }
    }

    private func resetGameAfterLoss() {
        gameLogic.currentWordIndex = 0
        gameLogic.resetSelection()
        timeRemaining = 60
        activePopUp = .none
        gameLogic.shuffledLetters = gameLogic.category.words[gameLogic.currentWordIndex].text.shuffled()
        startTimer()
    }

    private func startTimer() {
        stopTimer()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                activePopUp = .lose
                timer.invalidate()
            }
        }
    }

    private func stopTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }

    private func resumeGame() {
        startTimer()
        audioManager.playSound(named: "bgSound", loop: true)
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

