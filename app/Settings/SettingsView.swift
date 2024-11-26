import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // Хранит состояние темы

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Вид")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Темная тема")
                    }
                    .onChange(of: isDarkMode) { _ in
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                    }
                }
                
                Section(header: Text("О нас")) {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text("1.0.0")
                    }
                    HStack {
                        Text("Создатели")
                        Spacer()
                        Text("улучшатели бадди системы")
                    }
                }
            }
            .navigationBarTitle("Настройки", displayMode: .inline)
        }
    }
}
