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
                                      url: "https://www.termsfeed.com/live/01754f43-ab45-4265-9f3b-36848ab21321")
                    SettingButtonView(title: "Terms of use",
                                      url: "https://www.termsfeed.com/live/01300ceb-51c7-4af0-b19b-f8d01ae54346")
                }
            }
            
        }
        .customVStack()
        
    }
}

#Preview {
    SettingsScreen()
}
