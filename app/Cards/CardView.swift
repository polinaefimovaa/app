import SwiftUI

struct CardView: View {
    var card: Card
    var body: some View {
        
        VStack(alignment: .leading) {
            Text (card.title)
                .font(.headline)
            Text (card.description)
                .font(.subheadline)
                .lineLimit(2)
                .padding (.top, 5)
            HStack {
                ForEach(card.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
//struct CardPageView: View {
//    var card: Card
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text (card.title)
//                    .font(.headline)
//                Text (card.description)
//                    .font(.subheadline)
//                    .padding (.top, 5)
//                HStack {
//                    ForEach(card.tags, id: \.self) { tag in
//                        Text(tag)
//                            .font(.caption)
//                            .padding(5)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(5)
//                    }
//                }
//                .padding(.top, 5)
//            }
//
//        }
//        .padding()
//        .background(Color.white)
//
//    }
//}
struct CardPageView: View {
    var card: Card
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                Text(card.title)
                    .font(.headline)
                    .padding(.top) // Добавляем отступ сверху для заголовка
                Text(card.description)
                    .font(.subheadline)
                    .padding(.top, 5)
                HStack {
                    ForEach(card.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                    }
                }
                .padding(.top, 5)
                
                Spacer() // Добавляем Spacer для отступа внизу
            }
            .padding() // Отступы для всего содержимого
            .background(Color.white) // Фон для всего содержимого
            .navigationTitle(card.title) // Заголовок навигации
            .navigationBarTitleDisplayMode(.inline) // Режим отображения заголовка
            .navigationBarBackButtonHidden(true) // Скрываем кнопку "назад"
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Назад") // Можете заменить на свой контент или кнопку
            })
        }
    }
}
