import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 2
    @StateObject private var articleFetcher = DataFetcher() // Обновленный fetcher для статей
    @StateObject private var discussionFetcher = DiscussionFetcher() // Обновленный fetcher для обсуждений
    @StateObject var favoritesManager = FavoritesManager()
    @StateObject var favoritesDiscussion = FavoritesDiscussion()

    var body: some View {
        ScrollView {
            VStack(spacing: 72) {
                // Первый раздел контента
                VStack(spacing: 16) {
                    Image("meetFriend")
                        .resizable()
                        .scaledToFit()
                    VStack(spacing: 8) {
                        HStack(spacing: 4) {
                            tags(text: "ОБУЧЕНИЕ")
                            Image("favourite")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36)
                        }
                        H2(text: "как завести друзей в университете", case0: true)
                            .multilineTextAlignment(.center)
                        p(text: "Переезд в другую страну для учёбы — это захватывающий и увлекательный опыт. Однако, чтобы этот процесс прошёл гладко, важно тщательно подготовиться и ничего не упустить")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                }

                // Второй раздел контента
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        H2(text: "календарь мероприятий", case0: true)
                            .multilineTextAlignment(.center)
                        p(text: "Будь в курсе событий, которые проходят в Вышке и в городе. Они помогут тебе влиться как в учебный процесс, так и в жизнь в России.")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }

                    // Дополнительный контент
                    HStack {
                        H2(text: "Декабрь 2024")
                        Spacer()
                        HStack(spacing: 20) {
                            Image("leftArrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            Image("rightArrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                        }
                    }

                    HStack(spacing: 27) {
                        Calendar(text: "БЫТ", color: .fiol)
                        Calendar(text: "ДОКУМЕНТЫ", color: .grass)
                        Calendar(text: "ОБУЧЕНИЕ", color: .barbi)
                        Calendar(text: "КУЛЬТУРА", color: .fox)
                    }

                    HStack {
                        VStack (alignment: .leading) {
                            VStack (alignment: .leading, spacing: 4) {
                                H2(text: "Пн", colorText: .white)
                                H2(text: "23", colorText: .white)
                            }
                            VStack (alignment: .leading, spacing: 0) {
                                HStack (spacing: 4) {
                                    Circle()
                                        .fill(.barbi)
                                        .frame(width: 10, height: 10)
                                    Text("17:00")
                                        .font(.custom("TTHoves-Medium", size: 14))
                                        .foregroundColor(.white)
                                }
                                Text("мастер-класс «Ли...")
                                    .font(.custom("TTHoves-Medium", size: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal,8)
                            .padding(.top,7)
                            .padding(.bottom,12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 11)
                        .frame(height: 358)
                        .background(Color.chorni)
                        .clipShape(CustomCornerShape(corner: .bottomRight, radius: 90))
                        Spacer()
                        VStack (alignment: .leading) {
                                                 VStack (alignment: .leading, spacing: 4) {
                                                     H2(text: "Вт")
                                                     H2(text: "24")
                                                 }
                                                 VStack (alignment: .leading, spacing: 0) {
                                                     HStack (spacing: 4) {
                                                         Circle()
                                                             .fill(.barbi)
                                                             .frame(width: 10, height: 10)
                                                         Text("17:00")
                                                             .font(.custom("TTHoves-Medium", size: 14))
                                                             .foregroundColor(.chorni)
                                                         
                                                     }
                                                     Text("мастер-класс «Ли...")
                                                         .font(.custom("TTHoves-Medium", size: 14))
                                                         .foregroundColor(.chorni)
                                                 }
                                                 .padding(.horizontal,8)
                                                 .padding(.top,7)
                                                 .padding(.bottom,12)
                                                 .overlay(
                                                     RoundedRectangle(cornerRadius: 11)
                                                         .stroke(Color.chorni, lineWidth: 1)
                                                 )
                                                 Spacer()
                                                 
                                             }
                                             .padding(.horizontal, 16)
                                             .padding(.top, 11)
                                             .frame(height: 358)
                                             .overlay(
                                                 Rectangle()
                                                     .stroke(Color.chorni, lineWidth: 1)
                                             )
                    }
                }
                .padding(.horizontal, 16)

                VStack (spacing: 8) {
                    SectionNav(text: "ПЕРЕЙТИ К СТАТЬЯМ")
                        .padding(.horizontal, 16)
                    
                    // Раздел статей
                    if !articleFetcher.article.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(articleFetcher.article.prefix(3), id: \.id) { article in
                                ArticleCard(article: article)
                            }
                        }
                    } else {
                        ProgressView()
                            .padding(.horizontal, 16)
                    }
                }

                VStack (spacing: 8) {
                    SectionNav(text: "ПЕРЕЙТИ К ОБСУЖДЕНИЯМ")
                        .padding(.horizontal, 16)
                    
                    // Раздел обсуждений
                    if !discussionFetcher.discussion.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(discussionFetcher.discussion.prefix(3), id: \.id) { discussion in
                                DiscussionCard(discussion: discussion, index: 0)
                            }
                        }
                    } else {
                        ProgressView()
                            .padding(.horizontal, 16)
                    }
                }
            }
            .onAppear {
                articleFetcher.fetchData() // Загружаем статьи при появлении вью
                discussionFetcher.fetchData() // Загружаем обсуждения при появлении вью
            }

            // Добавляем раздел с последней статьей
//            if let lastArticle = articleFetcher.article.last {
//                VStack(alignment: .leading, spacing: 16) {
//                    ArticleCardHuge(article: lastArticle)
//                }
//                .padding(.top, 40)
//            } else {
//                ProgressView()
//                    .padding(.horizontal, 16)
//            }
        }
    }
}

#Preview {
    let favoritesManager = FavoritesManager()
    let favoritesDiscussion = FavoritesDiscussion()
    return HomeView()
        .environmentObject(favoritesManager)
        .environmentObject(favoritesDiscussion)
}
