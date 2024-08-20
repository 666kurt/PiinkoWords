import SwiftUI

struct GameScreen: View {
    
    @ObservedObject var gameLogic: GameLogic
    @State private var timeRemaining = 180
    @State private var showLosePopup = false
    @State private var showWinPopup = false
    @State private var showCompletionPopup = false
    @State private var showExitPopup = false
    @State private var finalTime: Int? = nil
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(category: Category) {
        self.gameLogic = GameLogic(category: category)
    }
    
    var body: some View {
        
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
        }
        .onDisappear {
            saveGameProgress()  // Сохранение прогресса при уходе с экрана
        }
        .overlay(
            Group {
                if showLosePopup {
                    GameLosePopUpView(showPopUp: $showLosePopup,
                                      onContinue: {
                        resetGameAfterLoss()
                    },
                                      onExitToMainMenu: {
                        saveGameProgress()  // Сохранение прогресса при выходе в главное меню
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                if showCompletionPopup, let finalTime = finalTime {
                    GameWinPopUpView(showPopUp: $showCompletionPopup,
                                     elapsedTime: finalTime,
                                     onContinue: {
                        saveGameProgress()  // Сохранение прогресса при завершении игры
                        presentationMode.wrappedValue.dismiss()
                    },
                                     onExitToMainMenu: {
                        saveGameProgress()  // Сохранение прогресса при выходе в главное меню
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                if showExitPopup {
                    GameExitPopUpView(showPopUp: $showExitPopup,
                                      elapsedTime: 180 - timeRemaining,
                                      onContinue: {
                        showExitPopup = false
                    },
                                      onExitToMainMenu: {
                        saveGameProgress()  // Сохранение прогресса при выходе в главное меню
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        )
    }
    
    private var nextButtonView: some View {
        Button {
            gameLogic.nextWord()
            saveGameProgress()  // Сохранение прогресса после отгадывания слова
            
            if gameLogic.currentWordIndex == gameLogic.category.words.count - 1 {
                finalTime = 180 - timeRemaining
                showCompletionPopup = true
                GameToolBarView(category: gameLogic.category, timeRemaining: $timeRemaining, showWinPopup: $showWinPopup, showLosePopup: $showLosePopup, showExitPopup: $showExitPopup).stopTimer(didWin: true)
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
    
    // Функция сохранения прогресса
    private func saveGameProgress() {
        let newProgress = gameLogic.currentWordIndex
        GameProgressManager.shared.saveProgress(for: gameLogic.category, completedWords: newProgress)
        print("Progress saved: \(newProgress)")  // Отладочный вывод для проверки
    }
    
    // Сброс игры после поражения
    private func resetGameAfterLoss() {
        gameLogic.currentWordIndex = 0
        gameLogic.resetSelection()
        timeRemaining = 180
        showLosePopup = false
        gameLogic.shuffledLetters = gameLogic.category.words[gameLogic.currentWordIndex].text.shuffled()
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

