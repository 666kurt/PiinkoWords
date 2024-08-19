import Foundation

class GameData {
    
    static let shared = GameData()
    private init() {}
    
    let categories: [Category] = [
        Category(name: "Animals",
                 image: "lion",
                 words: [
                    Word(text: "horse", image: "pony"),
                    Word(text: "dog", image: "dog"),
                    Word(text: "lion", image: "lion"),
                    Word(text: "fish", image: "fish"),
                    Word(text: "bear", image: "bear"),
                    Word(text: "koala", image: "koala"),
                    Word(text: "bunny", image: "bunny"),
                ]),
        Category(name: "Fruits",
                 image: "lime",
                 words: [
                    Word(text: "plum", image: "plum"),
                    Word(text: "lime", image: "lime"),
                    Word(text: "kiwi", image: "kiwi"),
                    Word(text: "apple", image: "apple"),
                    Word(text: "lemon", image: "lemon"),
                    Word(text: "mango", image: "mango"),
                ]),
        Category(name: "Nature",
                 image: "river",
                 words: [
                    Word(text: "sea", image: "sea"),
                    Word(text: "sky", image: "sky"),
                    Word(text: "tree", image: "tree"),
                    Word(text: "leaf", image: "leaf"),
                    Word(text: "river", image: "river"),
                    Word(text: "ocean", image: "ocean"),
                ]),
        Category(name: "Weather",
                 image: "rain",
                 words: [
                    Word(text: "sun", image: "sun"),
                    Word(text: "snow", image: "snow"),
                    Word(text: "moon", image: "moon"),
                    Word(text: "cold", image: "cold"),
                    Word(text: "rain", image: "rain"),
                    Word(text: "storm", image: "storm"),
                ])
    ]
    
}
