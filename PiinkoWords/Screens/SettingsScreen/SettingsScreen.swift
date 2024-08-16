import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        
        VStack(spacing: 33) {
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back")
                        .resizable()
                        .frame(width: 37, height: 37)
                }
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                Image("gear")
                
                VStack(spacing: 16) {
                    SettingButtonView(title: "Usage policy",
                                      url: "https://google.com")
                    SettingButtonView(title: "Share app",
                                      url: "https://google.com")
                    SettingButtonView(title: "Rate us",
                                      url: "https://google.com")
                }
            }
            
        }
        .customVStack()
        
    }
}

#Preview {
    SettingsScreen()
}
