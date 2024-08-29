import SwiftUI

@main
struct PiinkoWordsApp: App {
    
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false
    
    var body: some Scene {
        WindowGroup {
            SplashScreen(showOnboarding: $showOnboarding)
        }
    }
}
