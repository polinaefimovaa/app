import SwiftUI
// Секции
struct ArticleSectionView: View {
    let article: [Article]

    var body: some View {
        ScrollView {
            SectionView(title: "СТАтЬи", tags: article) { article in
                ArticleCard(article: article)
            }
            .padding()
        }
    }
}


