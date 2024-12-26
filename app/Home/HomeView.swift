import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 2
    var body: some View {
        VStack {
            VStack {
                Image("meetFriend")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    HomeView()
}
