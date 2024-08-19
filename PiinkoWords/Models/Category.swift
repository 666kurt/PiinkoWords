import Foundation

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let words: [Word]
}
