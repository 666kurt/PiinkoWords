import SwiftUI

struct GameWinPopUpView: View {
    
    @StateObject private var audioManager = AudioManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    
    var elapsedTime: Int
    
    var body: some View {
        ZStack {
            
            Color(.black).opacity(0.5).ignoresSafeArea()

            ZStack {
                
                Image("winPopupBG")
                    .resizable()
                    .frame(width: 334, height: 338)
                
                VStack(spacing: 40) {
                    
                    Text(formatElapsedTime(elapsedTime))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Button {
                        withAnimation {
                            hidePopup()
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("winMainMenu")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                    
                }
                
            }
            .offset(y: offsetY)
            .onAppear {
                audioManager.stopSound(named: "welcomeSound")
                audioManager.loadSound(named: "winSound", withExtension: "mp3")
                audioManager.playSound(named: "winSound")
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    offsetY = 0
                }
            }
            .onDisappear {
                audioManager.stopSound(named: "winSound")
                audioManager.playSound(named: "welcomeSound", loop: true)
            }
        }
//        .overlay(Image("winGirl")
//            .resizable()
//            .scaledToFit()
//            .offset(x: -200, y: 450)
//            .scaleEffect(CGSize(width: 0.5, height: 0.5))
//            .offset(y: offsetY)
//                 , alignment: .bottom)
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
    GameWinPopUpView(showPopUp: .constant(true), elapsedTime: 45)
}
