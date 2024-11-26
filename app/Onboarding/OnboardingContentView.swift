//
//  ContentView.swift
//  app
//
//  Created by Полина Ефимова on 26.11.24.
//

import SwiftUI

struct OnboardingContentView: View {
    let pages = [
        OnboardingData(title: "Заполни анкету и познакомься со своим бадди", description: "Начни с заполнения анкеты, чтобы мы могли лучше понять твои интересы и потребности. Это поможет нам подобрать идеального бадди, который станет твоим другом и помощником в новой стране!"),
        OnboardingData(title: "Читай важную информацию про жизнь в России", description: "Узнай о ключевых аспектах жизни в новом городе: от учебных заведений до местных обычаев. Мы собрали полезные советы и рекомендации, чтобы твое пребывание было комфортным и безопасным."),
        OnboardingData(title: "Общайся и отвечай на вопросы в обсуждениях", description: "Присоединяйся к обсуждениям с другими студентами и бадди! Здесь ты можешь задать вопросы, поделиться опытом и получить советы от тех, кто уже прошел через это. Взаимопомощь – залог успешной адаптации!")
    ]
    @State private var currentPage = 0
    @AppStorage("hasBeenOnboarding") private var hasBeenOnboarding = false 
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count) { index in
                    OnboardingView(data: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .
                                               always))
            HStack {
                if currentPage > 0 {
                    Button("Назад"
                           , action: { currentPage -= 1 })
                }
                Spacer()
                if currentPage < pages.count - 1 {
                    Button ("Далее"
                            , action: { currentPage += 1 })
                }
                else {
                    Button ("Начать") {
                        hasBeenOnboarding = true
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingContentView()
}
