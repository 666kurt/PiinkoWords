import SwiftUI

struct GameWinPopUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    
    var elapsedTime: Int
    var onContinue: () -> Void
    var onExitToMainMenu: () -> Void
    
    var body: some View {
        ZStack {
            
            Color(.black).opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showPopUp = false
                    }
                }
            
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
                            showPopUp = false
                        }
                        onContinue()
                    } label: {
                        Image("winMainMenu")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                    
                }
                
            }
            .offset(y: showPopUp ? 0 : UIScreen.main.bounds.height)
            .animation(.spring(), value: showPopUp)
        }
    }
    
    private func formatElapsedTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    GameWinPopUpView(showPopUp: .constant(true), elapsedTime: 160, onContinue: {}, onExitToMainMenu: {})
}
