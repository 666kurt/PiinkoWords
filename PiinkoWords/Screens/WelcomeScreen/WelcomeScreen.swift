import SwiftUI

// MARK: main
struct WelcomeScreen: View {
    
    @StateObject private var categories = GameData.shared
    @StateObject private var audioManager = AudioManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 22) {
                
                headerView
                
                categoriesScrollView
                
            }
            .customVStack()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            audioManager.loadSound(named: "welcomeSound", withExtension: "mp3")
            audioManager.playSound(named: "welcomeSound", loop: true)
        }
        .onDisappear {
            audioManager.stopSound(named: "welcomeSound")
        }
    }
}

// MARK: views
extension WelcomeScreen {
    
    private var categoriesScrollView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(categories.categories, id: \.id) { category in
                NavigationLink(destination: GameScreen(category: category)) {
                    WelcomeCardView(category: category)
                }
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            HStack() {
                NavigationLink {
                    let randomWordsCategory = createRandomCategory()
                    GameScreen(category: randomWordsCategory)
                        .environmentObject(audioManager)
                } label: {
                    Text("Random")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            .padding(.leading, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "##1800AE"))
            .clipShape(Capsule())
            
            Button {
                audioManager.toggleSound(named: "welcomeSound", loop: true)
            } label: {
                Image("sound")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            
            NavigationLink(destination: SettingsScreen()) {
                Image("settings")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
    
    private func createRandomCategory() -> Category {
        let allWords = categories.categories.flatMap { $0.words }
        let randomWords = Array(allWords.shuffled().prefix(6))
        let randomCategory = Category(name: "Random", image: "", words: randomWords)
        return randomCategory
    }
    
}

#Preview {
    WelcomeScreen()
}
