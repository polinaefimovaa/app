import SwiftUI
import UIKit



struct OnboardingContentView: View {
    
    
    
    let pages = [
        OnboardingData(title: "зАпОЛНи \nаНкЕТу", description: "Заполни анкету, чтобы мы поняли твои интересы и выбрали идеального бадди для дружбы и помощи в новой стране!", image: "onboarding1"),
        OnboardingData(title: "ЖизНь В РОсСиИ", description: "Заполни анкету, чтобы мы поняли твои интересы и выбрали идеального бадди для дружбы и помощи в новой стране!", image: "onboarding2"),
        OnboardingData(title: "ОБщaйСЯ Со СTудeнАмИ", description: "Заполни анкету, чтобы мы поняли твои интересы и выбрали идеального бадди для дружбы и помощи в новой стране!", image: "onboarding3")
    ]
    @State private var currentPage = 0
    @AppStorage("hasBeenOnboarding") private var hasBeenOnboarding = false
    var body: some View {
        VStack {
            HStack {
                HStack {
                    if currentPage > 0 {
                        Button(action: {
                            currentPage -= 1
                        }) {
                            p(text:"НАЗАД", colorText: .chorni)
                        }
                    }
                }
                .frame(width: 86, alignment: .leading)
                Spacer()
                Button(action: {
                    hasBeenOnboarding = true
                }) {
                    p(text:("ПРОПУСТИТЬ"), colorText: .chorni)
                }
                
                
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
            .padding(.vertical, 0)
            
            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingView(data: pages[index])
                        
                }
                
            }
            .animation(.easeInOut, value: currentPage)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .padding(.bottom, 8)
            HStack(spacing: 8) {
                ForEach(pages.indices, id: \.self) { index in
                    Rectangle()
                        .fill(Color.chorni)
                        .frame(
                            width: index == currentPage ? 79 : 3,
                            height: 3
                        )
                        .animation(.easeInOut, value: currentPage)
                }
            }
            .padding(.bottom,37)
            if currentPage < pages.count - 1 {
                Button(action: {
                    currentPage += 1
                }) {
                    PrimaryButton(text: "ПРОДОЛЖИТЬ")
                }
            }
            else {
                Button(action: {
                    hasBeenOnboarding = true
                }) {
                    PrimaryButton(text: "НАЧАТЬ")
                }
            }
        }
        .padding(.horizontal,16)
    }
        
    
}



#Preview {
    OnboardingContentView()
}
