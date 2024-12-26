import SwiftUI
import UIKit



struct OnboardingView: View {
    var data: OnboardingData
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 34)
            Text(data.title)
                .font(.custom("Yunglas", size: 40))
                .foregroundColor(.chorni)
                .kerning(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 16)
            p(text: data.description)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            
        }
        .padding(.bottom,0)
        
    }
    
    
}

#Preview {
    OnboardingContentView()
}
