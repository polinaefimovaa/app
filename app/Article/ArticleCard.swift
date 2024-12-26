import SwiftUI

// Загружаю данные
class DataFetcher: ObservableObject {
    @Published var article: [Article] = []
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/v1/posts") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Article].self, from: data) // Декодируем массив
                    DispatchQueue.main.async {
                        self.article = decodedData
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

struct ArticleCard: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    let article: Article
    var body: some View {
        VStack (spacing: 20){
            
            if let imageUrl = URL(string: article.post_image.url) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 361)
                    } placeholder: {
                        ProgressView()
                    }
                    Button(action: {
                        
                        if favoritesManager.isFavorite(articleID: article.id) {
                            favoritesManager.removeFromFavorites(articleID: article.id)
                        } else {
                            favoritesManager.addToFavorites(articleID: article.id)
                        }
                    }) { Image(favoritesManager.isFavorite(articleID: article.id) ? "favouriteActive" : "favourite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36) // Размер иконки

                            
                    }
                    .padding(.top, 16)
                    .padding(.trailing, 16)
                }
                
            }
            VStack (alignment: .center, spacing: 8) {
                tags(text: article.tag)
                H2(text: article.title)
                    .multilineTextAlignment(.center)
                
                p(text: article.content)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
            Divider()
                .frame(height: 1)
                .background(Color.chorni)
        }
        .padding(.horizontal, 16)
    }
}

struct ArticleCardHuge: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    let article: Article
    var body: some View {
        
        ZStack (alignment: .top){
            Rectangle()
                .strokeBorder(.chorni, lineWidth: 1)
                .zIndex(0)
            VStack (alignment: .leading, spacing: 20){
                if let imageUrl = URL(string: article.post_image.url) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 361)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)  // Верхняя граница
                                    .foregroundColor(.chorni),
                                alignment: .top
                            )
                            .overlay(
                                Rectangle()
                                    .frame(width: 1)  // Левая граница
                                    .foregroundColor(.chorni),
                                alignment: .leading
                            )
                            .overlay(
                                Rectangle()
                                    .frame(width: 1)  // Правая граница
                                    .foregroundColor(.chorni),
                                alignment: .trailing
                            )
                    } placeholder: {
                        ProgressView()
                    }
                    .zIndex(0)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    tags(text: article.tag)
                    H2(text: article.title)
                        .underline()
                        .lineLimit(nil)
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                p(text: article.content, colorText: .chorni)
                    .lineLimit(3)
                    .padding(.horizontal, 16)
                
                HStack {
                    Button(action: {
                    }) {
                        PrimaryButton(text: "ПРОЧИТАТЬ")
                        
                    }
                    Button(action: {
                        if favoritesManager.isFavorite(articleID: article.id) {
                            favoritesManager.removeFromFavorites(articleID: article.id)
                        } else {
                            favoritesManager.addToFavorites(articleID: article.id)
                        }
                    }) { Image(favoritesManager.isFavorite(articleID: article.id) ? "favouriteActive" : "favourite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 54) // Размер иконки

                            
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 4)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 40)
    }
}


// Шаблон для секции
struct SectionView<Item: Hashable, Content: View>: View {
    @State private var selectedTag: String = "ВСЕ"
    let title: String
    let tags: [Item]
    let tags_filter = ["ВСЕ", "БЫТ", "КУЛЬТУРА", "ОБУЧЕНИЕ", "ДОКУМЕНТЫ"]
    let content: (Item) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            H1(text: title)
                .padding(.bottom, 5)
                .padding(.leading, 16)
            
            // Отображаем первую карточку вручную
            if let lastTag = tags.last as? Article {
                ArticleCardHuge(article: lastTag)
            }  
            
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
                ForEach(filteredTags(), id: \.self) { item in
                    content(item)
                }
            }
        }
    }
    
    private func filteredTags() -> [Item] {
        if selectedTag == "ВСЕ" {
            return tags
        } else {
            // Фильтрация по тегу; замените условие на ваше
            return tags.filter { tag in
                        // Убедитесь, что 'tag' может быть преобразован в 'Article'
                        guard let article = tag as? Article else {
                            return false // Если преобразование не удалось, фильтруем элемент
                        }
                        // Вернуть true, если категория статьи совпадает с выбранным тегом
                        return article.tag == selectedTag
                    }
            
        }
    }
    
}
