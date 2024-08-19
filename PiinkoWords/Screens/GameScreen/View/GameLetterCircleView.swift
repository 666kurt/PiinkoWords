import SwiftUI

struct GameLetterCircleView: View {
    
    @ObservedObject var gameLogic: GameLogic
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "#5B41FF"))
                .frame(width: 302, height: 302)
            
            ForEach(gameLogic.shuffledLetters.indices, id: \.self) { index in
                let letter = String(gameLogic.shuffledLetters[index])
                let letterPosition = LetterPositionCalculator.positionForLetters(index: index, total: gameLogic.shuffledLetters.count, radius: 95)
                
                Text(letter)
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color(hex: "#5B41FF"))
                    .frame(width: 80, height: 80)
                    .background(
                        Circle()
                            .fill(Color.pinkGradient)
                            .shadow(color: gameLogic.correctLetters.contains(letter) ? .red : .clear, radius: 10)
                    )
                    .position(letterPosition)
                    .onTapGesture {
                        gameLogic.handleLetterSelection(letter: letter, letterPosition: letterPosition)
                    }
            }
            
            if gameLogic.selectedLetterPositions.count > 1 {
                Path { path in
                    for i in 0..<gameLogic.selectedLetterPositions.count - 1 {
                        let start = gameLogic.boundaryPoint(from: gameLogic.selectedLetterPositions[i], to: gameLogic.selectedLetterPositions[i + 1])
                        let end = gameLogic.boundaryPoint(from: gameLogic.selectedLetterPositions[i + 1], to: gameLogic.selectedLetterPositions[i])
                        path.move(to: start)
                        path.addLine(to: end)
                    }
                }
                .stroke(Color(hex: "#E81895"), lineWidth: 8)
            }
        }
    }
}
