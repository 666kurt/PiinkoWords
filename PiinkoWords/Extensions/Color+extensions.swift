import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    static var pinkGradient: RadialGradient {
        return RadialGradient(colors: [Color(hex: "#FFFFFF"), Color(hex: "#FF0099")],
                              center: .center,
                              startRadius: 5,
                              endRadius: 25)
    }
    
    static var blueGradient: RadialGradient {
        return RadialGradient(colors: [Color(hex: "#A1A9F8"), Color(hex: "#4655E0")],
                              center: .center,
                              startRadius: 5,
                              endRadius: 25)
    }
}
