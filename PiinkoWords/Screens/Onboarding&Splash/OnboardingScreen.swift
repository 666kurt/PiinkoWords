import SwiftUI

struct OnboardingScreen: View {
    @Binding var showOnboarding: Bool
    @State private var currentImageIndex = 0
    
    let images = ["onboarding1", "onboarding2", "onboarding3"]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(images[currentImageIndex])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)
                .animation(.easeInOut(duration: 1), value: currentImageIndex)
        }
        .onAppear {
            startImageTransition()
        }
    }
    
    func startImageTransition() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            if currentImageIndex < images.count - 1 {
                currentImageIndex += 1
            } else {
                timer.invalidate()
                showOnboarding = false
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            }
        }
    }
}

#Preview {
    OnboardingScreen(showOnboarding: .constant(false))
}
