import SwiftUI

struct SettingButtonView: View {
    
    let title: String
    let url: String
    
    var body: some View {
        Link(destination: URL(string: url)!, label: {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#1800AE"))
                .clipShape(Capsule())
        })
    }
}

#Preview {
    SettingButtonView(title: "Rate us", url: "https://google.com")
        .padding()
}
