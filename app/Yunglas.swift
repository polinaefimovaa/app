import SwiftUI

@main
struct appApp: App {
    //для онбординга
    @AppStorage("hasBeenOnboarding") var hasBeenOnboarding: Bool = false
    //для регистрации и входа
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @State private var selectedIndex = 0 // Индекс выбранного пункта меню
    
    var body: some Scene {
        WindowGroup {
            if !hasBeenOnboarding {
                OnboardingContentView()
                    .onDisappear {
                        hasBeenOnboarding = true
                    }
            } else if !isAuthenticated {
                LoginView()
                    .onDisappear {
                        isAuthenticated = true
                    }
            } else {
                MenuBar(selectedIndex: $selectedIndex)
                Spacer()
                if selectedIndex == 0 {
                    StudentView() // Отображается экран "анкеты"
                } else if selectedIndex == 1 {
                    DiscussionView() // Отображается экран "обсуждения"
                } else if selectedIndex == 2 {
                    HomeView() // Отображается экран "главная"
                } else if selectedIndex == 3 {
                    ArticleView() // Отображается экран "статьи"
                } else if selectedIndex == 4 {
                    ProfileView() // Отображается экран "профиль"
                }
                Spacer()
            }
        }
    }
}

