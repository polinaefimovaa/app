//
//  ContentView.swift
//  shit_for_grig_11_dec
//
//  Created by Эльвира on 11.12.2024.
//

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

// Новости
struct ArticleCard: View {
    let article: Article

    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                            // Отображаем изображение статьи
                            if let imageUrl = URL(string: article.post_image.url) {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200) // Устанавливаем высоту для изображения
                                        .clipped() // Обрезаем изображение, если оно выходит за границы
                                } placeholder: {
                                    ProgressView() // Показываем индикатор загрузки во время загрузки изображения
                                }
                            }
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                if let content = article.content {
                    Text(content)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }

                if let createdAt = article.createdAt {
                    Text(createdAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(12)
            .frame(width: 300)
        }
    }

// Шаблон для секции
struct SectionView<Item: Hashable, Content: View>: View {
    let title: String
    let tags: [Item]
    let content: (Item) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(tags, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
}

// Секции
struct ArticleSectionView: View {
    let article: [Article]

    var body: some View {
        ScrollView {
            SectionView(title: "Новости", tags: article) { article in
                ArticleCard(article: article)
            }
            .padding()
        }
    }
}

struct Content1View: View {
    @StateObject private var fetcher = DataFetcher()
    @State private var currentPage: Int = 0

    var body: some View {
        TabView(selection: $currentPage) {
            ArticleSectionView(article: fetcher.article)
                .tag(0)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear {
            fetcher.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Content1View()
    }
}
