import SwiftUI

struct MainView: View {
    @State private var selectedTab = 2
    var body: some View {
        MenuBar(selectedIndex: $selectedTab)
    }
}
