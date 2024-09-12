import SwiftUI
import ConfettiSwiftUI

struct GameScreen: View {

    @ObservedObject var gameLogic: GameLogic
    @StateObject private var audioManager = AudioManager.shared
    @State private var timeRemaining = 60
    @State private var activePopUp: PopUpType = .x1
    @State private var finalTime: Int? = nil
    @State private var gameTimer: Timer? = nil
    @State private var confettiCounter = 0


    init(category: Category) {
        self.gameLogic = GameLogic(category: category)
    }

    var body: some View {
        if gameLogic.cwi < gameLogic.cat.words.count {
            let currentWord = gameLogic.cat.words[gameLogic.cwi]

            VStack(spacing: 15) {

                GameToolBarView(category: gameLogic.cat,
                                timeRemaining: $timeRemaining,
                                showWinPopup: .constant(false),
                                showLosePopup: .constant(false),
                                showExitPopup: $activePopUp,
                                stopGameTimer: stopTimer)

                Image(currentWord.image)
                    .backgroundCardModifier()

                GameLettersView(selectedLetters: gameLogic.sll.map { $0.letter },
                                totalLetters: currentWord.text.count)

                GameLetterCircleView(gameLogic: gameLogic)

                nextButtonView
                    .disabled(!gameLogic.cpnwrds)
            }
            .customVStack()
            .onAppear {
                gameLogic.shltr = currentWord.text.shuffled()
                startTimer()
            }
            .overlay(
                Group {
                    if activePopUp == .x3 {
                        GameLosePopUpView(showPopUp: Binding(
                            get: { activePopUp == .x3 },
                            set: { if !$0 { activePopUp = .x1 } }
                        ))
                    }
                    if activePopUp == .x2, let finalTime = finalTime {
                        ZStack {
                            GameWinPopUpView(showPopUp: Binding(
                                get: { activePopUp == .x2 },
                                set: { if !$0 { activePopUp = .x1 } }
                            ), elapsedTime: finalTime)
                            
                            ConfettiCannon(counter: $confettiCounter, num: 100, radius: 300.0)
                        }
                        .onAppear {
                            confettiCounter += 1
                        }
                    }
                    if activePopUp == .x4 {
                        GameExitPopUpView(showPopUp: Binding(
                            get: { activePopUp == .x4 },
                            set: { if !$0 { activePopUp = .x1 } }
                        ), elapsedTime: 60 - timeRemaining, onContinue: resumeGame)
                    }
                }
            )
        }
    }

    private var nextButtonView: some View {
        Button {
            if gameLogic.cwi == gameLogic.cat.words.count - 1 {
                finalTime = 60 - timeRemaining
                activePopUp = .x2
                stopTimer()
                confettiCounter += 1
            } else {
                gameLogic.nw()
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
        gameLogic.cwi = 0
        gameLogic.rs()
        timeRemaining = 60
        activePopUp = .x1
        gameLogic.shltr = gameLogic.cat.words[gameLogic.cwi].text.shuffled()
        startTimer()
    }

    private func startTimer() {
        stopTimer()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                activePopUp = .x3
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

