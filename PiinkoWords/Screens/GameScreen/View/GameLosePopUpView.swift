import SwiftUI

struct GameLosePopUpView: View {
    
    @StateObject private var audioManager = AudioManager.shared
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showPopUp: Bool
    
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            
            Color(.black).opacity(0.5).ignoresSafeArea()
            
            ZStack {
                
                Image("popupBG")
                    .resizable()
                    .frame(width: 334, height: 444)
                
                Button {
                    withAnimation {
                        hidePopup()
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("mainMenu")
                        .resizable()
                        .frame(width: 194, height: 53)
                }
                .offset(y: 75)
            }
            .offset(y: offsetY)
            .onAppear {
                audioManager.stopSound(named: "welcomeSound")
                audioManager.loadSound(named: "loseSound", withExtension: "wav")
                audioManager.playSound(named: "loseSound")
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    offsetY = 0
                }
            }
            .onDisappear {
                audioManager.stopSound(named: "loseSound")
                audioManager.playSound(named: "welcomeSound", loop: true)
            }
        }
//        .overlay(Image("loseGirl")
//            .resizable()
//            .scaledToFit()
//            .offset(x: -200, y: 370)
//            .scaleEffect(CGSize(width: 0.5, height: 0.5))
//            .offset(y: offsetY)
//                 , alignment: .bottom)
    }
    
    private func hidePopup() {
        offsetY = UIScreen.main.bounds.height
        showPopUp = false
    }
}


#Preview {
    GameLosePopUpView(showPopUp: .constant(true))
}
