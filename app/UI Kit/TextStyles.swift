import SwiftUI

struct H1: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.custom("Yunglas", size: 45))
            .foregroundColor(.chorni)
            .kerning(2)
    }
}

struct H2: View {
    var text: String
    var case0: Bool?
    var colorText: Color?
    var body: some View {
        Text(case0 == true ? text.uppercased() : text)
            .font(.custom("TTHoves-Medium", size: 24))
            .foregroundColor(colorText ?? .chorni)
    }
}
struct tags: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("TTHoves-Medium", size: 14))
            .foregroundColor(.chorni) // Цвет текста
            .padding(.horizontal,12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.chorni, lineWidth: 1)
            )
    }
}


struct TagView: View {
    let tag: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(tag)
            .font(.custom("TTHoves-Medium", size: 14))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.chorni : Color.white) // Заливка при нажатии
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.chorni, lineWidth: 1) // Обводка
            )
            .foregroundColor(isSelected ? Color.white : Color.black) // Цвет текста
            .cornerRadius(20) // Закруглённые края
            .onTapGesture {
                action() // Выполнение действия
            }  
            
            
    }
}



struct p: View {
    var text: String
    var colorText: Color?
    var body: some View {
        Text(text)
            .font(.custom("TTHoves-Regular", size: 16))
            .foregroundColor(colorText ?? .grey700)
    }
}
