import Foundation
import Combine

class Category: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let image: String
    let words: [Word]
    @Published var guessedWordsCount: Int = 0
    
    init(name: String, image: String, words: [Word]) {
        self.name = name
        self.image = image
        self.words = words
    }
}
