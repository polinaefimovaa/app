import SwiftUI

@main
struct appApp: App {
    //для онбординга
    @AppStorage("hasBeenOnboarding") var hasBeenOnboarding: Bool = false
    //для регистрации и входа
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false

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
                ContentView()
            }
        }
    }
}
