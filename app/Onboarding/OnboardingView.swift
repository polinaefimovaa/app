import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    var body: some View {
        VStack {
            Text(data.title).font(.largeTitle)
            Text(data.description).font(.body)
        }
    }
}
