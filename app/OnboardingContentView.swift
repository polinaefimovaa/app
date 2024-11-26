//
//  ContentView.swift
//  app
//
//  Created by Полина Ефимова on 26.11.24.
//

import SwiftUI

struct ContentView: View {
    let pages = [
        OnboardingData(title: "Привет!", description: "Добро пожаловать!"),
        OnboardingData(title: "Функции", description: "Откройте новые функции"),
        OnboardingData(title: "Начнем", description: "Давайте начнем")
    ]
    @State private var currentPage = 0
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
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
