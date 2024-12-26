import SwiftUI

struct LoginView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isEmailValid: Bool = true
    
    var body: some View {
        VStack {
            Image("logIn")
                .resizable()
            
            VStack (alignment: .leading) {
                H1(text: "ВХОД")
                    .padding(.top, 32)
                CustomTextField(text: $email, title: "Студенческая почта", placeholder: "Введите почту")
                CustomTextFieldSecure(text: $password, title: "Пароль", placeholder: "Введите пароль")
                
                Button(action: {
                    if authenticate(email: email, password: password) {
                        isAuthenticated = true 
                    } else {
                        print("Данные неверны")
                    }
                }) {
                    PrimaryButton(text: "ВОЙТИ")
                        
                }
                HStack {
                    Text("Нет аккаунта?")
                        .font(.custom("TTHover-Regular", size: 18))
                        .foregroundColor(.grey700)
                    Spacer()
                    Link("Регистрация", destination: URL(string: "http://localhost:3000/users/sign_up")!)
                        .font(.custom("TTHover-Medium", size: 18))
                        .foregroundColor(.chorni)
                        
                }
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 16)
            
        }
    }
    private func authenticate(email: String, password: String) -> Bool {
        if "student_0@edu.hse.ru" == email.lowercased() && password == "12345" {
            return true // Успешная аутентификация
        }
        return false // Неудачная аутентификация
    }
}
#Preview {
    LoginView()
}
