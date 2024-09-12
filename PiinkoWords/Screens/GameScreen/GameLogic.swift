import SwiftUI

enum PopUpType {
    case x1
    case x2
    case x3
    case x4
}

final class GameLogic: ObservableObject {
    
    @ObservedObject var cat: Category
    @Published var cwi = 0
    @Published var sll: [(letter: String, index: Int)] = []
    @Published var lpos: [CGPoint] = []
    @Published var shltr: [Character] = []
    @Published var corltrs: Set<Int> = []
    @Published var cpnwrds = false
        
    init(category: Category) {
        self.cat = category
        self.shltr = category.words[cwi].text.shuffled()
    }

    func hls(letter: String, letterPosition: CGPoint, letterIndex: Int) {
            let currwowo = cat.words[cwi].text
            
            let alreadySelectedCount = sll.filter { $0.letter == letter }.count
            let totalOccurrencesInWord = currwowo.filter { String($0) == letter }.count
            
            if currwowo.contains(letter) && alreadySelectedCount < totalOccurrencesInWord && !sll.contains(where: { $0.index == letterIndex }) {
                sll.append((letter: letter, index: letterIndex))
                lpos.append(letterPosition)
                corltrs.insert(letterIndex)
            }
            
            if sll.map({ $0.letter }).joined() == currwowo {
                cpnwrds = true
            } else if sll.count == currwowo.count && sll.map({ $0.letter }).joined() != currwowo {
                tv()
                rs()
            }
        }
    
    private func tv() {
        let gnrt = UINotificationFeedbackGenerator()
        gnrt.notificationOccurred(.error)
    }
    
    func rs() {
        sll.removeAll()
        lpos.removeAll()
        corltrs.removeAll()
        cpnwrds = false
    }
    
    func nw() {
        if sll.map({ $0.letter }).joined() == cat.words[cwi].text {
            cat.guessedWordsCount = min(cat.guessedWordsCount + 1, cat.words.count)
        }

        if cwi < cat.words.count - 1 {
            cwi += 1
            rs()
            shltr = cat.words[cwi].text.shuffled()
        } else {
            cwi = cat.words.count
        }
    }
    
    func rg() {
        cwi = 0
        rs()
        shltr = cat.words[cwi].text.shuffled()
    }

    func bp(from: CGPoint, to: CGPoint, radius: CGFloat = 40) -> CGPoint {
        let vector = CGPoint(x: to.x - from.x, y: to.y - from.y)
        let length = sqrt(vector.x * vector.x + vector.y * vector.y)
        let unitVector = CGPoint(x: vector.x / length, y: vector.y / length)
        return CGPoint(x: from.x + unitVector.x * radius, y: from.y + unitVector.y * radius)
    }
}

