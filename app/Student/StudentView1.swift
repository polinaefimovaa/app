import SwiftUI

struct StudentView1: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack (spacing: 32) {
                H1(text: "АНкЕТа")
                Text("Ура, заявка отправлена! Твой бадди свяжется с тобой, как только сможет, а здесь отобразится информация о твоем бадди")
                    .font(.custom("TTHoves-Medium", size: 20))
                    .foregroundColor(.chorni)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,16)
                Image("studentView")
                    .resizable()
            }
            
            
        }
    }
}
