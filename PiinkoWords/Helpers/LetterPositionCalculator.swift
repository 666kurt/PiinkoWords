import SwiftUI

struct LetterPositionCalculator {
    
    static func positionForLetters(index: Int, total: Int, radius: CGFloat) -> CGPoint {
        switch total {
        case 3:
            return positionForTriangle(index: index, radius: radius)
        case 4:
            return positionForDiamond(index: index, radius: radius)
        case 5:
            return positionForStar(index: index, radius: radius)
        default:
            return CGPoint(x: 151, y: 151)
        }
    }
    
    static func positionForTriangle(index: Int, radius: CGFloat) -> CGPoint {
        let angle = 2 * .pi / 3 * CGFloat(index) - .pi / 6
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: 169 + x, y: 151 + y)
    }
    
    static func positionForDiamond(index: Int, radius: CGFloat) -> CGPoint {
        let angles: [CGFloat] = [-.pi / 2, 0, .pi / 2, .pi]
        let angle = angles[index]
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: 170 + x, y: 151 + y)
    }
    
    static func positionForStar(index: Int, radius: CGFloat) -> CGPoint {
        let angle = 2 * .pi / 5 * CGFloat(index) - .pi / 2
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: 173 + x, y: 151 + y)
    }
}
