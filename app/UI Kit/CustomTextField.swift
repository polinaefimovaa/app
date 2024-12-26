import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var title: String
    var placeholder: String

    var body: some View {
        ZStack (alignment: .leading) {
            TextField(placeholder, text: $text)
                .font(.custom("TTHoves-Regular", size: 16))
                .foregroundColor(.chorni)
                .padding(.horizontal, 21)
                .padding(.vertical, 12)
                .overlay(
                    Rectangle()
                        .stroke(Color.chorni, lineWidth: 1) // Рамка вокруг текстового поля
                )
                .padding(.top, 8)
            Text(title)
                .font(.custom("TTHoves-Medium", size: 14))
                .foregroundColor(.grey700)
                .padding(.horizontal, 8)
                .background(
                    Rectangle()
                        .fill(Color.white) // Розовый цвет подложки
                )
                .padding(.leading, 12)
                .padding(.bottom, 35)
                
        }
        .padding(.bottom,8)
    }
}

struct CustomTextFieldProfile: View {
    @Binding var text: String
    var title: String

    var body: some View {
        ZStack (alignment: .leading) {
            Text(text)
                .font(.custom("TTHoves-Regular", size: 16))
                .foregroundColor(.chorni)
                .padding(.horizontal, 21)
                .padding(.vertical, 12)
                
                .padding(.top, 8)
            Text(title)
                .font(.custom("TTHoves-Medium", size: 14))
                .foregroundColor(.grey700)
                .padding(.horizontal, 8)
                .background(
                    Rectangle()
                        .fill(Color.white) // Розовый цвет подложки
                )
                .padding(.leading, 12)
                .padding(.bottom, 35)
                
        }
        .padding(.bottom,8)
    }
}


struct CustomTextFieldSecure: View {
    @Binding var text: String
    var title: String
    var placeholder: String

    var body: some View {
        ZStack (alignment: .leading) {
            SecureField(placeholder, text: $text)
                .font(.custom("TTHoves-Regular", size: 16))
                .foregroundColor(.chorni)
                .padding(.horizontal, 21)
                .padding(.vertical, 12)
                .overlay(
                    Rectangle()
                        .stroke(Color.chorni, lineWidth: 1) // Рамка вокруг текстового поля
                )
                .padding(.top, 8)
            Text(title)
                .font(.custom("TTHoves-Medium", size: 14))
                .foregroundColor(.grey700)
                .padding(.horizontal, 8)
                .background(
                    Rectangle()
                        .fill(Color.white) // Розовый цвет подложки
                )
                .padding(.leading, 12)
                .padding(.bottom, 35)
                
        }
        .padding(.bottom,8)
    }
}
struct CustomTextFieldLong: View {
    @Binding var text: String
    var title: String
    var placeholder: String

    var body: some View {
        ZStack (alignment: .leading) {
            TextField(placeholder, text: $text)
                .font(.custom("TTHoves-Regular", size: 16))
                .foregroundColor(.chorni)
                .padding(.horizontal, 21)
                .padding(.vertical, 12)
                .padding(.bottom, 24)
                .overlay(
                    Rectangle()
                        .stroke(Color.chorni, lineWidth: 1) // Рамка вокруг текстового поля
                )
                .padding(.top, 8)
            Text(title)
                .font(.custom("TTHoves-Medium", size: 14))
                .foregroundColor(.grey700)
                .padding(.horizontal, 8)
                .background(
                    Rectangle()
                        .fill(Color.white) // Розовый цвет подложки
                )
                .padding(.leading, 12)
                .padding(.bottom, 58)
                
        }
        .padding(.bottom,8)
    }
}

struct TagSelectionMenu: View {
    let text: String
    @Binding var selectedTag: String // Привязка к выбранному тегу
    let tagsFilter: [String] // Список доступных тегов
    
    var body: some View {
        Menu {
            ForEach(tagsFilter, id: \.self) { tag in
                Button(action: {
                    selectedTag = tag // Обновляем выбранный тег
                }) {
                    Text(tag)
                        .font(.custom("TTHoves-Regular", size: 16))
                        .foregroundColor(selectedTag == tag ? .chorni : .chorni) // Здесь контролируем цвет
                        .padding()
                }
            }
        } label: {
            ZStack(alignment: .topLeading) {
                Text(text)
                    .font(.custom("TTHoves-Medium", size: 14))
                    .foregroundColor(.grey700) // Цвет текста
                    .padding(.horizontal, 8)
                    .background(
                        Rectangle()
                            .fill(Color.white) // Розовый цвет подложки
                    )
                    .padding(.top, -20)
                    .padding(.leading, 0)
                
                HStack {
                    Text(selectedTag)
                        .font(.custom("TTHoves-Regular", size: 16))
                        .foregroundColor(selectedTag == "Выберите тег" ? .chorni : .chorni) // Цвет по умолчанию
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.chorni)
                }
                .padding(.leading, 8)
            }
            .padding()
            .frame(width: 362, height: 43, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 40).stroke(Color.chorni, lineWidth: 1)) // Оформление
        }
    }
}
