import SwiftUI

struct OnboardingScreen: View {
    @Binding var showOnboarding: Bool
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    let totalScreens = 3
    let images = ["onboarding1", "onboarding2", "onboarding3"]
    
    var body: some View {
        GeometryReader { geometry in
            
            Image(images[currentIndex])
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
            
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    stopTimer()
                }
        }
        .ignoresSafeArea()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            withAnimation {
                if currentIndex < totalScreens - 1 {
                    currentIndex += 1
                } else {
                    stopTimer()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        showOnboarding = false
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    }
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
#Preview {
    OnboardingScreen(showOnboarding: .constant(false))
}
