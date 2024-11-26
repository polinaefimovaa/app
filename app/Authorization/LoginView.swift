import SwiftUI

struct LoginView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Text("Войти")
                .font(.largeTitle)
                .padding(.bottom, 40)
            TextField("Ник", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Пароль", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button(action: {
                if username == "Mark00" && password == "123456" {
                    isAuthenticated = true
                }
                else {
                    print("Данные неверны")
                }
            }) {
                Text ("Войти")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding()
        }
    }
}
#Preview {
    LoginView()
}
