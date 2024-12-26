import SwiftUI
struct MenuBar: View {
    @Binding var selectedIndex: Int // Индекс выбранного элемента меню
    let menuItems = ["бадди", "обсуждения", "главная", "статьи", "профиль"]
    let menuIcons: [String: [String]] = [
        "бадди": ["student", "student_active"],
        "обсуждения": ["discussion", "discussion_active"],
        "главная": ["home", "home_active"],
        "статьи": ["article", "article_active"],
        "профиль": ["profile", "profile_active"]
    ]
    
    var body: some View {
        HStack {
            ForEach(menuItems.indices, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedIndex = index
                    }
                }) {
                    VStack{
                        if let iconNames = menuIcons[menuItems[index]] {
                            Image(iconNames[selectedIndex == index ? 1 : 0])
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        
                        Text(menuItems[index])
                            .font(.custom("TTHoves-Regular", size: 12))
                            .foregroundColor(selectedIndex == index ? .chorni : .grey500)
                            .cornerRadius(8)
                    }
                    .frame(width:66)
                    
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical,12)
        .background(Color.white)
    }
}

#Preview {
    HomeView()
}
