import SwiftUI

struct GameToolBarView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    let category: Category
    
    var body: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("back")
                    .resizable()
                    .frame(width: 37, height: 37)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            Text(category.name)
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity)
            
            
            Text("03:00")
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    GameToolBarView(category: Category(name: "Animals",
                                       image: "lion",
                                       words: [
                                        Word(text: "horse", image: "pony"),
                                        Word(text: "dog", image: "dog"),
                                        Word(text: "lion", image: "lion"),
                                        Word(text: "fish", image: "fish"),
                                        Word(text: "bear", image: "bear"),
                                        Word(text: "koala", image: "koala"),
                                        Word(text: "bunny", image: "bunny"),
                                       ]))
    .customVStack()
}
