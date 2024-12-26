import SwiftUI

struct StudentView: View {
    @AppStorage("isSentBuddy") private var isSentBuddy = false // Используем @AppStorage для сохранения состояния
    @State private var selectedTab = 0
    @State private var interests: String = ""
    @State private var arrivalDay: String = ""
    @State private var arrivalMonth: String = ""
    @State private var arrivalYear: String = "" // Создаем переменную для года
    @State private var arrivalTime: String = ""
    @State private var arrivalPlace: String = ""
    @State private var accommodation: String = ""
    @State private var additionalInfo: String = "" // Переменная для дополнительных данных
    
    let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    let arrivalPlaces = ["Выбери вокзал или аэропорт", "Вокзал", "Аэропорт"]
    let accommodations = ["Выбери общежитие/место размещения", "Общежитие 1", "Общежитие 2"]
    
    private var isFormValid: Bool {
        return !interests.isEmpty &&
        !arrivalDay.isEmpty &&
        !arrivalMonth.isEmpty &&
        !arrivalYear.isEmpty &&
        !arrivalTime.isEmpty &&
        !arrivalPlace.isEmpty &&
        !accommodation.isEmpty
    }
    
    var body: some View {
        ScrollView {
            H1(text: "АНкЕТа")
            
            VStack(alignment: .leading, spacing: 16) {
                CustomTextFieldLong(text: $interests, title: "Интересы", placeholder: "Расскажи о себе: чем ты увлекаешься?")
                    .padding(.horizontal, 16)
                H2(text: "Дата прибытия в Россию")
                    .padding(.horizontal, 16)
                VStack(spacing: 16) {
                    TagSelectionMenu(text: "День", selectedTag: $arrivalDay, tagsFilter: Array(1...31).map { "\($0)" })
                    TagSelectionMenu(text: "Месяц", selectedTag: $arrivalMonth, tagsFilter: months)
                    TagSelectionMenu(text: "Год", selectedTag: $arrivalYear, tagsFilter: [2024, 2025].map { "\($0)" })
                    CustomTextField(text: $arrivalTime , title: "Время прибытия", placeholder: "чч:мм")
                        .padding(.horizontal, 16)
                    TagSelectionMenu(text: "Место прибытия", selectedTag: $arrivalPlace, tagsFilter: arrivalPlaces)
                    TagSelectionMenu(text: "Место размещения", selectedTag: $accommodation, tagsFilter: accommodations)
                }
                CustomTextFieldLong(text: $additionalInfo, title: "Дополнительно", placeholder: "Если у тебя есть вопросы или пожелания")
                    .padding(.horizontal, 16)
            }
            Button(action: {
                isSentBuddy = true // Отметим, что форма отправлена
            }) {
                PrimaryButton(text: "ОТПРАВИТЬ")
                    .opacity(isFormValid ? 1.0 : 0.7)
            }
            .disabled(!isFormValid) // Если форма не валидна, кнопка будет недоступна
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
