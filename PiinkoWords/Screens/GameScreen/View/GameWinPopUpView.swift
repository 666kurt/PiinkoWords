import SwiftUI

struct GameWinPopUpView: View {
    
    @StateObject private var audioManager = AudioManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    
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
                        showPopUp = false
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("winMainMenu")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                    
                }
                
            }
        }
        .onAppear() {
            audioManager.loadSound(named: "winSound", withExtension: "mp3")
            audioManager.playSound(named: "winSound")
        }
        .onDisappear() {
            audioManager.stopSound(named: "winSound")
        }
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
