import SwiftUI

// MARK: main
struct WelcomeScreen: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 22) {
                
                headerView
                
                categoriesScrollView
                
            }
            .customVStack()
        }
    }
}

// MARK: views
extension WelcomeScreen {
    
    private var categoriesScrollView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(1...4, id: \.self) { _ in
                WelcomeCardView(title: "Animals", image: "lion", onTap: {})
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            HStack() {
                
                Text("Random")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Text("+5 min")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Image("adds")
                        .resizable()
                        .frame(width: 22, height: 24)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
                .background(Color(hex: "#FF0000"))
                .clipShape(Capsule())
                
            }
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            .padding(.leading, 12)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "##1800AE"))
            .clipShape(Capsule())
            
            NavigationLink(destination: SettingsScreen()) {
                Image("settings")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
    
}

#Preview {
    WelcomeScreen()
}
