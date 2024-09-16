import SwiftUI

struct GameExitPopUpView: View {

    @StateObject private var audioManager = AudioManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    
    var elapsedTime: Int
    var onContinue: () -> Void

    var body: some View {
        ZStack {
            Color(.black).opacity(0.5).ignoresSafeArea()
            ZStack {
                Image("exitPopupBG")
                    .resizable()
                    .frame(width: 334, height: 338)
                VStack(spacing: 12) {
                    Text(formatElapsedTime(elapsedTime))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Button {
                        withAnimation {
                            hidePopup()
                        }
                        onContinue()
                    } label: {
                        Image("continueExit")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("exitExit")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                }
            }
            .offset(y: offsetY)
            .onAppear {
                audioManager.stopSound(named: "welcomeSound")
                audioManager.loadSound(named: "exitSound", withExtension: "mp3")
                audioManager.playSound(named: "exitSound")
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    offsetY = 0
                }
            }
            .onDisappear {
                audioManager.stopSound(named: "exitSound")
                audioManager.playSound(named: "welcomeSound", loop: true)
            }
        }
//        .overlay(
//            Image("exitGirl")
//                .resizable()
//                .scaledToFit()
//                .offset(y: 155)
//                .scaleEffect(CGSize(width: 0.7, height: 0.7))
//                .offset(y: offsetY),
//            alignment: .bottom
//        )
    }
    
    private func hidePopup() {
        offsetY = UIScreen.main.bounds.height
        showPopUp = false
    }
    
    private func formatElapsedTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    GameExitPopUpView(showPopUp: .constant(true), elapsedTime: 180, onContinue: {})
}
