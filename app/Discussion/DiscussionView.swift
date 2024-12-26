import SwiftUI

struct DiscussionView: View {
    @StateObject private var fetcher = DiscussionFetcher()
    @State private var currentPage: Int = 0

    var body: some View {
        TabView(selection: $currentPage) {

            DiscussionSectionView(discussions: fetcher.discussion)  // Изменено на 'discussions'
                .tag(0)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear {
            fetcher.fetchData()
        }
    }
}
