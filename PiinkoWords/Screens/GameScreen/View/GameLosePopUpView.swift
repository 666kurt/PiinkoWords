import SwiftUI

struct GameLosePopUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopUp: Bool
    
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
                
                Image("popupBG")
                    .resizable()
                    .frame(width: 334, height: 444)
                
                
                VStack(spacing: 16) {
                    Button {
                        withAnimation {
                            showPopUp = false
                        }
                        onContinue()
                    } label: {
                        Image("continue")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                    
                    Button {
                        onExitToMainMenu()
                    } label: {
                        Image("mainMenu")
                            .resizable()
                            .frame(width: 194, height: 53)
                    }
                    
                }
                .offset(y: 75)
                
            }
            .offset(y: showPopUp ? 0 : UIScreen.main.bounds.height)
            .animation(.spring(), value: showPopUp)
        }
    }
}


#Preview {
    GameLosePopUpView(showPopUp: .constant(true), onContinue: {}, onExitToMainMenu: {})
}
