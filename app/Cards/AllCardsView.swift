import SwiftUI

struct AllCardsView: View {
    @State private var cards: [Card] = [
        Card(title: "Card 1", description: "Description for card 1", tags: ["Tag1", "Tag2"]),
        Card(title: "Card 2", description: "Description for card 2", tags: ["Tag3"]),
    ]
    @State private var showModal = false
    var body: some View {
        NavigationView {
            List {
                ForEach(cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            // Открытие детального просмотра карточки
                        }
                }
            }
            .navigationBarTitle("Cards")
            .navigationBarItems (trailing: Button (action: {
                showModal.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet (isPresented: $showModal) {
                AddCardView(cards: $cards)
            }
        }
    }
}

struct AddCardView: View {
    @Binding var cards: [Card]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Card Information")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Tags (comma separated)", text: $tags)
                }
                Button("Add Card") {
                    let tagList = tags.split(separator: ",").map {
                        String($0).trimmingCharacters (in: .whitespaces)
                    }
                    let newCard = Card(title: title, description: description, tags: tagList)
                    cards.append(newCard)
                }
            }
            .navigationBarTitle("Add Card")
            .navigationBarItems (trailing: Button("Done") {
                
                // Закрытие модального окна
            })
        }
    }
}
