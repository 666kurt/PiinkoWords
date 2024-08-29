import SwiftUI

struct SplashScreen: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isActive: Bool = false
    @Binding var showOnboarding: Bool

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Color(hex: "#000B71").ignoresSafeArea()
                
                VStack(spacing: 100) {
                    Image("splashGirl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6)
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 12)
                            .foregroundColor(Color(hex: "#2F19C8"))
                        
                        Rectangle()
                            .frame(width: progress, height: 12)
                            .foregroundColor(Color(hex: "#FF009A"))
                            .animation(.linear(duration: 0.05), value: progress)
                    }
                    .cornerRadius(10)
                    .frame(width: geometry.size.width * 0.7)
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            startLoading()
        }
        .fullScreenCover(isPresented: $isActive) {
            if showOnboarding {
                OnboardingScreen(showOnboarding: $showOnboarding)
            } else {
                WelcomeScreen()
            }
        }
    }
    
    func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress < UIScreen.main.bounds.width * 0.7 {
                progress += 8
            } else {
                timer.invalidate()
                isActive = true
            }
        }
    }
}

#Preview {
    SplashScreen(showOnboarding: .constant(true))
}
