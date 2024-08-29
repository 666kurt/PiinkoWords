import SwiftUI

final class GameLogic: ObservableObject {
    
    @ObservedObject var category: Category
    @Published var currentWordIndex = 0
    @Published var selectedLetters: [(letter: String, index: Int)] = []
    @Published var selectedLetterPositions: [CGPoint] = []
    @Published var shuffledLetters: [Character] = []
    @Published var correctLetters: Set<Int> = []
    @Published var canProceedToNextWord = false
        
    init(category: Category) {
        self.category = category
        self.shuffledLetters = category.words[currentWordIndex].text.shuffled()
    }

    func handleLetterSelection(letter: String, letterPosition: CGPoint, letterIndex: Int) {
            let currentWord = category.words[currentWordIndex].text
            
            let alreadySelectedCount = selectedLetters.filter { $0.letter == letter }.count
            let totalOccurrencesInWord = currentWord.filter { String($0) == letter }.count
            
            if currentWord.contains(letter) && alreadySelectedCount < totalOccurrencesInWord && !selectedLetters.contains(where: { $0.index == letterIndex }) {
                selectedLetters.append((letter: letter, index: letterIndex))
                selectedLetterPositions.append(letterPosition)
                correctLetters.insert(letterIndex)
            }
            
            if selectedLetters.map({ $0.letter }).joined() == currentWord {
                canProceedToNextWord = true
            } else if selectedLetters.count == currentWord.count && selectedLetters.map({ $0.letter }).joined() != currentWord {
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
        if selectedLetters.map({ $0.letter }).joined() == category.words[currentWordIndex].text {
            category.guessedWordsCount += 1
        }

        if currentWordIndex < category.words.count - 1 {
            currentWordIndex += 1
            resetSelection()
            shuffledLetters = category.words[currentWordIndex].text.shuffled()
        } else {
            currentWordIndex = category.words.count
        }
    }

    
    func resetGame() {
        currentWordIndex = 0
        resetSelection()
        shuffledLetters = category.words[currentWordIndex].text.shuffled()
    }

    func boundaryPoint(from: CGPoint, to: CGPoint, radius: CGFloat = 40) -> CGPoint {
        let vector = CGPoint(x: to.x - from.x, y: to.y - from.y)
        let length = sqrt(vector.x * vector.x + vector.y * vector.y)
        let unitVector = CGPoint(x: vector.x / length, y: vector.y / length)
        return CGPoint(x: from.x + unitVector.x * radius, y: from.y + unitVector.y * radius)
    }
}

