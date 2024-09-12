import SwiftUI

struct GameLetterCircleView: View {
    
    @ObservedObject var gameLogic: GameLogic
    
    var body: some View {
        GeometryReader { geometry in
            
            let circleSize = min(geometry.size.width, geometry.size.height)
            let circleCenter = CGPoint(x: circleSize / 2, y: circleSize / 2)
            let radius: CGFloat = (circleSize - 80) / 2.4
            let circleRadius: CGFloat = circleSize * 0.25
            
            ZStack {
                Circle()
                    .fill(Color(hex: "#FA2BFF"))
                    .frame(width: circleSize, height: circleSize)
                
                ForEach(gameLogic.shltr.indices, id: \.self) { index in
                    let letter = String(gameLogic.shltr[index])
                    let letterPosition = LetterPositionCalculator.positionForLetters(index: index, total: gameLogic.shltr.count, center: circleCenter, radius: radius)
                    
                    Image("circlePink")
                        .resizable()
                        .frame(width: circleRadius, height: circleRadius)
                        .overlay(
                            Text(letter)
                                .font(.system(size: circleRadius * 0.6, weight: .semibold))
                                .foregroundColor(Color(hex: "#5B41FF"))
                        )
                        .shadow(color: gameLogic.corltrs.contains(index) ? .red : .clear, radius: radius * 0.1)
                        .position(letterPosition)
                        .onTapGesture {
                            gameLogic.hls(letter: letter, letterPosition: letterPosition, letterIndex: index)
                        }
                }
                
                if gameLogic.lpos.count > 1 {
                    Path { path in
                        for i in 0..<gameLogic.lpos.count - 1 {
                            let start = gameLogic.lpos[i]
                            let end = gameLogic.lpos[i + 1]
                            let startBoundary = LetterPositionCalculator.boundaryPoint(from: start, to: end, radius: circleRadius / 2)
                            let endBoundary = LetterPositionCalculator.boundaryPoint(from: end, to: start, radius: circleRadius / 2)
                            path.move(to: startBoundary)
                            path.addLine(to: endBoundary)
                        }
                    }
                    .stroke(Color(hex: "#E81895"), lineWidth: 8)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
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
