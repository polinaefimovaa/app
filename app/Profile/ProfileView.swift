import SwiftUI
struct ProfileView: View {
    @State private var user: UserProfile = UserProfile(
        firstName: "Марк",
        lastName: "Руанда",
        email: "mark@edu.hse.ru",
        avatar: UIImage(named: "avatar_placeholder")
    )
    @State private var isEditing: Bool = false
    @State private var showSettings: Bool = false
    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationView {
            VStack {
                if let avatar = user.avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }
                Text("\(user.firstName) \(user.lastName)")
                    .font(.largeTitle)
                    .padding(.top, 20)
                Text(user.email)
                    .font(.subheadline)
                    .padding(.top, 5)
                Spacer()
                
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text("Редактировать профиль")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $isEditing) {
                EditProfileView(user: $user, selectedImage: $selectedImage)
            }
            .padding()
            .navigationBarTitle("Профиль", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showSettings.toggle()
            }) {
                Image(systemName: "gear")
            })
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
        
}
