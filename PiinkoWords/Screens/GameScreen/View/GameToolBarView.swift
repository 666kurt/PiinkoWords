import SwiftUI

struct GameToolBarView: View {

    @Environment(\.presentationMode) private var presentationMode
    let category: Category

    @Binding var timeRemaining: Int
    @Binding var showWinPopup: Bool
    @Binding var showLosePopup: Bool
    @Binding var showExitPopup: PopUpType
    var stopGameTimer: () -> Void

    var body: some View {
        HStack {
            Button {
                stopGameTimer()
                showExitPopup = .x4
            } label: {
                Image("back")
                    .resizable()
                    .frame(width: 37, height: 37)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Text(category.name)
                .foregroundColor(Color(hex: "#940085"))
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity)

            Text(timeString())
                .foregroundColor(Color(hex: "#940085"))
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.bottom, 16)
    }

    private func timeString() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//#Preview {
//    GameToolBarView(category: Category(name: "Animals",
//                                       image: "lion",
//                                       words: [
//                                        Word(text: "horse", image: "pony"),
//                                        Word(text: "dog", image: "dog"),
//                                        Word(text: "lion", image: "lion"),
//                                        Word(text: "fish", image: "fish"),
//                                        Word(text: "bear", image: "bear"),
//                                        Word(text: "koala", image: "koala"),
//                                        Word(text: "bunny", image: "bunny"),
//                                       ]),
//                    timeRemaining: .constant(180), showWinPopup: .constant(false), showLosePopup: .constant(false), showExitPopup: .constant(false), stopGameTimer: {})
//    .customVStack()
//}
