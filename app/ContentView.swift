import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = [
        Card(title: "Card 1", description: "Description for card 1", tags: ["Tag1", "Tag2"]),
        Card(title: "Card 2", description: "Description for card 2", tags: ["Tag3"]),
        Card(title: "Card 3", description: "Description for card 3", tags: ["Tag1", "Tag4"])
    ]
    @State private var showModal = false
    @State private var selectedTags: Set<String> = []
    @State private var searchText: String = ""
    @State private var showProfile = false
    @State private var showSettings = false
    @State private var selectedCard: Card? = nil
    @State private var user = UserProfile(
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        avatar: UIImage(named: "avatar_placeholder")
    )

    var filteredCards: [Card] {
        cards.filter { card in
            let matchesTag = selectedTags.isEmpty || selectedTags.contains("All") || !selectedTags.isDisjoint(with: card.tags)
            let matchesSearchText = searchText.isEmpty || card.title.localizedCaseInsensitiveContains(searchText) || card.description.localizedCaseInsensitiveContains(searchText)
            return matchesTag && matchesSearchText
        }
    }

    var sortedTags: [String] {
        let allTags = Array(Set(cards.flatMap { $0.tags }))
        let unselectedTags = allTags.filter { !selectedTags.contains($0) }
        return ["All"] + Array(selectedTags).filter { $0 != "All" } + unselectedTags.sorted()
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sortedTags, id: \.self) { tag in
                            Text(tag)
                                .padding(8)
                                .background(selectedTags.contains(tag) ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedTags.contains(tag) ? .white : Color.primary)
                                .cornerRadius(10)
                                .onTapGesture {
                                    if tag == "All" {
                                        selectedTags = ["All"]
                                    } else {
                                        selectedTags.remove("All")
                                        if selectedTags.contains(tag) {
                                            selectedTags.remove(tag)
                                        } else {
                                            selectedTags.insert(tag)
                                        }
                                    }
                                }
                        }
                    }
                    .padding()
                }

                List {
                    ForEach(filteredCards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                selectedCard = card
                            }
                    }
                    .onDelete(perform: deleteCard)
                }
                .navigationBarTitle("Cards")
                .navigationBarItems(
                    leading: HStack {
                        Button(action: {
                            showProfile.toggle()
                        }) {
                            if let avatar = user.avatar {
                                Image(uiImage: avatar)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle")
                                    .font(.title)
                            }
                        }
                        Button(action: {
                            showSettings.toggle()
                        }) {
                            Image(systemName: "gearshape.fill") // Иконка настроек
                                .font(.title)
                        }
                    },
                    trailing: Button(action: {
                        showModal.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                )
                .sheet(isPresented: $showModal) {
                    AddCardView(cards: $cards)
                }
                .sheet(isPresented: $showProfile) {
                    ProfileView(user: $user)
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
                .fullScreenCover(item: $selectedCard) { card in
                    CardView(card: card)
                }
            }
        }
    }
    
    func deleteCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}
