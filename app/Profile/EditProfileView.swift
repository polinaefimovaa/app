import SwiftUI

struct EditProfileView: View {
    @Binding var user: UserProfile
    @Binding var selectedImage: UIImage?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var showImagePicker: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Аватар")) {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }
                    }
                }
                Section(header: Text("Личная информация")) {
                    TextField("Имя", text: $firstName)
                    TextField("Фамилия", text: $lastName)
                    TextField("Почта", text: $email)
                        .keyboardType(.emailAddress)
                }
            }
            .navigationBarTitle("Редактировать профиль")
            .navigationBarItems(leading: Button("Отмена") {
                // Закрыть представление редактирования без сохранения
            }, trailing: Button("Сохранить") {
                user.firstName = firstName
                user.lastName = lastName
                user.email = email
                if let selectedImage = selectedImage {
                    user.avatar = selectedImage
                }
                // Закрыть представление редактирования
            })
            .onAppear {
                firstName = user.firstName
                lastName = user.lastName
                email = user.email
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}
