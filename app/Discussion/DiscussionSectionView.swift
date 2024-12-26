import SwiftUI

struct DiscussionSectionView: View {
    let discussions: [Discussion] // Переименовано на множественное число

    var body: some View {
        ScrollView {
            SectionViewDiscussion(title: "ОБСУжДЕНия", tags: discussions) { discussion, index in
                DiscussionCard(discussion: discussion, index: index) // Передаем корректные параметры
            }
            .padding()
        }
    }
}
