import SwiftUI

// Загружаю данные
class DiscussionFetcher: ObservableObject {
    @Published var discussion: [Discussion] = []
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/v1/discussions") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    var decodedData = try JSONDecoder().decode([Discussion].self, from: data)
                    // Удаляем дубли
                    decodedData = Array(Set(decodedData))
                    DispatchQueue.main.async {
                        self.discussion = decodedData
                    }
                } catch {
                    print("Error decoding JSON:", error)
                }
            } else if let error = error {
                print("Network error:", error)
            }
        }.resume()
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct DiscussionPhoto: View {
    let colors: [Color] = [.fox, .sun, .grass, .fiol, .barbi] // Пример цветов
    let letter: String
    @State private var backgroundColor: Color = .black
    @State private var textColor: Color = .black

    var body: some View {
        ZStack {
            // Цвет фона
            Circle()
                .fill(backgroundColor) // Применяем выбранный цвет фона
                .frame(width: 48, height: 48)
                .clipped()
            // Текст
            Text(letter)
                .font(.custom("Yunglas", size: 33))
                .foregroundColor(textColor) // Применяем выбранный цвет текста
                .padding(.top, 5)
        }
        .onAppear {
            generateRandomColors() // Генерируем случайные цвета при появлении компонента
        }
    }

    // Функция для генерации случайных цветов
    private func generateRandomColors() {
        var newBackgroundColor: Color
        var newTextColor: Color

        // Генерируем цвета, пока они не будут различными
        repeat {
            newBackgroundColor = colors.randomElement() ?? .black
            newTextColor = colors.randomElement() ?? .black
        } while newBackgroundColor == newTextColor // Если цвета совпадают, повторяем

        // Применяем новые цвета
        backgroundColor = newBackgroundColor
        textColor = newTextColor
    }
}

struct DiscussionCard: View {
    @EnvironmentObject var favoritesDiscussion: FavoritesDiscussion
    let discussion: Discussion
    let index: Int // Новый параметр
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                tags(text: discussion.tag)
                Spacer ()
                Button(action: {
                        // Вызываем метод на экземпляре favoritesDiscussion
                        if favoritesDiscussion.isFavorite(discussionID: discussion.id) {
                            favoritesDiscussion.removeFromFavorites(discussionID: discussion.id)
                        } else {
                            favoritesDiscussion.addToFavorites(discussionID: discussion.id)
                        }
                    }) {
                        Image(favoritesDiscussion.isFavorite(discussionID: discussion.id) ? "favouriteActive" : "favourite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30) // Размер иконки
                    }
            }
            HStack (alignment: .top) {
                DiscussionPhoto(letter: String(discussion.title.prefix(1)))
                H2(text: discussion.title, case0: true)
                    .padding(0)
            }
            
            p(text: discussion.userName ?? "")
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.trailing,index % 2 == 0 ? 47: 0)
        .padding(.leading,index % 2 == 0 ? 0: 47)
        .overlay(
            RoundedCorner(radius: 100, corners: index % 2 == 0 ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft])
                .stroke(Color.chorni, lineWidth: 1) // Обводка
        )
        .padding(.horizontal, 16)
        
    }
}
struct CreateDiscussionForm: View {
    @State private var title: String = "" // Название обсуждения
    @State private var selectedTag: String = "ВСЕ" // Выбранный тег
    @State private var content: String = "" // Описание обсуждения
    
    let tagsFilter = ["ВСЕ", "БЫТ", "КУЛЬТУРА", "ОБУЧЕНИЕ", "ДОКУМЕНТЫ"] // Список тегов
    
    @Binding var discussions: [Discussion] // Связь с массивом обсуждений
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Поле для ввода названия
            CustomTextField(text: $title, title: "Вопрос", placeholder: "Задайте свой вопрос тут")
            TagSelectionMenu(text: "Категория",selectedTag: $selectedTag, tagsFilter: tagsFilter)
            // Поле для описания
            ZStack(alignment: .topLeading) {
                TextEditor(text: $content)
                    .frame(height: 100)
                    .overlay(
                        Rectangle()
                            .stroke(Color.chorni, lineWidth: 1)
                    )
                    .padding(.top, 8)
                Text("Текст вопроса")
                    .font(.custom("TTHoves-Medium", size: 14))
                    .foregroundColor(.grey700)
                    .padding(.horizontal, 8)
                    .background(
                        Rectangle()
                            .fill(Color.white) // Розовый цвет подложки
                    )
                    .padding(.leading, 12)
                    .padding(.top, 0)
            }
            
            
            // Кнопка "Создать"
            Button(action: {
                saveDiscussion() // Сохраняем обсуждение
                clearForm() // Очищаем форму
            }) {
                PrimaryButton(text: "Создать")
            }
            .disabled(title.isEmpty || content.isEmpty) // Отключаем кнопку, если поля пустые
        }
        .padding()
    }
    
    private func saveDiscussion() {
        let newDiscussion = Discussion(
            id: Int.random(in: 1000...9999), // Генерация уникального ID
            userName: "User", // Здесь можно использовать реального пользователя
            title: title,
            content: content,
            tag: selectedTag
        )
        discussions.append(newDiscussion) // Добавляем обсуждение в массив
    }
    
    private func clearForm() {
        title = ""
        selectedTag = "ВСЕ"
        content = ""
    }
}



// Шаблон для секции
struct SectionViewDiscussion<Item: Hashable, Content: View>: View {
    @State private var selectedTag: String = "ВСЕ"
    @State private var discussions: [Discussion] = []
    let title: String
    let tags: [Item]
    let tags_filter = ["ВСЕ", "БЫТ", "КУЛЬТУРА", "ОБУЧЕНИЕ", "ДОКУМЕНТЫ"]
    let content: (Item, Int) -> Content // Изменяем тип content
    
    var body: some View {
        VStack(alignment: .leading) {
            H1(text: title)
                .padding(.bottom, 5)
                .padding(.leading, 16)
            CreateDiscussionForm(discussions: $discussions)
            // Горизонтальный ScrollView для тегов
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags_filter, id: \.self) { tag in
                        TagView(tag: tag, isSelected: selectedTag == "\(tag)") {
                            selectedTag = "\(tag)" // Изменение выбранного тега
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.bottom, 10)
            }
            
            VStack(spacing: 32) {
                // Фильтрация по выбранному тегу
                ForEach(filteredTags().enumerated().map({ $0 }), id: \.element) { index, item in
                    content(item, index) // Передаем индекс
                }
            }
        }
    }
    
    private func filteredTags() -> [Item] {
        if selectedTag == "ВСЕ" {
            return tags
        } else {
            return tags.filter { tag in
                guard let discussion = tag as? Discussion else {
                    return false
                }
                return discussion.tag == selectedTag
            }
        }
    }
}
