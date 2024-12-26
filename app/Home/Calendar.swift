import SwiftUI

struct Calendar: View {
    let text:String
    let color: Color
    var body: some View {
        HStack (spacing: 4) {
            Circle()
                .foregroundColor(color)
                .frame(width: 12, height:12)
            Text(text)
                .font(.custom("TTHoves-Medium", size: 12))
                .foregroundColor(.chorni)
            
        }
        .padding(.bottom,12)
        .overlay(
            Rectangle()
                .frame(height: 1)  // Задаём высоту линии
                .foregroundColor(.chorni), alignment: .bottom)
    }
}


struct CustomCornerShape: Shape {
    var corner: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corner,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct SectionNav: View {
    let text:String
    var body: some View {
        HStack (spacing: 16) {
            Spacer()
            Text(text)
                .font(.custom("TTHoves-Medium", size: 14))
                .foregroundColor(.chorni)
            Image("rightArrow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
        }
    }
}
