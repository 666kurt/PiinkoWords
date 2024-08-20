import Foundation

class GameProgressManager {
    
    static let shared = GameProgressManager()
    private let progressKey = "categoryProgress"
    
    private init() {}
    
    func saveProgress(for category: Category, completedWords: Int) {
        var progress = loadProgress()
        progress[category.id.uuidString] = completedWords
        UserDefaults.standard.set(progress, forKey: progressKey)
    }
    
    func loadProgress() -> [String: Int] {
        let progress = UserDefaults.standard.dictionary(forKey: progressKey) as? [String: Int] ?? [:]
        return progress
    }
    
    func progress(for category: Category) -> Int {
        return loadProgress()[category.id.uuidString] ?? 0
    }
    
    func resetProgress(for category: Category) {
        saveProgress(for: category, completedWords: 0)
    }
}
