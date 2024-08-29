import SwiftUI

struct GameLosePopUpView: View {
    
    @StateObject private var audioManager = AudioManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    
    var body: some View {
        ZStack {
            
            Color(.black).opacity(0.5).ignoresSafeArea()
            
            ZStack {
                
                Image("popupBG")
                    .resizable()
                    .frame(width: 334, height: 444)
                
                
                Button {
                    showPopUp = false
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("mainMenu")
                        .resizable()
                        .frame(width: 194, height: 53)
                }       
                .offset(y: 75)
            }
        }
        .onAppear() {
            audioManager.loadSound(named: "loseSound", withExtension: "wav")
            audioManager.playSound(named: "loseSound")
        }
        .onDisappear() {
            audioManager.stopSound(named: "loseSound")
        }
    }
}


#Preview {
    GameLosePopUpView(showPopUp: .constant(true))
}
