import SwiftUI

struct LetterPositionCalculator {
    
    static func positionForLetters(index: Int, total: Int, center: CGPoint, radius: CGFloat) -> CGPoint {
        switch total {
        case 3:
            return positionForTriangle(index: index, center: center, radius: radius)
        case 4:
            return positionForDiamond(index: index, center: center, radius: radius)
        case 5:
            return positionForStar(index: index, center: center, radius: radius)
        default:
            return center
        }
    }
    
    static func positionForTriangle(index: Int, center: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = 2 * .pi / 3 * CGFloat(index) - .pi / 2
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: center.x + x, y: center.y + y)
    }
    
    static func positionForDiamond(index: Int, center: CGPoint, radius: CGFloat) -> CGPoint {
        let angles: [CGFloat] = [-.pi / 2, 0, .pi / 2, .pi]
        let angle = angles[index]
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: center.x + x, y: center.y + y)
    }
    
    static func positionForStar(index: Int, center: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = 2 * .pi / 5 * CGFloat(index) - .pi / 2
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: center.x + x, y: center.y + y)
    }
    
    // функция для вычисления граничных точек между двумя кругами
    static func boundaryPoint(from: CGPoint, to: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = atan2(to.y - from.y, to.x - from.x)
        let x = from.x + radius * cos(angle)
        let y = from.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
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
