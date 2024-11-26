import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    var body: some View {
        VStack {
            Text(data.title).font(.largeTitle)
                .padding(.bottom, 20)
            Text(data.description).font(.body)
        }
        
    }
}
