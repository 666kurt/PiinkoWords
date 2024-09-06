import Foundation
import Combine

final class Category: ObservableObject {
    let id: UUID
    let name: String
    let image: String
    let words: [Word]
    
    @Published var guessedWordsCount: Int {
        didSet {
            if guessedWordsCount > words.count {
                guessedWordsCount = words.count
            }
        }
    }

    init(id: UUID = UUID(), name: String, image: String, words: [Word], guessedWordsCount: Int = 0) {
        self.id = id
        self.name = name
        self.image = image
        self.words = words
        self.guessedWordsCount = min(guessedWordsCount, words.count)
    }
}
