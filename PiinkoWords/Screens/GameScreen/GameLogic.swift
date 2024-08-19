import SwiftUI
import UIKit

class GameLogic: ObservableObject {
    
    let category: Category
    @Published var currentWordIndex = 0
    @Published var selectedLetters: [String] = []
    @Published var selectedLetterPositions: [CGPoint] = []
    @Published var shuffledLetters: [Character] = []
    @Published var correctLetters: Set<String> = []
    @Published var canProceedToNextWord = false

    init(category: Category) {
        self.category = category
        self.shuffledLetters = category.words[currentWordIndex].text.shuffled()
    }
    
    func handleLetterSelection(letter: String, letterPosition: CGPoint) {
        let currentWord = category.words[currentWordIndex].text
        
        if currentWord.contains(letter) && !selectedLetters.contains(letter) {
            selectedLetters.append(letter)
            selectedLetterPositions.append(letterPosition)
            correctLetters.insert(letter)
        }
        
        if selectedLetters.joined() == currentWord {
            canProceedToNextWord = true
        } else if selectedLetters.count == currentWord.count && selectedLetters.joined() != currentWord {
            triggerVibration()
            resetSelection()
        }
    }
    
    private func triggerVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func resetSelection() {
        selectedLetters.removeAll()
        selectedLetterPositions.removeAll()
        correctLetters.removeAll()
        canProceedToNextWord = false
    }
    
    func nextWord() {
        if currentWordIndex < category.words.count - 1 {
            currentWordIndex += 1
            resetSelection()
            shuffledLetters = category.words[currentWordIndex].text.shuffled()
        } else {
            // Завершение игры или переход на другой экран
        }
    }
    
    func boundaryPoint(from: CGPoint, to: CGPoint, radius: CGFloat = 40) -> CGPoint {
        let vector = CGPoint(x: to.x - from.x, y: to.y - from.y)
        let length = sqrt(vector.x * vector.x + vector.y * vector.y)
        let unitVector = CGPoint(x: vector.x / length, y: vector.y / length)
        return CGPoint(x: from.x + unitVector.x * radius, y: from.y + unitVector.y * radius)
    }
}
