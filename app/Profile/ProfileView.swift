import SwiftUI
import UIKit

// 1. Создаём обёртку для UIImagePickerController
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isImagePickerPresented: Bool
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        // Когда изображение выбрано
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            parent.isImagePickerPresented = false
        }
        
        // Если отмена
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isImagePickerPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true // Разрешаем редактирование
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// 2. Основное представление профиля
struct ProfileView: View {
    @State private var selectedTab = 4
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @State private var isEditing = false
    @State private var name: String = "Марк Мрамба"
    @State private var gender: String = "Мужчина"
    @State private var birthDay: String = "15"
    @State private var birthMonth: String = "Сентябрь"
    @State private var birthYear: String = "2001"
    @State private var studentEmail: String = "mmramba@edu.hse.ru"
    @State private var country: String = "Танзания"
    @State private var language: String = "Английский"
    @State private var faculty: String = "ФКИ"
    @State private var programType: String = "Подготовительный год"
    
    @State private var profileImage: UIImage? // Изображение профиля
    @State private var showImagePicker: Bool = false // Показывать выбор изображения
    
    let genders = ["Мужчина", "Женщина", "Другой"]
    let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    let countries = ["Россия", "Украина", "США", "Германия", "Франция"]
    let faculties = ["Инженерный", "Медицинский", "Гуманитарный", "Экономический"]
    let programTypes = ["Полная степень обучения", "Подготовительный год"]
    let availableLanguages = ["Русский", "Английский", "Немецкий", "Французский", "Испанский"]
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                ZStack(alignment: .leading) {
                    // Фон, растягивающийся на весь экран
                    Image("profilePattern")
                        .resizable()
                        .scaledToFit()

                    VStack (alignment: .leading, spacing: 32){
                        // HStack для картинки профиля и текста
                        HStack {
                            ZStack {
                                if let profileImage = profileImage {
                                    Image(uiImage: profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 130, height: 130)
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                } else {
                                    Circle()
                                        .frame(width: 130, height: 130)
                                        .foregroundColor(.chorni)
                                        .overlay(
                                            Text("М")
                                                .font(.custom("Yunglas", size: 40))
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                            
                            .onTapGesture {
                                showImagePicker.toggle() // Показываем ImagePicker при клике на изображение
                            }
                            .padding(.leading, 16)
                            

                        }
                        

                        
                    }

                }
                
                
                // Личная информация
                VStack (alignment: .leading, spacing: 12) {
                    Text(name)
                        .font(.custom("TTHoves-Medium", size: 20))
                    tags(text: "ИНОСТРАННЫЙ СТУДЕНТ")
                }
                .padding(.leading, 16)
                .padding(.top, 16)
                HStack {
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        PrimaryButton(text: isEditing ? "СОХРАНИТЬ" : "РЕДАКТИРОВАТЬ")
                        
                    }
                    Button(action: {
                        isAuthenticated = false // Выход из профиля
                    }) {
                        Text("ВЫЙТИ")
                            .foregroundColor(.chorni)
                            .padding()
                            .font(.custom("TTHoves-Regular", size: 20))
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(Rectangle().stroke(Color.chorni))
                    }
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 20) {

                    if isEditing {
                        TagSelectionMenu(text: "Гендер", selectedTag: $gender, tagsFilter: genders)
                    } else {
                        CustomTextFieldProfile(text: $gender, title: "Гендер")
                    }
                    
                    
                    
                    if isEditing {
                            VStack {
                                TagSelectionMenu(text: "День", selectedTag: $birthDay, tagsFilter: Array(1...31).map { "\($0)" }) // Генерация массива от 1 до 31
                                TagSelectionMenu(text: "Месяц", selectedTag: $birthMonth, tagsFilter: months) // Массив месяцев
                                TagSelectionMenu(text: "Год", selectedTag: $birthYear, tagsFilter: Array(1960...2024).map { "\($0)" }) // Генерация массива от 1960 до 2024
                            }
                    } else {
                        ZStack (alignment: .leading) {
                            Text("\(birthDay) \(birthMonth) \(birthYear)")
                                .font(.custom("TTHoves-Regular", size: 16))
                                .foregroundColor(.chorni)
                                .padding(.horizontal, 21)
                                .padding(.vertical, 12)
                            
                                .padding(.top, 8)
                            Text("Дата Рождения")
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
                    
                    
                    if isEditing {
                        CustomTextField(text: $studentEmail, title:"Студенческая почта", placeholder: "Введите студенческую почту")
                    } else {
                        CustomTextFieldProfile(text: $studentEmail, title: "Студенческая почта")
                    }
                    
                    
                    if isEditing {
                        TagSelectionMenu(text: "Страна", selectedTag: $country, tagsFilter: countries)
                    }
                    else {
                        CustomTextFieldProfile(text: $country, title: "Страна")
                    }
                    
                    
                    if isEditing {
                        TagSelectionMenu(text: "Языки", selectedTag: $language, tagsFilter: availableLanguages)
                    } else {
                        CustomTextFieldProfile(text: $language, title: "Языки")
                    }
                    
                    
                    
                    if isEditing {
                        TagSelectionMenu(text: "Факультет", selectedTag: $language, tagsFilter: availableLanguages)
                    } else {
                        CustomTextFieldProfile(text: $faculty, title: "Факультет")
                    }
                    
                    
                    
                    if isEditing {
                        TagSelectionMenu(text: "Тип программы", selectedTag: $programType, tagsFilter: programTypes)
                    } else {
                        CustomTextFieldProfile(text: $programType, title: "Тип программы")
                    }
                    
                    
                    
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(image: $profileImage, isImagePickerPresented: $showImagePicker)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
