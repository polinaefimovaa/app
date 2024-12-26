import SwiftUI

@main
struct Yunglas: App {
    @StateObject var favoritesManager = FavoritesManager()
    @StateObject var favoritesDiscussion = FavoritesDiscussion()
    
    // для онбординга
    @AppStorage("isSentBuddy") var isSentBuddy: Bool = false
    @AppStorage("hasBeenOnboarding") var hasBeenOnboarding: Bool = false
    // для регистрации и входа
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @State private var selectedIndex = 2 // Индекс выбранного пункта меню
    
    var body: some Scene {
        WindowGroup {
            VStack {
                // Онбординг экран
                if !hasBeenOnboarding {
                    OnboardingContentView()
                        .onDisappear {
                            hasBeenOnboarding = true
                        }
                }
                // Экран входа, если пользователь не аутентифицирован
                else if !isAuthenticated {
                    LoginView()
                        .onDisappear {
                            isAuthenticated = true
                        }
                }
                // Основное содержимое после онбординга и авторизации
                else {
                    Group {
                        // Экран анкеты или другого содержимого в зависимости от состояния isSentBuddy
                        if selectedIndex == 0 {
                            if isSentBuddy { // Переход в StudentView1
                                StudentView1()
                            } else { // Переход в StudentView
                                StudentView()
                            }
                        }
                        // Экран обсуждения
                        else if selectedIndex == 1 {
                            DiscussionView().environmentObject(favoritesDiscussion)
                        }
                        // Главная страница
                        else if selectedIndex == 2 {
                            HomeView()
                                .environmentObject(favoritesManager)
                                .environmentObject(favoritesDiscussion)
                        }
                        // Статьи
                        else if selectedIndex == 3 {
                            ArticleView().environmentObject(favoritesManager)
                        }
                        // Профиль
                        else if selectedIndex == 4 {
                            ProfileView().environmentObject(favoritesManager)
                        }
                    }
                    
                    Spacer()
                    
                    // Меню навигации
                    MenuBar(selectedIndex: $selectedIndex)
                        .padding(.bottom, 0) // Добавляем отступ от низа экрана
                }
            }
        }
    }
}
