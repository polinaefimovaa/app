import SwiftUI


class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") var selectedTheme: String = "light" {
        didSet {
            switch selectedTheme {
            case "light":
                currentTheme = Themes.light
            case "dark":
                currentTheme = Themes.dark
            case "blue":
                currentTheme = Themes.blue
            default:
                currentTheme = Themes.light
            }
        }
    }
    @Published var currentTheme: Theme = Themes.light
    init() {
        switch selectedTheme {
        case "light":
            currentTheme = Themes.light
        case "dark":
            currentTheme = Themes.dark
        case "blue":
            currentTheme = Themes.blue
        default:
            currentTheme = Themes.light
        }
    }
}
