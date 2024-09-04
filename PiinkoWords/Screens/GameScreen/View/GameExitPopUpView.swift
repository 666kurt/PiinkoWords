import SwiftUI

struct GameExitPopUpView: View {
    
    @StateObject private var audioManager = AudioManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    
    var elapsedTime: Int
    
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
                        showPopUp = false
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
        }
        .onAppear() {
            audioManager.loadSound(named: "exitSound", withExtension: "mp3")
            audioManager.playSound(named: "exitSound")
        }
        .onDisappear() {
            audioManager.stopSound(named: "exitSound")
        }
    }
    
    private func formatElapsedTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    GameExitPopUpView(showPopUp: .constant(true), elapsedTime: 180)
}
